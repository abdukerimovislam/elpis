import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../pregnancy/domain/pregnancy_settings.dart';

// --- ÐŸÐžÐœÐžÐ©ÐÐ˜Ðš Ð”Ð›Ð¯ SVG ---
class BloomIcon extends StatelessWidget {
  final String assetPath;
  final Color color;
  final double size;

  const BloomIcon(
    this.assetPath, {
    super.key,
    required this.color,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}

// --- APP BAR ---
class OrbitAppBar extends StatelessWidget {
  final PregnancySettings settings;
  final bool isFruitMode;
  final VoidCallback onToggleMode;
  final VoidCallback onSettingsTap;
  final double depthOpacity;

  const OrbitAppBar({
    super.key,
    required this.settings,
    required this.isFruitMode,
    required this.onToggleMode,
    required this.onSettingsTap,
    required this.depthOpacity,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final scaffoldBg = theme.scaffoldBackgroundColor;
    final cardColor = theme.cardColor;

    final topPadding = MediaQuery.of(context).padding.top;
    final double barHeight = topPadding + 60; // Ð§ÑƒÑ‚ÑŒ ÐºÐ¾Ð¼Ð¿Ð°ÐºÑ‚Ð½ÐµÐµ

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: IgnorePointer(
        ignoring: depthOpacity == 0,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: depthOpacity,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                height: barHeight,
                decoration: BoxDecoration(
                  color: scaffoldBg.withValues(alpha: 0.6),
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.black.withValues(alpha: 0.03),
                          width: 0.5)),
                ),
                padding: EdgeInsets.only(
                  top: topPadding,
                  left: 24,
                  right: 24,
                  bottom: 8,
                ),
                // Ð˜Ð¡ÐŸÐžÐ›Ð¬Ð—Ð£Ð•Ðœ STACK Ð’ÐœÐ•Ð¡Ð¢Ðž ROW Ð”Ð›Ð¯ Ð˜Ð”Ð•ÐÐ›Ð¬ÐÐžÐ“Ðž Ð¦Ð•ÐÐ¢Ð Ð
                child: Stack(
                  alignment:
                      Alignment.center, // Ð¦ÐµÐ½Ñ‚Ñ€Ð¸Ñ€ÑƒÐµÑ‚ Ð¿Ñ€Ð¾Ñ„Ð¸Ð»ÑŒ
                  children: [
                    // Ð›Ð•Ð’Ðž: ÐŸÐµÑ€ÐµÐºÐ»ÑŽÑ‡Ð°Ñ‚ÐµÐ»ÑŒ Ñ€ÐµÐ¶Ð¸Ð¼Ð°
                    Positioned(
                      left: 0,
                      child: GestureDetector(
                        onTap: onToggleMode,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: cardColor.withValues(alpha: 0.5),
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: cardColor.withValues(alpha: 0.8)),
                          ),
                        ),
                      ),
                    ),

                    // Ð¦Ð•ÐÐ¢Ð : ÐŸÑ€Ð¾Ñ„Ð¸Ð»ÑŒ (Ð’ÑÑ‚Ð°ÐµÑ‚ Ð¿Ð¾ Ñ†ÐµÐ½Ñ‚Ñ€Ñƒ Ð±Ð»Ð°Ð³Ð¾Ð´Ð°Ñ€Ñ Stack alignment)
                    GestureDetector(
                      onTap: onSettingsTap,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: scaffoldBg,
                            border: Border.all(
                                color: primaryColor.withValues(alpha: 0.3),
                                width: 2),
                            boxShadow: [
                              BoxShadow(
                                  color: primaryColor.withValues(alpha: 0.1),
                                  blurRadius: 10,
                                  spreadRadius: 2)
                            ]),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/profile.png',
                            width: 44,
                            height: 44,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.person,
                                  color: primaryColor.withValues(alpha: 0.5));
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- NAV BAR ---
class OrbitNavBar extends StatelessWidget {
  final String labelHome;
  final String labelTools;
  final String labelDiary;
  final VoidCallback onToolsTap;
  final VoidCallback onDiaryTap;

  const OrbitNavBar({
    super.key,
    required this.labelHome,
    required this.labelTools,
    required this.labelDiary,
    required this.onToolsTap,
    required this.onDiaryTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navBgColor = theme.cardColor.withValues(alpha: 0.85);

    return Positioned(
      bottom:
          32, // Ð§ÑƒÑ‚ÑŒ Ð²Ñ‹ÑˆÐµ Ð¾Ñ‚ ÐºÑ€Ð°Ñ Ð´Ð»Ñ ÑÐ¾Ð²Ñ€ÐµÐ¼ÐµÐ½Ð½Ñ‹Ñ… iPhone
      left: 24,
      right: 24,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
                color: navBgColor,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _NavItem(
                    icon: CupertinoIcons.square_grid_2x2,
                    label: labelTools,
                    isActive: false,
                    onTap: onToolsTap),
                _NavItem(
                    icon: CupertinoIcons.house_alt,
                    label: labelHome,
                    isActive: true,
                    onTap: () {}),
                _NavItem(
                    icon: CupertinoIcons.book,
                    label: labelDiary,
                    isActive: false,
                    onTap: onDiaryTap),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;

    final color = isActive ? primaryColor : mutedColor.withValues(alpha: 0.5);
    final scale = isActive ? 1.2 : 1.0;

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      behavior: HitTestBehavior.opaque,
      child: Transform.scale(
        scale: scale,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Icon(icon, color: color, size: 28),
        ),
      ),
    );
  }
}
