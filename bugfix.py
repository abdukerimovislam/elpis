with open('lib/features/pregnancy/data/pregnancy_repository.dart', 'r') as f:
    prep_repo = f.read()

repo_methods = """  Future<String?> getBabyLetter(int week) async {
    final snapshot = await _isar.weekSnapshots.filter().weekEqualTo(week).findFirst();
    return snapshot?.letterToBaby;
  }
  
  Future<void> saveBabyLetter(int week, String letter) => saveLetter(week, letter);

  Future<void> saveLetter"""

prep_repo = prep_repo.replace("  Future<void> saveLetter", repo_methods)

with open('lib/features/pregnancy/data/pregnancy_repository.dart', 'w') as f:
    f.write(prep_repo)

with open('lib/features/home/presentation/living_orbit_screen.dart', 'r') as f:
    orbit = f.read()

orbit = orbit.replace("await ref.read(pregnancyRepositoryProvider).updateVisualMode(mode);", "await ref.read(pregnancyRepositoryProvider).setVisualMode(mode);")

week_picker_old = """  void _openWeekPicker(int currentWeek) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => WeekPickerSheet(
        currentWeek: currentWeek,
        selectedWeek: displayWeek,
        onWeekSelected: (w) => _setDisplayedWeek(w, currentWeek),
      ),
    );
  }"""

week_picker_new = """  void _openWeekPicker(int currentWeek) async {
    final selectedWeek = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const WeekPickerSheet(),
    );
    if (selectedWeek != null) {
      _setDisplayedWeek(selectedWeek, currentWeek);
    }
  }"""
orbit = orbit.replace(week_picker_old, week_picker_new)

# Wait! Let's check how _loadLetter was implemented.
# `final text = ref.read(pregnancyRepositoryProvider).getBabyLetter(week) ?? "";`
# Since getBabyLetter is async now, it MUST be awaited!
# `var text = ""; final repo = ref.read(pregnancyRepositoryProvider); repo.getBabyLetter(week).then((val) => { ... })`
load_letter_old = """  void _loadLetter(int week) {
    if (_lastLoadedLetterWeek == week) return;
    final text = ref.read(pregnancyRepositoryProvider).getBabyLetter(week) ?? "";
    setState(() {
      _lastLoadedLetterWeek = week;
      _loadedLetterText = text;
      _letterController.text = text;
    });
  }"""

load_letter_new = """  void _loadLetter(int week) async {
    if (_lastLoadedLetterWeek == week) return;
    try {
      final text = await ref.read(pregnancyRepositoryProvider).getBabyLetter(week) ?? "";
      if (mounted) {
        setState(() {
          _lastLoadedLetterWeek = week;
          _loadedLetterText = text;
          _letterController.text = text;
        });
      }
    } catch(e) {}
  }"""
orbit = orbit.replace(load_letter_old, load_letter_new)

with open('lib/features/home/presentation/living_orbit_screen.dart', 'w') as f:
    f.write(orbit)

with open('lib/core/ui/glass_text_field.dart', 'r') as f:
    glass = f.read()

glass = glass.replace("final VoidCallback? onEditingComplete;", "final VoidCallback? onEditingComplete;\n  final ValueChanged<String>? onChanged;\n  final int? maxLines;\n  final int? minLines;")
glass = glass.replace("this.onEditingComplete,\n  });", "this.onEditingComplete,\n    this.onChanged,\n    this.maxLines,\n    this.minLines,\n  });")
glass = glass.replace("maxLines: 6,\n        minLines: 1,", "maxLines: maxLines ?? 6,\n        minLines: minLines ?? 1,\n        onChanged: onChanged,")

with open('lib/core/ui/glass_text_field.dart', 'w') as f:
    f.write(glass)

