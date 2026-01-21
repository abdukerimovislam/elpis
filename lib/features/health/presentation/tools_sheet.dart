import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Haptics
import '../../../l10n/app_localizations.dart';

// Removed static theme import
// import '../../../core/theme/app_theme.dart';

// Screen Imports
import '../../health/presentation/symptom_sheet.dart';
import '../../health/presentation/weight_sheet.dart';
import '../../health/presentation/kick_counter_sheet.dart';
import '../../health/presentation/water_sheet.dart';
import 'contraction_timer_sheet.dart';
import 'checklist_sheet.dart';
import 'kegel_sheet.dart';
import 'doctor_visits_sheet.dart';
import '../../family/presentation/name_swiper_sheet.dart';
import '../../family/presentation/bump_gallery_sheet.dart';
import '../../health/presentation/is_it_normal_sheet.dart';

class ToolsSheet extends StatefulWidget {
  const ToolsSheet({super.key});

  @override
  State<ToolsSheet> createState() => _ToolsSheetState();
}

class _ToolsSheetState extends State<ToolsSheet> {
  late FixedExtentScrollController _scrollController;
  int _selectedItemIndex = 0;

  final double _itemExtent = 85.0;

  @override
  void initState() {
    super.initState();
    _scrollController = FixedExtentScrollController(initialItem: 0);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // --- THEMING ---
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final scaffoldBg = theme.scaffoldBackgroundColor;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final mainTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;

    // List of tools
    final List<_ToolData> allTools = [
      _ToolData(
        title: l10n.toolIsItNormal ?? "Is it Normal?",
        subtitle: l10n.toolIsItNormalSub ?? "Symptom checker",
        category: l10n.menuHealth,
        icon: Icons.healing_outlined,
        color: const Color(0xFFE8F5E9),
        onTap: (ctx) => _openSheet(ctx, const IsItNormalSheet()),
      ),
      _ToolData(
        title: l10n.toolSymptoms, subtitle: l10n.toolSymptomsSub, category: l10n.menuHealth,
        icon: Icons.favorite_border, color: const Color(0xFFFFE4E1),
        onTap: (ctx) => _openSheet(ctx, const SymptomSheet()),
      ),
      _ToolData(
        title: l10n.toolWeight, subtitle: l10n.toolWeightSub, category: l10n.menuHealth,
        icon: Icons.scale_outlined, color: const Color(0xFFE1F5FE),
        onTap: (ctx) => _openSheet(ctx, const WeightSheet()),
      ),
      _ToolData(
        title: l10n.toolWater, subtitle: l10n.toolWaterSub, category: l10n.menuHealth,
        icon: Icons.water_drop_outlined, color: const Color(0xFFE0F7FA),
        onTap: (ctx) => _openSheet(ctx, const WaterSheet()),
      ),
      _ToolData(
        title: l10n.toolKicks, subtitle: l10n.toolKicksSub, category: l10n.menuHealth,
        icon: Icons.touch_app_outlined, color: const Color(0xFFFFF3E0),
        onTap: (ctx) {
          Navigator.pop(ctx);
          Navigator.push(ctx, MaterialPageRoute(builder: (_) => const KickCounterSheet()));
        },
      ),
      _ToolData(
        title: l10n.toolContractions, subtitle: l10n.toolContractionsSub, category: l10n.menuPrep,
        icon: Icons.timer_outlined, color: const Color(0xFFE8EAF6),
        onTap: (ctx) {
          Navigator.pop(ctx);
          Navigator.push(ctx, MaterialPageRoute(builder: (_) => const ContractionTimerSheet()));
        },
      ),
      _ToolData(
        title: l10n.toolBag, subtitle: l10n.toolBagSub, category: l10n.menuPrep,
        icon: Icons.shopping_bag_outlined, color: const Color(0xFFE0F2F1),
        onTap: (ctx) => _openSheet(ctx, const ChecklistSheet()),
      ),
      _ToolData(
        title: l10n.toolKegel, subtitle: l10n.toolKegelSub, category: l10n.menuPrep,
        icon: Icons.fitness_center_outlined, color: const Color(0xFFF3E5F5),
        onTap: (ctx) => _openSheet(ctx, const KegelSheet()),
      ),
      _ToolData(
        title: l10n.toolVisits, subtitle: l10n.toolVisitsSub, category: l10n.menuPrep,
        icon: Icons.calendar_month_outlined, color: const Color(0xFFFFFDE7),
        onTap: (ctx) => _openSheet(ctx, const DoctorVisitsSheet()),
      ),
      _ToolData(
        title: l10n.toolNames, subtitle: l10n.toolNamesSub, category: l10n.menuFamily,
        icon: Icons.favorite, color: const Color(0xFFFFEBEE),
        onTap: (ctx) => _openSheet(ctx, const NameSwiperSheet()),
      ),
      _ToolData(
        title: l10n.toolGallery, subtitle: l10n.toolGallerySub, category: l10n.menuFamily,
        icon: Icons.photo_camera_outlined, color: const Color(0xFFEFEBE9),
        onTap: (ctx) => _openSheet(ctx, const BumpGallerySheet()),
      ),
    ];

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: scaffoldBg, // Dynamic background
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          // Drag Handle
          Container(
            width: 40, height: 4,
            decoration: BoxDecoration(
              color: mutedColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),

          Text(
            l10n.toolsTitle,
            style: theme.textTheme.displayLarge?.copyWith(fontSize: 24),
          ),

          const SizedBox(height: 16),

          // 3D WHEEL
          Expanded(
            child: Stack(
              children: [
                // Scroll View
                ListWheelScrollView.useDelegate(
                  controller: _scrollController,
                  itemExtent: _itemExtent,
                  perspective: 0.003,
                  diameterRatio: 2.0,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    setState(() => _selectedItemIndex = index);
                    HapticFeedback.selectionClick();
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: allTools.length,
                    builder: (context, index) {
                      final tool = allTools[index];
                      final isActive = index == _selectedItemIndex;

                      return Center(
                        child: _DrumCard(
                          tool: tool,
                          isActive: isActive,
                          theme: theme, // Pass theme down
                        ),
                      );
                    },
                  ),
                ),

                // Top Gradient (Fade out)
                Positioned(
                  top: 0, left: 0, right: 0,
                  height: 100,
                  child: IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            scaffoldBg,
                            scaffoldBg.withOpacity(0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Bottom Gradient (Fade out)
                Positioned(
                  bottom: 0, left: 0, right: 0,
                  height: 100,
                  child: IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            scaffoldBg,
                            scaffoldBg.withOpacity(0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _openSheet(BuildContext context, Widget sheet) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => sheet,
    );
  }
}

// --- WIDGETS ---

class _ToolData {
  final String title;
  final String subtitle;
  final String category;
  final IconData icon;
  final Color color;
  final void Function(BuildContext) onTap;

  _ToolData({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}

class _DrumCard extends StatelessWidget {
  final _ToolData tool;
  final bool isActive;
  final ThemeData theme;

  const _DrumCard({
    required this.tool,
    required this.isActive,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = theme.primaryColor;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final mainTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final cardColor = theme.cardColor;

    return GestureDetector(
      onTap: () {
        if (isActive) {
          HapticFeedback.mediumImpact();
          tool.onTap(context);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: MediaQuery.of(context).size.width * (isActive ? 0.9 : 0.85),
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              // Shadow follows primary theme color
              color: primaryColor.withOpacity(isActive ? 0.15 : 0.0),
              blurRadius: isActive ? 12 : 0,
              offset: const Offset(0, 4),
            )
          ],
          border: Border.all(
            // Border follows primary theme color
            color: isActive
                ? primaryColor.withOpacity(0.4)
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            // Icon
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isActive ? 1.0 : 0.6,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  // Pastel colors for tools remain constant (content)
                  color: tool.color.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(tool.icon, color: Colors.black87, size: 20),
              ),
            ),
            const SizedBox(width: 16),

            // Text
            Expanded(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isActive ? 1.0 : 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          tool.title,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: mainTextColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(width: 8),
                        // Category Label
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: mutedColor.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            tool.category.toUpperCase(),
                            style: theme.textTheme.labelSmall?.copyWith(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                color: mutedColor
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      tool.subtitle,
                      style: theme.textTheme.labelSmall?.copyWith(
                          fontSize: 11,
                          color: mutedColor
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),

            // Arrow (active only)
            if (isActive)
              Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: mutedColor.withOpacity(0.5)
              ),
          ],
        ),
      ),
    );
  }
}