import re

with open('lib/features/home/presentation/living_orbit_screen.dart', 'r') as f:
    content = f.read()

# Replace _buildVisualModeSwitch call and its SizedBox
visual_switch_pattern = r"_buildVisualModeSwitch\([\s\S]*?,\s*\)\.animate\(\)\.fadeIn.*?,\n"
content = re.sub(visual_switch_pattern, "", content)
content = re.sub(r"const SizedBox\(height: 14\),\n\s*const SizedBox\(height: 14\),\n", "const SizedBox(height: 14),\n", content)

# Replace _buildMiniWeekNavigator with MiniWeekNavigator
mini_nav_pattern = r"_buildMiniWeekNavigator\(\s*context,\s*theme:\s*theme,\s*l10n:\s*l10n,\s*displayWeek:\s*displayWeek,\s*realWeek:\s*realWeek,\s*showLaborEntry:\s*settings\.showLaborButton,\s*locale:\s*locale,\s*\)"
new_mini_nav = """MiniWeekNavigator(
                          displayWeek: displayWeek,
                          realWeek: realWeek,
                          showLaborEntry: settings.showLaborButton,
                          locale: locale,
                          visualModeKey: _visualModeKey,
                          isTogglingVisualMode: _isTogglingVisualMode,
                          onWeekSelected: (int week) => _setDisplayedWeek(week, realWeek),
                          onOpenWeekPicker: () => _openWeekPicker(realWeek),
                          onVisualModeSelected: (String mode) => _setVisualMode(mode),
                        )"""

# Handle both pure and `.animate()...` usages
content = content.replace("_buildMiniWeekNavigator(\n                          context,\n                          theme: theme,\n                          l10n: l10n,\n                          displayWeek: displayWeek,\n                          realWeek: realWeek,\n                          showLaborEntry: settings.showLaborButton,\n                          locale: locale,\n                        )", new_mini_nav)
# In case it didn't match the exact spacing:
content = re.sub(mini_nav_pattern, new_mini_nav, content)

# Replace Context Snapshot container
snapshot_pattern = r"Container\(\s*padding: const EdgeInsets.fromLTRB\(18, 18, 18, 20\),[\s\S]*?Row\([\s\S]*?Expanded\([\s\S]*?_buildCozyStatChip[\s\S]*?_buildCozyStatChip[\s\S]*?\}\s*\)\.animate\(\)\.fadeIn.*?\),"
new_snapshot = """HomeContextSnapshot(
                          displayWeek: displayWeek,
                          locale: locale,
                          title: objectData.title,
                          description: objectData.description,
                          progressValue: progressValue,
                          trimesterLabel: _trimesterLabel(displayWeek, locale),
                          weekLabel: l10n.weekLabel(displayWeek),
                        ).animate().fadeIn(duration: 500.ms).moveY(
                              begin: -10,
                              end: 0,
                              duration: 500.ms,
                              curve: Curves.easeOutCubic,
                            ),"""
content = re.sub(snapshot_pattern, new_snapshot, content, count=1)

# Modify Today For You call
today_card_pattern = r"_buildTodayForYouCard\(\s*context,\s*theme:\s*theme,\s*l10n:\s*l10n,\s*locale:\s*locale,\s*tip:\s*weekDetail\.tip,\s*\)"
new_today_card = """TodayForYouCard(
                            locale: locale,
                            tip: weekDetail.tip,
                          )"""
content = re.sub(today_card_pattern, new_today_card, content)

content = content.replace("_cozyMilestoneTitle(locale)", "(locale == 'ru' ? 'Главное на этой неделе' : 'A Loving Focus This Week')")

with open('lib/features/home/presentation/living_orbit_screen.dart', 'w') as f:
    f.write(content)
