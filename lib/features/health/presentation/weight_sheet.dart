import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';
import '../../health/domain/health_record.dart';
import '../../pregnancy/data/pregnancy_repository.dart';
import '../domain/weight_calculator.dart';

class WeightSheet extends ConsumerStatefulWidget {
  const WeightSheet({super.key});

  @override
  ConsumerState<WeightSheet> createState() => _WeightSheetState();
}

class _WeightSheetState extends ConsumerState<WeightSheet> {
  double _currentWeight = 60.0;
  double? _startWeight;
  double? _height;
  int _currentWeek = 1;
  bool _isLoading = true;
  bool _isSaving = false;
  List<HealthRecord> _history = [];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final repo = ref.read(pregnancyRepositoryProvider);
    // ✅ ИСПРАВЛЕНО: Используем getSettings() вместо watchSettings().first.
    // watchSettings().first могло зависнуть навсегда если Isar не открылся.
    final settings = await repo.getSettings();

    if (settings != null) {
      _startWeight = settings.prePregnancyWeightKg;
      _height = settings.heightCm;
      _currentWeek = settings.currentWeek;
      if (_startWeight != null) {
        _currentWeight = _startWeight!;
      }
    }

    final weights = await repo.getWeights();
    weights.sort((a, b) => a.date.compareTo(b.date));

    if (weights.isNotEmpty) {
      final now = DateTime.now();
      final todayRecord = weights
          .where(
            (weight) =>
                weight.date.year == now.year &&
                weight.date.month == now.month &&
                weight.date.day == now.day,
          )
          .firstOrNull;

      if (todayRecord != null && todayRecord.weightKg != null) {
        _currentWeight = todayRecord.weightKg!;
      } else {
        _currentWeight = weights.last.weightKg ?? _currentWeight;
      }
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _history = weights;
      _isLoading = false;
    });
  }

  Future<void> _saveData() async {
    if (_isSaving) {
      return;
    }

    setState(() => _isSaving = true);

    try {
      await ref
          .read(pregnancyRepositoryProvider)
          .saveWeight(_currentWeight, DateTime.now());
      HapticFeedback.mediumImpact();
      if (!mounted) {
        return;
      }
      Navigator.pop(context);
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.errorGeneric)),
      );
      setState(() => _isSaving = false);
    }
  }

  Future<void> _openPersonalizeDialog() async {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final bgColor = theme.scaffoldBackgroundColor;
    final primaryColor = theme.primaryColor;

    final weightController =
        TextEditingController(text: _startWeight?.toStringAsFixed(1) ?? '');
    final heightController =
        TextEditingController(text: _height?.toStringAsFixed(0) ?? '');

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: bgColor,
        title: Text(l10n.weightPersonalizeTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: heightController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: l10n.weightHeightLabel,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: weightController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: l10n.weightPrePregnancyLabel,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.commonCancel,
                style: const TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () async {
              final h =
                  double.tryParse(heightController.text.replaceAll(',', '.'));
              final w =
                  double.tryParse(weightController.text.replaceAll(',', '.'));
              if (h != null && w != null && h > 100 && w > 30) {
                await ref.read(pregnancyRepositoryProvider).updateSettings(
                      height: h,
                      prePregnancyWeight: w,
                    );
                if (!mounted || !ctx.mounted) return;
                Navigator.pop(ctx);
                _loadInitialData(); // Reload UI
              }
            },
            child: Text(l10n.commonSave,
                style: TextStyle(
                    color: primaryColor, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
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
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.92,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: mutedColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.weightTitle,
            style: theme.textTheme.displayLarge?.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 8),
          Text(l10n.weightWeek(_currentWeek),
              style: theme.textTheme.labelSmall),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final controller = TextEditingController(
                              text: _currentWeight.toStringAsFixed(1));
                          final newWeight = await showDialog<double>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                      backgroundColor: bgColor,
                                      title: Text(l10n.weightTitle),
                                      content: TextField(
                                        controller: controller,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(decimal: true),
                                        autofocus: true,
                                        style: const TextStyle(fontSize: 24),
                                        textAlign: TextAlign.center,
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () => Navigator.pop(ctx),
                                            child: Text(l10n.commonCancel,
                                                style: TextStyle(
                                                    color: mutedColor))),
                                        TextButton(
                                            onPressed: () => Navigator.pop(
                                                ctx,
                                                double.tryParse(controller.text
                                                    .replaceAll(',', '.'))),
                                            child: Text(l10n.commonSave,
                                                style: TextStyle(
                                                    color: primaryColor))),
                                      ]));
                          if (newWeight != null &&
                              newWeight >= 30 &&
                              newWeight <= 200) {
                            setState(() => _currentWeight = newWeight);
                          }
                        },
                        child: Text(
                          _currentWeight.toStringAsFixed(1),
                          style: theme.textTheme.displayLarge?.copyWith(
                            fontSize: 72,
                            color: mainTextColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: mutedColor.withValues(alpha: 0.3),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.weightUnit,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 24,
                          color: mutedColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 100,
                    child: _WeightRuler(
                      initialWeight: _currentWeight,
                      primaryColor: primaryColor,
                      onChanged: (value) =>
                          setState(() => _currentWeight = value),
                    ),
                  ),
                  Icon(Icons.arrow_drop_up, size: 40, color: primaryColor),
                  const SizedBox(height: 24),

                  // Total Gain & Range Info Card
                  if (_startWeight != null && _height != null) ...[
                    Builder(builder: (context) {
                      final gain = _currentWeight - _startWeight!;
                      final bmi = WeightCalculator.calculateBMI(
                          _startWeight!, _height!);
                      final range =
                          WeightCalculator.getRangeForWeek(bmi, _currentWeek);

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              primaryColor.withValues(alpha: 0.1),
                              primaryColor.withValues(alpha: 0.02),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                              color: primaryColor.withValues(alpha: 0.2)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(l10n.weightTotalGain,
                                        style: TextStyle(
                                            color: mutedColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${gain > 0 ? '+' : ''}${gain.toStringAsFixed(1)} ${l10n.weightUnit}',
                                      style: TextStyle(
                                          color: mainTextColor,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 1,
                                  height: 40,
                                  color: primaryColor.withValues(alpha: 0.2),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(l10n.weightRecommended,
                                        style: TextStyle(
                                            color: mutedColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${range.min.toStringAsFixed(1)} - ${range.max.toStringAsFixed(1)} ${l10n.weightUnit}',
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.insights_rounded,
                                      color: feedbackColor, size: 20),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      feedback,
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(fontSize: 13, height: 1.3),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ] else ...[
                    GestureDetector(
                      onTap: _openPersonalizeDialog,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.withValues(alpha: 0.1),
                              Colors.grey.withValues(alpha: 0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                              color: Colors.grey.withValues(alpha: 0.2),
                              width: 1),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          Colors.black.withValues(alpha: 0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4)),
                                ],
                              ),
                              child: Icon(Icons.settings_suggest_rounded,
                                  color: primaryColor),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.weightPersonalizeTitle,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: mainTextColor),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    l10n.weightPersonalizeDesc,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: mutedColor,
                                        height: 1.3),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 40),
                  if (_history.length > 1) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          l10n.weightChartTitle,
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                          gridColor: mutedColor.withValues(alpha: 0.1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                  if (_history.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          l10n.weightHistoryTitle,
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      itemCount: _history.length > 5 ? 5 : _history.length,
                      separatorBuilder: (_, __) => Divider(
                        height: 1,
                        color: mutedColor.withValues(alpha: 0.1),
                      ),
                      itemBuilder: (context, index) {
                        final currentIdx = _history.length - 1 - index;
                        final item = _history[currentIdx];

                        double? delta;
                        if (currentIdx > 0 &&
                            _history[currentIdx - 1].weightKg != null &&
                            item.weightKg != null) {
                          delta = item.weightKg! -
                              _history[currentIdx - 1].weightKg!;
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: theme
                                      .colorScheme.surfaceContainerHighest
                                      .withValues(alpha: 0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.monitor_weight_outlined,
                                    size: 18, color: mutedColor),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DateFormat.yMMMd().format(item.date),
                                    style: theme.textTheme.bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  if (delta != null && delta != 0)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Row(
                                        children: [
                                          Icon(
                                            delta > 0
                                                ? Icons.trending_up
                                                : Icons.trending_down,
                                            size: 12,
                                            color: delta > 0
                                                ? Colors.orange
                                                : Colors.green,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${delta > 0 ? '+' : ''}${delta.toStringAsFixed(1)} ${l10n.weightUnit}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: delta > 0
                                                  ? Colors.orange
                                                  : Colors.green,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              const Spacer(),
                              Text(
                                '${item.weightKg?.toStringAsFixed(1)} ${l10n.weightUnit}',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                  color: mainTextColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _saveData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  elevation: 0,
                ),
                child: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        l10n.weightSave,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
        final height = isInteger ? 70.0 : (isHalf ? 50.0 : 40.0);
        final thickness = isInteger ? 2.5 : 1.5;
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
                  color: isInteger
                      ? widget.primaryColor
                      : widget.primaryColor.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              if (isInteger)
                Positioned(
                  top: 0,
                  left: -20,
                  right: -20,
                  child: Center(
                    child: Text(
                      '$value',
                      softWrap: false,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: widget.primaryColor.withValues(alpha: 0.8),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
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

class _SimpleCurvePainter extends CustomPainter {
  final List<HealthRecord> data;
  final Color color;
  final Color gridColor;

  _SimpleCurvePainter({
    required this.data,
    required this.color,
    required this.gridColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) {
      return;
    }

    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..color = color.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    double minWeight = double.infinity;
    double maxWeight = double.negativeInfinity;
    int minTime = data.first.date.millisecondsSinceEpoch;
    int maxTime = data.last.date.millisecondsSinceEpoch;

    for (final item in data) {
      if (item.weightKg == null) {
        continue;
      }
      if (item.weightKg! < minWeight) {
        minWeight = item.weightKg!;
      }
      if (item.weightKg! > maxWeight) {
        maxWeight = item.weightKg!;
      }
    }

    minWeight -= 1;
    maxWeight += 1;

    if (maxWeight == minWeight) {
      maxWeight += 1;
    }
    if (maxTime == minTime) {
      maxTime += 1000;
    }

    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1;

    for (int index = 0; index <= 2; index++) {
      final y = size.height * (index / 2);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final path = Path();
    Offset? firstPoint;

    for (int index = 0; index < data.length; index++) {
      if (data[index].weightKg == null) {
        continue;
      }

      final x = (data[index].date.millisecondsSinceEpoch - minTime) /
          (maxTime - minTime) *
          size.width;
      final y = size.height -
          ((data[index].weightKg! - minWeight) /
              (maxWeight - minWeight) *
              size.height);

      if (index == 0) {
        path.moveTo(x, y);
        firstPoint = Offset(x, y);
      } else {
        final previousX =
            (data[index - 1].date.millisecondsSinceEpoch - minTime) /
                (maxTime - minTime) *
                size.width;
        // ✅ ИСПРАВЛЕНО: Проверяем null у предыдущей записи перед force unwrap
        final prevWeight = data[index - 1].weightKg;
        if (prevWeight == null) continue;
        final previousY = size.height -
            ((prevWeight - minWeight) / (maxWeight - minWeight) * size.height);

        final cp1x = previousX + (x - previousX) / 2;
        final cp2x = previousX + (x - previousX) / 2;

        path.cubicTo(cp1x, previousY, cp2x, y, x, y);
      }

      canvas.drawCircle(Offset(x, y), 4, Paint()..color = color);
      canvas.drawCircle(Offset(x, y), 2, Paint()..color = Colors.white);
    }

    canvas.drawPath(path, paint);

    if (firstPoint != null) {
      final fillPath = Path.from(path)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height)
        ..close();
      canvas.drawPath(fillPath, fillPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
