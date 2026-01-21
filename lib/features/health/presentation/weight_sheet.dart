import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart'; // Для форматирования дат
import '../../../l10n/app_localizations.dart';

import '../../pregnancy/data/pregnancy_repository.dart';
import '../domain/weight_calculator.dart';
import '../../health/domain/health_record.dart'; // Импорт модели записи здоровья

class WeightSheet extends ConsumerStatefulWidget {
  const WeightSheet({super.key});

  @override
  ConsumerState<WeightSheet> createState() => _WeightSheetState();
}

class _WeightSheetState extends ConsumerState<WeightSheet> {
  double _currentWeight = 60.0;

  // Данные
  double? _startWeight;
  double? _height;
  int _currentWeek = 1;
  bool _isLoading = true;
  List<HealthRecord> _history = []; // История веса

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final repo = ref.read(pregnancyRepositoryProvider);

    // 1. Настройки
    final settings = await repo.watchSettings().first;
    if (settings != null) {
      _startWeight = settings.prePregnancyWeightKg;
      _height = settings.heightCm;
      _currentWeek = settings.currentWeek;
      if (_startWeight != null) _currentWeight = _startWeight!;
    }

    // 2. История веса
    final weights = await repo.getWeights();

    // Сортируем по дате (старые -> новые) для графика
    weights.sort((a, b) => a.date.compareTo(b.date));

    // Ищем запись за сегодня
    if (weights.isNotEmpty) {
      final now = DateTime.now();
      final todayRecord = weights.where((w) =>
      w.date.year == now.year &&
          w.date.month == now.month &&
          w.date.day == now.day
      ).firstOrNull;

      if (todayRecord != null && todayRecord.weightKg != null) {
        _currentWeight = todayRecord.weightKg!;
      } else if (weights.isNotEmpty) {
        // Или последний известный вес
        _currentWeight = weights.last.weightKg ?? _currentWeight;
      }
    }

    if (mounted) {
      setState(() {
        _history = weights; // Сохраняем историю
        _isLoading = false;
      });
    }
  }

  Future<void> _saveData() async {
    final repo = ref.read(pregnancyRepositoryProvider);
    await repo.saveWeight(_currentWeight, DateTime.now());
    HapticFeedback.mediumImpact();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final mainTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final bgColor = theme.scaffoldBackgroundColor;

    String feedback = l10n.weightInputHint;
    Color feedbackColor = mutedColor;

    if (_startWeight != null && _height != null) {
      final gain = _currentWeight - _startWeight!;
      final bmi = WeightCalculator.calculateBMI(_startWeight!, _height!);
      final range = WeightCalculator.getRangeForWeek(bmi, _currentWeek);
      feedback = WeightCalculator.getFeedback(gain, range.min, range.max, l10n);
      feedbackColor = primaryColor;
    } else if (_startWeight == null) {
      feedback = l10n.weightNoParams;
    }

    if (_isLoading) {
      return Container(
        height: 400,
        decoration: BoxDecoration(color: bgColor, borderRadius: const BorderRadius.vertical(top: Radius.circular(32))),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return Container(
      // Увеличиваем высоту шторки почти на весь экран, так как контента стало больше
      height: MediaQuery.of(context).size.height * 0.92,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          // HEADER
          const SizedBox(height: 16),
          Container(
              width: 40, height: 4,
              decoration: BoxDecoration(color: mutedColor.withOpacity(0.2), borderRadius: BorderRadius.circular(2))
          ),
          const SizedBox(height: 24),
          Text(l10n.weightTitle, style: theme.textTheme.displayLarge?.copyWith(fontSize: 24)),
          const SizedBox(height: 8),
          Text(l10n.weightWeek(_currentWeek), style: theme.textTheme.labelSmall),

          // SCROLLABLE CONTENT
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 32),

                  // 1. ТЕКУЩИЙ ВЕС (БОЛЬШОЙ ТЕКСТ)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        _currentWeight.toStringAsFixed(1),
                        style: theme.textTheme.displayLarge?.copyWith(
                            fontSize: 72,
                            color: mainTextColor,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(l10n.weightUnit, style: theme.textTheme.bodyMedium?.copyWith(fontSize: 24, color: mutedColor)),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // 2. РУЛЕТКА
                  SizedBox(
                    height: 100,
                    child: _WeightRuler(
                      initialWeight: _currentWeight,
                      primaryColor: primaryColor,
                      onChanged: (val) => setState(() => _currentWeight = val),
                    ),
                  ),
                  Icon(Icons.arrow_drop_up, size: 40, color: primaryColor),

                  const SizedBox(height: 24),

                  // 3. АНАЛИЗ (КАРТОЧКА)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest ?? Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.insights, color: feedbackColor),
                        const SizedBox(width: 16),
                        Expanded(child: Text(feedback, style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14))),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // 4. ГРАФИК (НОВОЕ)
                  if (_history.length > 1) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Progress Chart", style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 150,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: CustomPaint(
                        painter: _SimpleCurvePainter(
                          data: _history,
                          color: primaryColor,
                          gridColor: mutedColor.withOpacity(0.1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],

                  // 5. ИСТОРИЯ ЗАПИСЕЙ (НОВОЕ)
                  if (_history.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Recent History", style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      itemCount: _history.length > 5 ? 5 : _history.length, // Показываем последние 5
                      separatorBuilder: (_, __) => Divider(height: 1, color: mutedColor.withOpacity(0.1)),
                      itemBuilder: (context, index) {
                        // Показываем в обратном порядке (новые сверху)
                        final item = _history[_history.length - 1 - index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat.yMMMd().format(item.date),
                                style: theme.textTheme.bodyMedium?.copyWith(color: mutedColor),
                              ),
                              Text(
                                "${item.weightKg?.toStringAsFixed(1)} ${l10n.weightUnit}",
                                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: mainTextColor),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 40), // Отступ внизу скролла
                  ],
                ],
              ),
            ),
          ),

          // BUTTON
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  elevation: 0,
                ),
                child: Text(l10n.weightSave, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- ВИДЖЕТ РУЛЕТКИ ---
class _WeightRuler extends StatefulWidget {
  final double initialWeight;
  final ValueChanged<double> onChanged;
  final Color primaryColor;

  const _WeightRuler({
    required this.initialWeight,
    required this.onChanged,
    required this.primaryColor,
  });

  @override
  State<_WeightRuler> createState() => _WeightRulerState();
}

class _WeightRulerState extends State<_WeightRuler> {
  late ScrollController _scrollController;
  final double _itemWidth = 10.0;
  final double _minWeight = 30.0;
  final double _maxWeight = 200.0;

  @override
  void initState() {
    super.initState();
    final initialOffset = (widget.initialWeight - _minWeight) * 10 * _itemWidth;
    _scrollController = ScrollController(initialScrollOffset: initialOffset);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final index = offset / _itemWidth;
    final weight = _minWeight + (index / 10);
    final roundedWeight = (weight * 10).round() / 10;

    if (roundedWeight >= _minWeight && roundedWeight <= _maxWeight) {
      widget.onChanged(roundedWeight);
      HapticFeedback.selectionClick();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = ((_maxWeight - _minWeight) * 10).toInt();
    final screenCenter = MediaQuery.of(context).size.width / 2;

    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: screenCenter - _itemWidth / 2),
      itemCount: itemCount + 1,
      itemBuilder: (context, index) {
        final isInteger = index % 10 == 0;
        final isHalf = index % 5 == 0 && !isInteger;
        double height = isInteger ? 70 : (isHalf ? 50 : 40);
        double thickness = isInteger ? 2.5 : 1.5;
        final value = (_minWeight + index / 10).toInt();

        return SizedBox(
          width: _itemWidth,
          child: Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                width: thickness,
                height: height,
                decoration: BoxDecoration(
                  color: isInteger ? widget.primaryColor : widget.primaryColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              if (isInteger)
                Positioned(
                  top: 0, left: -20, right: -20,
                  child: Center(
                    child: Text("$value",
                        softWrap: false,
                        overflow: TextOverflow.visible,
                        style: TextStyle(color: widget.primaryColor.withOpacity(0.8), fontSize: 12, fontWeight: FontWeight.bold)
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

// --- ВИДЖЕТ ГРАФИКА (CustomPainter) ---
class _SimpleCurvePainter extends CustomPainter {
  final List<HealthRecord> data;
  final Color color;
  final Color gridColor;

  _SimpleCurvePainter({required this.data, required this.color, required this.gridColor});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // 1. Находим мин/макс значения
    double minWeight = double.infinity;
    double maxWeight = double.negativeInfinity;
    int minTime = data.first.date.millisecondsSinceEpoch;
    int maxTime = data.last.date.millisecondsSinceEpoch;

    for (var d in data) {
      if (d.weightKg == null) continue;
      if (d.weightKg! < minWeight) minWeight = d.weightKg!;
      if (d.weightKg! > maxWeight) maxWeight = d.weightKg!;
    }

    // Добавляем отступы сверху/снизу графика для красоты
    minWeight -= 1;
    maxWeight += 1;

    // Защита от деления на ноль, если вес одинаковый
    if (maxWeight == minWeight) maxWeight += 1;
    if (maxTime == minTime) maxTime += 1000;

    // 2. Рисуем сетку (опционально, 3 линии)
    final gridPaint = Paint()..color = gridColor..strokeWidth = 1;
    for (int i = 0; i <= 2; i++) {
      double y = size.height * (i / 2);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // 3. Строим путь (кривую)
    final path = Path();
    // Нормализация:
    // x = (time - minTime) / (maxTime - minTime) * width
    // y = height - (weight - minWeight) / (maxWeight - minWeight) * height (инверсия Y)

    Offset? firstPoint;

    for (int i = 0; i < data.length; i++) {
      if (data[i].weightKg == null) continue;

      final x = (data[i].date.millisecondsSinceEpoch - minTime) / (maxTime - minTime) * size.width;
      final y = size.height - ((data[i].weightKg! - minWeight) / (maxWeight - minWeight) * size.height);

      if (i == 0) {
        path.moveTo(x, y);
        firstPoint = Offset(x, y);
      } else {
        // Используем кубическую кривую для плавности
        // Простое сглаживание: контрольная точка посередине по X
        final prevX = (data[i-1].date.millisecondsSinceEpoch - minTime) / (maxTime - minTime) * size.width;
        final prevY = size.height - ((data[i-1].weightKg! - minWeight) / (maxWeight - minWeight) * size.height);

        final cp1x = prevX + (x - prevX) / 2;
        final cp1y = prevY;
        final cp2x = prevX + (x - prevX) / 2;
        final cp2y = y;

        path.cubicTo(cp1x, cp1y, cp2x, cp2y, x, y);
      }

      // Точка (кружок)
      canvas.drawCircle(Offset(x, y), 4, Paint()..color = color);
      canvas.drawCircle(Offset(x, y), 2, Paint()..color = Colors.white);
    }

    canvas.drawPath(path, paint);

    // 4. Заливка под графиком (Gradient)
    if (firstPoint != null) {
      final fillPath = Path.from(path);
      fillPath.lineTo(size.width, size.height);
      fillPath.lineTo(0, size.height);
      fillPath.close();
      canvas.drawPath(fillPath, fillPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}