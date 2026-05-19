import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../l10n/app_localizations.dart';

// Screens
import 'symptom_sheet.dart';
import 'weight_sheet.dart';
import 'kick_counter_sheet.dart';
import 'water_sheet.dart';
import 'contraction_timer_sheet.dart';
import 'checklist_sheet.dart';
import 'kegel_sheet.dart';
import 'doctor_visits_sheet.dart';
import 'is_it_normal_sheet.dart';
import '../../family/presentation/name_swiper_sheet.dart';
import '../../family/presentation/bump_gallery_sheet.dart';
import '../../subscription/presentation/paywall_sheet.dart';
import '../../subscription/data/subscription_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CareCenterScreen extends ConsumerWidget {
  const CareCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isPro = ref.watch(isProProvider).valueOrNull ?? false;
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: theme.primaryColor),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          l10n.toolsTitle,
          style: theme.textTheme.displayLarge?.copyWith(fontSize: 24, color: theme.primaryColor),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // 1. Анимированный градиентный фон (Вау-эффект)
          const _MeshBackground(),
          
          // 2. Стеклянный фильтр поверх фона
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox.expand(),
            ),
          ),

          // 3. Основной контент (скролл)
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(height: MediaQuery.of(context).padding.top + kToolbarHeight + 20),
              ),

              // ЕЖЕДНЕВНОЕ (Daily)
              _buildSectionHeader(
                context,
                l10n.toolsSectionDaily,
                Icons.wb_sunny_rounded,
                0,
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        child: _WowCard(
                          icon: Icons.water_drop_outlined,
                          title: l10n.toolWater,
                          subtitle: l10n.toolWaterSub,
                          color: const Color(0xFFE0F7FA),
                          onTap: () => _openSheet(context, const WaterSheet()),
                          delay: 100,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _WowCard(
                          icon: Icons.touch_app_outlined,
                          title: l10n.toolKicks,
                          subtitle: l10n.toolKicksSub,
                          color: const Color(0xFFFFF3E0),
                          isLocked: !isPro,
                          onTap: () {
                            if (isPro) {
                              _openFullScreen(context, const KickCounterSheet());
                            } else {
                              _openSheet(context, const PaywallSheet());
                            }
                          },
                          delay: 150,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        child: _WowCard(
                          icon: Icons.scale_outlined,
                          title: l10n.toolWeight,
                          subtitle: l10n.toolWeightSub,
                          color: const Color(0xFFE1F5FE),
                          onTap: () => _openSheet(context, const WeightSheet()),
                          delay: 200,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _WowCard(
                          icon: Icons.fitness_center_outlined,
                          title: l10n.toolKegel,
                          subtitle: l10n.toolKegelSub,
                          color: const Color(0xFFF3E5F5),
                          onTap: () => _openSheet(context, const KegelSheet()),
                          delay: 250,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ЗДОРОВЬЕ (Health)
              _buildSectionHeader(
                context,
                l10n.toolsSectionHealth,
                Icons.favorite_rounded,
                1,
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: _WowCard(
                          icon: Icons.timer_outlined,
                          title: l10n.toolContractions,
                          subtitle: l10n.toolContractionsSub,
                          color: const Color(0xFFE8EAF6),
                          height: 140, 
                          isLocked: !isPro,
                          onTap: () {
                            if (isPro) {
                              _openFullScreen(context, const ContractionTimerSheet());
                            } else {
                              _openSheet(context, const PaywallSheet());
                            }
                          },
                          delay: 300,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            _WowCard(
                              icon: Icons.favorite_border,
                              title: l10n.toolSymptoms,
                              color: const Color(0xFFFFE4E1),
                              height: 64,
                              isSmall: true,
                              onTap: () => _openSheet(context, const SymptomSheet()),
                              delay: 350,
                            ),
                            const SizedBox(height: 12),
                            _WowCard(
                              icon: Icons.calendar_month_outlined,
                              title: l10n.toolVisits,
                              color: const Color(0xFFFFFDE7),
                              height: 64,
                              isSmall: true,
                              onTap: () => _openSheet(context, const DoctorVisitsSheet()),
                              delay: 400,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        child: _WowCard(
                          icon: Icons.healing_outlined,
                          title: l10n.toolIsItNormal,
                          subtitle: l10n.toolIsItNormalSub,
                          color: const Color(0xFFE8F5E9),
                          isLocked: !isPro,
                          onTap: () {
                            if (isPro) {
                              _openSheet(context, const IsItNormalSheet());
                            } else {
                              _openSheet(context, const PaywallSheet());
                            }
                          },
                          delay: 450,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _WowCard(
                          icon: Icons.shopping_bag_outlined,
                          title: l10n.toolBag,
                          subtitle: l10n.toolBagSub,
                          color: const Color(0xFFE0F2F1),
                          onTap: () => _openSheet(context, const ChecklistSheet()),
                          delay: 500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // СЕМЬЯ (Family)
              _buildSectionHeader(
                context,
                l10n.toolsSectionFamily,
                Icons.diversity_1_rounded,
                2,
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        child: _WowCard(
                          icon: Icons.child_care_rounded,
                          title: l10n.toolNames,
                          subtitle: l10n.toolNamesSub,
                          color: const Color(0xFFFFEBEE),
                          onTap: () => _openSheet(context, const NameSwiperSheet()),
                          delay: 550,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _WowCard(
                          icon: Icons.photo_camera_outlined,
                          title: l10n.toolGallery,
                          subtitle: l10n.toolGallerySub,
                          color: const Color(0xFFEFEBE9),
                          isLocked: !isPro,
                          onTap: () {
                            if (isPro) {
                              _openSheet(context, const BumpGallerySheet());
                            } else {
                              _openSheet(context, const PaywallSheet());
                            }
                          },
                          delay: 600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon, int index) {
    final theme = Theme.of(context);
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final delay = 50 + (index * 150);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 4),
        child: Row(
          children: [
            Icon(icon, size: 18, color: mutedColor.withValues(alpha: 0.6)),
            const SizedBox(width: 8),
            Text(
              title.toUpperCase(),
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
                color: mutedColor.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 400.ms, delay: delay.ms).moveX(begin: -10, end: 0, duration: 400.ms, curve: Curves.easeOut),
    );
  }

  void _openSheet(BuildContext context, Widget sheet) {
    HapticFeedback.selectionClick();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => sheet,
    );
  }

  void _openFullScreen(BuildContext context, Widget screen) {
    HapticFeedback.selectionClick();
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }
}

class _WowCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color color;
  final VoidCallback onTap;
  final int delay;
  final double? height;
  final bool isSmall;
  final bool isLocked;

  const _WowCard({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.color,
    required this.onTap,
    required this.delay,
    this.height,
    this.isSmall = false,
    this.isLocked = false,
  });

  @override
  State<_WowCard> createState() => _WowCardState();
}

class _WowCardState extends State<_WowCard> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(CurvedAnimation(parent: _animController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animController.reverse();
    widget.onTap();
  }

  void _onTapCancel() {
    _animController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = theme.cardColor;
    final mainTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;

    Widget content = widget.isSmall ? Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: widget.color.withValues(alpha: 0.4),
            shape: BoxShape.circle,
          ),
          child: Icon(widget.icon, color: Colors.black87, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            widget.title,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: mainTextColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ) : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: widget.color.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(widget.icon, color: Colors.black87, size: 22),
        ),
        const Spacer(),
        Text(
          widget.title,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: mainTextColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (widget.subtitle != null) ...[
          const SizedBox(height: 2),
          Text(
            widget.subtitle!,
            style: theme.textTheme.labelSmall?.copyWith(fontSize: 11, color: mutedColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ]
      ],
    );

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: widget.height ?? 125,
              padding: EdgeInsets.all(widget.isSmall ? 12 : 16),
              decoration: BoxDecoration(
                color: cardColor.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  )
                ]
              ),
              child: content,
            ),
            if (widget.isLocked)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.lock_rounded, size: 14, color: Colors.black54),
                ),
              ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 500.ms, delay: widget.delay.ms).slideY(begin: 0.1, end: 0, duration: 500.ms, curve: Curves.easeOutCubic);
  }
}

class _MeshBackground extends StatefulWidget {
  const _MeshBackground();

  @override
  State<_MeshBackground> createState() => _MeshBackgroundState();
}

class _MeshBackgroundState extends State<_MeshBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 12))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value * 2 * math.pi;
        return Stack(
          children: [
            Positioned(
              left: -100 + 50 * math.sin(t),
              top: 50 + 60 * math.cos(t * 0.8),
              child: _Orb(color: primaryColor.withValues(alpha: 0.3), size: 300),
            ),
            Positioned(
              right: -50 + 40 * math.cos(t * 1.2),
              top: 250 + 50 * math.sin(t * 0.9),
              child: _Orb(color: const Color(0xFFE29587).withValues(alpha: 0.25), size: 250), 
            ),
            Positioned(
              left: 50 + 70 * math.sin(t * 1.5),
              bottom: 100 + 40 * math.cos(t),
              child: _Orb(color: const Color(0xFF8E9BAE).withValues(alpha: 0.2), size: 350), 
            ),
          ],
        );
      },
    );
  }
}

class _Orb extends StatelessWidget {
  final Color color;
  final double size;

  const _Orb({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withValues(alpha: 0)],
          stops: const [0.0, 1.0],
        ),
      ),
    );
  }
}
