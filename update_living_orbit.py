import re

with open('lib/features/home/presentation/living_orbit_screen.dart', 'r') as f:
    content = f.read()

# We want to reorganize the stack.
# We will find the `children: [` under `body: Stack(`
# It looks like:
#         children: [
#           // 1. Breathing Background
#           const BreathingBackground(),

#           // 2. Main content
#           Positioned.fill(
#              child: GestureDetector(

# We'll replace the CustomScrollView slivers.

new_slivers = """
                  slivers: [
                    // A transparent block the size of the Hero section, letting the sphere show through
                    SliverToBoxAdapter(
                      child: SizedBox(height: MediaQuery.of(context).padding.top + 380),
                    ),
                    
                    // The "Sheet" that scrolls over the sphere
                    SliverToBoxAdapter(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.scaffoldBackgroundColor, // Uses app background to look seamless
                            boxShadow: [
                               BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -5))
                            ]
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              // Little pill to indicate it's a sheet
                              Container(
                                width: 40,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(height: 24),
                              
                              // TITLE & MILESTONE (Reverted to Vertical layout)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(999),
                                  border: Border.all(
                                    color: primaryColor.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.auto_awesome_rounded, size: 11, color: primaryColor.withOpacity(0.7)),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${_trimesterLabel(displayWeek, locale).toUpperCase()}  ·  ${l10n.weekLabel(displayWeek).toUpperCase()}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        letterSpacing: 1.4,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor.withOpacity(0.8),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Icon(Icons.auto_awesome_rounded, size: 11, color: primaryColor.withOpacity(0.7)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32),
                                child: Text(
                                  objectData.title,
                                  style: theme.textTheme.displayLarge?.copyWith(fontSize: 32, height: 1.1),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 40),
                                child: Text(
                                  objectData.description,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontSize: 16,
                                    height: 1.55,
                                    color: theme.textTheme.bodyLarge?.color?.withOpacity(0.72),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              if (weekDetail.milestone != null && weekDetail.milestone!.isNotEmpty) ...[
                                const SizedBox(height: 24),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  margin: const EdgeInsets.symmetric(horizontal: 32),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: primaryColor.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.emoji_events_rounded, color: primaryColor, size: 22),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        child: Text(
                                          weekDetail.milestone!,
                                          style: theme.textTheme.titleSmall?.copyWith(
                                            color: primaryColor,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              
                              const SizedBox(height: 28),
                              FetalGrowthSection(week: displayWeek),
                              const SizedBox(height: 28),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Container(
                        color: theme.scaffoldBackgroundColor,
                        child: SizedBox(
                          height: 360,
                          child: PageView.builder(
                            clipBehavior: Clip.none,
                            controller: PageController(viewportFraction: 0.88),
                            physics: const BouncingScrollPhysics(),
                            itemCount: extendedInsights.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: WeekDetailInsightCard(
                                    insight: extendedInsights[index],
                                    iconData: _getIconFromName(extendedInsights[index].iconName),
                                    staggerDelayMs: 150 + (index * 50),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    
                    SliverToBoxAdapter(
                       child: Container(
                          color: theme.scaffoldBackgroundColor,
                          child: _buildLettersSection(context, l10n, displayWeek, settings.babyName),
                       )
                    ),
                    
                    SliverToBoxAdapter(child: Container(color: theme.scaffoldBackgroundColor, child: const SizedBox(height: 120))),
                  ],
"""

# Now we need to put the Hero Section (Week picker + Sphere) into the Stack directly.
hero_section = """
          // 1. Breathing Background
          const BreathingBackground(),

          // 1.5 HERO SECTION (Fixed in background)
          Positioned(
            top: MediaQuery.of(context).padding.top + 70,
            left: 0, right: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => _openWeekPicker(realWeek),
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l10n.weekLabel(displayWeek).toUpperCase(),
                          style: theme.textTheme.labelSmall?.copyWith(
                            letterSpacing: 4.0,
                            fontSize: 14,
                            color: mutedColor.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: mutedColor.withOpacity(0.3))
                      ],
                    ),
                  ),
                ),
                if (isBrowsingHistory)
                  GestureDetector(
                    onTap: () => _setDisplayedWeek(realWeek, realWeek),
                    child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                            color: theme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(Icons.history, size: 14, color: theme.primaryColor),
                          const SizedBox(width: 4),
                          Text(l10n.homeReturnToCurrent(realWeek),
                              style: TextStyle(fontSize: 12, color: theme.primaryColor, fontWeight: FontWeight.bold))
                        ])).animate().fadeIn().scale(),
                  ),
                // Hero Sphere
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onHorizontalDragEnd: (details) => _handleSphereSwipe(displayWeek, realWeek, details),
                  child: LivingSphereDisplay(
                    week: displayWeek,
                    scale: 0.85,
                  ),
                ),
              ],
            ),
          ),
"""

import re
# 1. Replace the breathing background part
content = content.replace("          // 1. Breathing Background\n          const BreathingBackground(),", hero_section)

# 2. Extract slivers and replace
sliver_start = content.find("slivers: [")
sliver_end = content.find("OrbitAppBar(", sliver_start)
sliver_end = content.rfind("          ),", sliver_start, sliver_end)

if sliver_start != -1 and sliver_end != -1:
    content = content[:sliver_start] + new_slivers.strip() + "\n                ),\n             )\n          ),\n\n          " + content[sliver_end+13:]

with open('lib/features/home/presentation/living_orbit_screen.dart', 'w') as f:
    f.write(content.replace('.withOpacity(', '.withValues(alpha: '))
