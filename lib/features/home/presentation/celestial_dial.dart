import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Импорт темы больше не нужен, берем всё из context
// import '../../../core/theme/app_theme.dart';

class CelestialDial extends StatefulWidget {
  final int currentWeek; // Та, которую сейчас СМОТРИМ
  final int realWeek;    // Та, которая на самом деле СЕГОДНЯ (из настроек)
  final ValueChanged<int> onWeekChanged;

  const CelestialDial({
    super.key,
    required this.currentWeek,
    required this.realWeek,
    required this.onWeekChanged,
  });

  @override
  State<CelestialDial> createState() => _CelestialDialState();
}

class _CelestialDialState extends State<CelestialDial> {
  // --- КОНСТАНТЫ UI ---
  static const int _totalWeeks = 42;
  static const double _widgetHeight = 60.0;
  static const double _viewportFraction = 0.2;
  static const double _fontSize = 20.0;
  static const double _indicatorSize = 4.0;

  // Анимация и масштаб
  static const Duration _scrollDuration = Duration(milliseconds: 300);
  static const Duration _scaleDuration = Duration(milliseconds: 200);
  static const double _selectedScale = 1.2;
  static const double _unselectedScale = 0.8;
  static const double _unselectedOpacity = 0.4;

  late PageController _controller;

  @override
  void initState() {
    super.initState();
    // Инициализируем контроллер на выбранной неделе (минус 1, т.к. индекс с 0)
    _controller = PageController(
        initialPage: widget.currentWeek - 1,
        viewportFraction: _viewportFraction
    );
  }

  @override
  void didUpdateWidget(CelestialDial oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Если неделю изменили извне (например, кнопкой сброса), крутим колесо
    if (widget.currentWeek != oldWidget.currentWeek) {
      if (_controller.hasClients && _controller.page?.round() != widget.currentWeek - 1) {
        _controller.animateToPage(
          widget.currentWeek - 1,
          duration: _scrollDuration,
          curve: Curves.easeOut,
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ПОЛУЧАЕМ ТЕМУ
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final mainTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final mutedTextColor = theme.textTheme.labelSmall?.color ?? Colors.grey;

    return SizedBox(
      height: _widgetHeight,
      child: PageView.builder(
        controller: _controller,
        itemCount: _totalWeeks,
        onPageChanged: (index) {
          HapticFeedback.selectionClick();
          widget.onWeekChanged(index + 1); // +1, т.к. недели с 1, а индексы с 0
        },
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final week = index + 1;
          final isSelected = week == widget.currentWeek;
          final isReal = week == widget.realWeek;

          return Center(
            child: AnimatedContainer(
              duration: _scaleDuration,
              curve: Curves.easeOut,
              transform: Matrix4.identity()..scale(isSelected ? _selectedScale : _unselectedScale),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "$week",
                    style: TextStyle(
                      // Используем динамические цвета
                      color: isSelected
                          ? mainTextColor
                          : mutedTextColor.withOpacity(_unselectedOpacity),
                      fontSize: _fontSize,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Индикатор реальной недели (маленькая точка снизу)
                  if (isReal)
                    Container(
                      width: _indicatorSize,
                      height: _indicatorSize,
                      decoration: BoxDecoration(
                        color: primaryColor, // Динамический цвет
                        shape: BoxShape.circle,
                      ),
                    )
                  else
                    const SizedBox(height: 4),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}