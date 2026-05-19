import re

with open('lib/features/home/presentation/living_orbit_screen.dart', 'r') as f:
    text = f.read()
text = text.replace("import '../../health/presentation/diary_sheet.dart';", "import '../../pregnancy/presentation/diary_sheet.dart';")
text = text.replace("key: ValueKey('sphere_$_visualModeKey\\_$displayWeek'),", "key: ValueKey('sphere_${_visualModeKey}_$displayWeek'),")

handle_swipe = """
  void _handleSphereSwipe(int displayWeek, int realWeek, DragEndDetails details) {
    if (details.primaryVelocity == null) return;
    HapticFeedback.lightImpact();
    if (details.primaryVelocity! < -300 && displayWeek < 42) {
      _setDisplayedWeek(displayWeek + 1, realWeek);
    } else if (details.primaryVelocity! > 300 && displayWeek > 1) {
      _setDisplayedWeek(displayWeek - 1, realWeek);
    }
  }

  void _openWeekPicker"""
text = text.replace("  void _openWeekPicker", handle_swipe)

with open('lib/features/home/presentation/living_orbit_screen.dart', 'w') as f:
    f.write(text)

with open('lib/features/home/presentation/widgets/home_today_card.dart', 'r') as f:
    text2 = f.read()
text2 = text2.replace("import '../../../health/presentation/diary_sheet.dart';", "import '../../../pregnancy/presentation/diary_sheet.dart';")
with open('lib/features/home/presentation/widgets/home_today_card.dart', 'w') as f:
    f.write(text2)
