import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../pregnancy/domain/pregnancy_settings.dart';
import '../../../../l10n/app_localizations.dart';

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
  final VoidCallback onSettingsTap;
  final VoidCallback onProTap;
  final double depthOpacity;

  const OrbitAppBar({
    super.key,
    required this.settings,
    required this.onSettingsTap,
    required this.onProTap,
    required this.depthOpacity,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final scaffoldBg = theme.scaffoldBackgroundColor;
    final l10n = AppLocalizations.of(context)!;

    final topPadding = MediaQuery.of(context).padding.top;
    final double barHeight = topPadding + 60;

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
                      width: 0.5,
                    ),
                  ),
                ),
                padding: EdgeInsets.only(
                  top: topPadding,
                  left: 24,
                  right: 24,
                  bottom: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Приветствие с именем мамы
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _greeting(context),
                            style: TextStyle(
                              fontSize: 11,
                              color: theme.textTheme.labelSmall?.color
                                  ?.withValues(alpha: 0.55),
                              letterSpacing: 0.5,
                            ),
                          ),
                          if (settings.momName != null &&
                              settings.momName!.isNotEmpty)
                            Text(
                              settings.momName!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: theme.textTheme.bodyLarge?.color,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                    // Animated PRO badge
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        onProTap();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              theme.primaryColor,
                              theme.primaryColor.withValues(alpha: 0.7)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: theme.primaryColor.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.workspace_premium_rounded,
                                color: Colors.white, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              l10n.paywallProBadge,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      )
                          .animate(
                              onPlay: (controller) =>
                                  controller.repeat(reverse: true))
                          .shimmer(
                              duration: const Duration(milliseconds: 2500),
                              color: Colors.white.withValues(alpha: 0.5))
                          .scaleXY(
                              begin: 1.0,
                              end: 1.02,
                              duration: const Duration(milliseconds: 1500),
                              curve: Curves.easeInOut),
                    ),
                    // Аватар / настройки
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
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withValues(alpha: 0.1),
                              blurRadius: 10,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/profile.png',
                            width: 44,
                            height: 44,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.person,
                                color: primaryColor.withValues(alpha: 0.5),
                              );
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

  String _greeting(BuildContext context) {
    final hour = DateTime.now().hour;
    final l10n = AppLocalizations.of(context)!;
    if (hour < 6) return l10n.greetingNight;
    if (hour < 12) return l10n.greetingMorning;
    if (hour < 17) return l10n.greetingAfternoon;
    return l10n.greetingEvening;
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
    final primaryColor = theme.primaryColor;

    return Positioned(
      bottom: 30,
      left: 24,
      right: 24,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            height: 78,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.88),
                  theme.colorScheme.surface.withValues(alpha: 0.82),
                ],
              ),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: primaryColor.withValues(alpha: 0.10),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.10),
                  blurRadius: 26,
                  offset: const Offset(0, 14),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _NavItem(
                      icon: CupertinoIcons.square_grid_2x2,
                      label: labelTools,
                      isActive: false,
                      onTap: onToolsTap),
                ),
                Expanded(
                  child: _NavItem(
                      icon: CupertinoIcons.house_alt,
                      label: labelHome,
                      isActive: true,
                      onTap: () {}),
                ),
                Expanded(
                  child: _NavItem(
                      icon: CupertinoIcons.book,
                      label: labelDiary,
                      isActive: false,
                      onTap: onDiaryTap),
                ),
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
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black87;

    final color = isActive ? primaryColor : mutedColor.withValues(alpha: 0.72);
    final scale = isActive ? 1.03 : 1.0;

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      behavior: HitTestBehavior.opaque,
      child: Transform.scale(
        scale: scale,
        child: Align(
          child: Container(
            constraints: const BoxConstraints(minWidth: 78, maxWidth: 96),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isActive
                  ? primaryColor.withValues(alpha: 0.12)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: 22),
                const SizedBox(height: 5),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: isActive
                        ? textColor.withValues(alpha: 0.88)
                        : mutedColor.withValues(alpha: 0.82),
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                    fontSize: 11,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
