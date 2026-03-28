import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Ð˜Ð¼Ð¿Ð¾Ñ€Ñ‚ Ñ‚ÐµÐ¼Ñ‹ Ð±Ð¾Ð»ÑŒÑˆÐµ Ð½Ðµ Ð½ÑƒÐ¶ÐµÐ½, Ð±ÐµÑ€ÐµÐ¼ Ð²ÑÑ‘ Ð¸Ð· context
// import '../../../core/theme/app_theme.dart';

class CelestialDial extends StatefulWidget {
  final int currentWeek; // Ð¢Ð°, ÐºÐ¾Ñ‚Ð¾Ñ€ÑƒÑŽ ÑÐµÐ¹Ñ‡Ð°Ñ Ð¡ÐœÐžÐ¢Ð Ð˜Ðœ
  final int
      realWeek; // Ð¢Ð°, ÐºÐ¾Ñ‚Ð¾Ñ€Ð°Ñ Ð½Ð° ÑÐ°Ð¼Ð¾Ð¼ Ð´ÐµÐ»Ðµ Ð¡Ð•Ð“ÐžÐ”ÐÐ¯ (Ð¸Ð· Ð½Ð°ÑÑ‚Ñ€Ð¾ÐµÐº)
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
  // --- ÐšÐžÐÐ¡Ð¢ÐÐÐ¢Ð« UI ---
  static const int _totalWeeks = 42;
  static const double _widgetHeight = 60.0;
  static const double _viewportFraction = 0.2;
  static const double _fontSize = 20.0;
  static const double _indicatorSize = 4.0;

  // ÐÐ½Ð¸Ð¼Ð°Ñ†Ð¸Ñ Ð¸ Ð¼Ð°ÑÑˆÑ‚Ð°Ð±
  static const Duration _scrollDuration = Duration(milliseconds: 300);
  static const Duration _scaleDuration = Duration(milliseconds: 200);
  static const double _selectedScale = 1.2;
  static const double _unselectedScale = 0.8;
  static const double _unselectedOpacity = 0.4;

  late PageController _controller;

  @override
  void initState() {
    super.initState();
    // Ð˜Ð½Ð¸Ñ†Ð¸Ð°Ð»Ð¸Ð·Ð¸Ñ€ÑƒÐµÐ¼ ÐºÐ¾Ð½Ñ‚Ñ€Ð¾Ð»Ð»ÐµÑ€ Ð½Ð° Ð²Ñ‹Ð±Ñ€Ð°Ð½Ð½Ð¾Ð¹ Ð½ÐµÐ´ÐµÐ»Ðµ (Ð¼Ð¸Ð½ÑƒÑ 1, Ñ‚.Ðº. Ð¸Ð½Ð´ÐµÐºÑ Ñ 0)
    _controller = PageController(
        initialPage: widget.currentWeek - 1,
        viewportFraction: _viewportFraction);
  }

  @override
  void didUpdateWidget(CelestialDial oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Ð•ÑÐ»Ð¸ Ð½ÐµÐ´ÐµÐ»ÑŽ Ð¸Ð·Ð¼ÐµÐ½Ð¸Ð»Ð¸ Ð¸Ð·Ð²Ð½Ðµ (Ð½Ð°Ð¿Ñ€Ð¸Ð¼ÐµÑ€, ÐºÐ½Ð¾Ð¿ÐºÐ¾Ð¹ ÑÐ±Ñ€Ð¾ÑÐ°), ÐºÑ€ÑƒÑ‚Ð¸Ð¼ ÐºÐ¾Ð»ÐµÑÐ¾
    if (widget.currentWeek != oldWidget.currentWeek) {
      if (_controller.hasClients &&
          _controller.page?.round() != widget.currentWeek - 1) {
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
    // ÐŸÐžÐ›Ð£Ð§ÐÐ•Ðœ Ð¢Ð•ÐœÐ£
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
          widget.onWeekChanged(index +
              1); // +1, Ñ‚.Ðº. Ð½ÐµÐ´ÐµÐ»Ð¸ Ñ 1, Ð° Ð¸Ð½Ð´ÐµÐºÑÑ‹ Ñ 0
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
              transform: Matrix4.diagonal3Values(
                isSelected ? _selectedScale : _unselectedScale,
                isSelected ? _selectedScale : _unselectedScale,
                1.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "$week",
                    style: TextStyle(
                      // Ð˜ÑÐ¿Ð¾Ð»ÑŒÐ·ÑƒÐµÐ¼ Ð´Ð¸Ð½Ð°Ð¼Ð¸Ñ‡ÐµÑÐºÐ¸Ðµ Ñ†Ð²ÐµÑ‚Ð°
                      color: isSelected
                          ? mainTextColor
                          : mutedTextColor.withValues(
                              alpha: _unselectedOpacity),
                      fontSize: _fontSize,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Ð˜Ð½Ð´Ð¸ÐºÐ°Ñ‚Ð¾Ñ€ Ñ€ÐµÐ°Ð»ÑŒÐ½Ð¾Ð¹ Ð½ÐµÐ´ÐµÐ»Ð¸ (Ð¼Ð°Ð»ÐµÐ½ÑŒÐºÐ°Ñ Ñ‚Ð¾Ñ‡ÐºÐ° ÑÐ½Ð¸Ð·Ñƒ)
                  if (isReal)
                    Container(
                      width: _indicatorSize,
                      height: _indicatorSize,
                      decoration: BoxDecoration(
                        color:
                            primaryColor, // Ð”Ð¸Ð½Ð°Ð¼Ð¸Ñ‡ÐµÑÐºÐ¸Ð¹ Ñ†Ð²ÐµÑ‚
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
