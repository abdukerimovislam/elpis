import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../data/health_repository.dart';

class SymptomSheet extends ConsumerStatefulWidget {
  const SymptomSheet({super.key});

  @override
  ConsumerState<SymptomSheet> createState() => _SymptomSheetState();
}

class _SymptomSheetState extends ConsumerState<SymptomSheet> {
  final Set<String> _selectedSymptoms = {};
  int _mood = 3;
  bool _isSaving = false;

  Future<void> _saveSymptoms() async {
    if (_isSaving) {
      return;
    }

    setState(() => _isSaving = true);

    try {
      await ref.read(healthRepositoryProvider).saveSymptoms(
            date: DateTime.now(),
            symptoms: _selectedSymptoms.toList(),
            mood: _mood,
          );
      if (!mounted) {
        return;
      }
      Navigator.pop(context);
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.errorGeneric)),
      );
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final mainTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final bgColor = theme.scaffoldBackgroundColor;
    final cardColor = theme.cardColor;

    final allSymptoms = <String>[
      l10n.symNausea,
      l10n.symFatigue,
      l10n.symHeartburn,
      l10n.symSwelling,
      l10n.symHeadache,
      l10n.symInsomnia,
      l10n.symBackPain,
      l10n.symHunger,
      l10n.symBabyActive,
      l10n.symAnxiety,
    ];

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: mutedColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.symptomTitle,
            style: theme.textTheme.displayLarge?.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 32),
          Text(l10n.symptomMoodLabel, style: theme.textTheme.labelSmall),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              final moodLevel = index + 1;
              final isSelected = _mood == moodLevel;
              return GestureDetector(
                onTap:
                    _isSaving ? null : () => setState(() => _mood = moodLevel),
                child: AnimatedScale(
                  scale: isSelected ? 1.2 : 1.0,
                  duration: 200.ms,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? primaryColor.withValues(alpha: 0.2)
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      _getMoodEmoji(moodLevel),
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 40),
          Text(l10n.symptomLabel, style: theme.textTheme.labelSmall),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: allSymptoms.map((symptom) {
                  final isSelected = _selectedSymptoms.contains(symptom);
                  return GestureDetector(
                    onTap: _isSaving
                        ? null
                        : () {
                            setState(() {
                              if (isSelected) {
                                _selectedSymptoms.remove(symptom);
                              } else {
                                _selectedSymptoms.add(symptom);
                              }
                            });
                          },
                    child: AnimatedContainer(
                      duration: 200.ms,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : cardColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? Colors.transparent
                              : mutedColor.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Text(
                        symptom,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isSelected ? Colors.white : mainTextColor,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _saveSymptoms,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        l10n.symptomSave,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getMoodEmoji(int level) {
    switch (level) {
      case 1:
        return '😫';
      case 2:
        return '😕';
      case 3:
        return '😐';
      case 4:
        return '🙂';
      case 5:
        return '🥰';
      default:
        return '😐';
    }
  }
}
