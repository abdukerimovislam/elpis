with open('lib/features/home/presentation/living_orbit_screen.dart', 'r') as f:
    text = f.read()

replacement = """              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onHorizontalDragEnd: (details) => _handleSphereSwipe(displayWeek, realWeek, details),
                child: LivingSphereDisplay(
                  key: ValueKey('sphere_${_visualModeKey}_$displayWeek'),
                  week: displayWeek,
                  scale: 1.05,
                  showModeToggle: false,
                ),
              ),"""

text = text.replace("""              child: LivingSphereDisplay(
                key: ValueKey('sphere_${_visualModeKey}_$displayWeek'),
                week: displayWeek,
                scale: 1.05,
                showModeToggle: false,
              ),""", replacement)

with open('lib/features/home/presentation/living_orbit_screen.dart', 'w') as f:
    f.write(text)
