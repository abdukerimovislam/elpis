import re

with open('lib/features/home/presentation/living_orbit_screen.dart', 'r') as f:
    content = f.read()

# Add imports
imports = """
import 'widgets/home_hero_bg.dart';
import 'widgets/home_mini_calendar.dart';
import 'widgets/home_today_card.dart';
import 'widgets/home_context_snapshot.dart';
"""
# find the last import and inject
import_idx = content.rfind("import ")
import_end_idx = content.find(";", import_idx) + 1
content = content[:import_end_idx] + imports + content[import_end_idx:]

# Remove the private methods that have been extracted
methods_to_remove = [
    r"  String _heroSupportLine.*?^  \}",
    r"  String _weekJourneyLabel.*?^  \}",
    r"  String _cozyMilestoneTitle.*?^  \}",
    r"  IconData _visualModeIcon.*?^  \}",
    r"  String _visualModeLabel.*?^  \}",
    r"  String _miniCalendarTitle.*?^  \}",
    r"  String _laborModeEntryLabel.*?^  \}",
    r"  String _todayForYouTitle.*?^  \}",
    r"  String _todayForYouSubtitle.*?^  \}",
    r"  Widget _buildVisualModeSwitch.*?(?=^\s+Widget _buildMiniWeekNavigator)",
    r"  Widget _buildMiniWeekNavigator.*?(?=^\s+Widget _buildTodayForYouCard)",
    r"  Widget _buildTodayForYouCard.*?(?=^\s+Widget _buildLettersSection)",
    r"  Widget _buildCozyStatChip.*?(?=^\s+@override\n\s+Widget build)",
]

for pattern in methods_to_remove:
    content = re.sub(pattern, "", content, flags=re.MULTILINE | re.DOTALL)

# Remove the classes at the bottom
classes_to_remove = r"class _WarmGlowBackground extends StatelessWidget \{.*$"
content = re.sub(classes_to_remove, "", content, flags=re.MULTILINE | re.DOTALL)

# Now, we must replace the calls to the methods inside the build method.
# 1. _WarmGlowBackground() -> WarmGlowBackground()
content = content.replace("const _WarmGlowBackground()", "const WarmGlowBackground()")

# 2. _buildVisualModeSwitch -> VisualModePill is already wrapped in MiniWeekNavigator 
# wait, the MiniWeekNavigator structure changed from just a Column to including the VisualModeSwitch!
# Let's completely replace the section where they are called.
