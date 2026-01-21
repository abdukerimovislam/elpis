import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../l10n/app_localizations.dart';

// Убрали старые импорты стилей
// import '../../../core/theme/app_theme.dart';

import '../data/health_repository.dart'; // Или pregnancy_repository.dart, если объединили

class SymptomSheet extends ConsumerStatefulWidget {
  const SymptomSheet({super.key});

  @override
  ConsumerState<SymptomSheet> createState() => _SymptomSheetState();
}

class _SymptomSheetState extends ConsumerState<SymptomSheet> {
  final Set<String> _selectedSymptoms = {};
  int _mood = 3; // 1..5

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // --- ТЕМИЗАЦИЯ ---
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final mainTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final bgColor = theme.scaffoldBackgroundColor;
    final cardColor = theme.cardColor; // Цвет для неактивных чипсов

    // Генерируем список симптомов
    final List<String> allSymptoms = [
      l10n.symNausea,
      l10n.symFatigue,
      l10n.symHeartburn,
      l10n.symSwelling,
      l10n.symHeadache,
      l10n.symInsomnia,
      l10n.symBackPain,
      l10n.symHunger,
      l10n.symBabyActive,
      l10n.symAnxiety
    ];

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: bgColor, // Динамический фон
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          // Drag Handle
          Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                  color: mutedColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2)
              )
          ),
          const SizedBox(height: 24),

          Text(
              l10n.symptomTitle,
              style: theme.textTheme.displayLarge?.copyWith(fontSize: 24)
          ),
          const SizedBox(height: 32),

          // 1. НАСТРОЕНИЕ (Слайдер эмодзи)
          Text(
              l10n.symptomMoodLabel,
              style: theme.textTheme.labelSmall
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              final moodLevel = index + 1;
              final isSelected = _mood == moodLevel;
              return GestureDetector(
                onTap: () => setState(() => _mood = moodLevel),
                child: AnimatedScale(
                  scale: isSelected ? 1.2 : 1.0,
                  duration: 200.ms,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      // Подсветка цветом темы
                      color: isSelected ? primaryColor.withOpacity(0.2) : Colors.transparent,
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

          // 2. СИМПТОМЫ (Chips)
          Text(
              l10n.symptomLabel,
              style: theme.textTheme.labelSmall
          ),
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
                    onTap: () {
                      setState(() {
                        if (isSelected) _selectedSymptoms.remove(symptom);
                        else _selectedSymptoms.add(symptom);
                      });
                    },
                    child: AnimatedContainer(
                      duration: 200.ms,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        // Активный - primary, неактивный - cardColor (белый/светлый)
                        color: isSelected ? primaryColor : cardColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? Colors.transparent : mutedColor.withOpacity(0.1),
                        ),
                      ),
                      child: Text(
                        symptom,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isSelected ? Colors.white : mainTextColor,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // 3. КНОПКА
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Сохраняем (предполагаем, что метод остался в healthRepository)
                  ref.read(healthRepositoryProvider).saveSymptoms(
                    date: DateTime.now(),
                    symptoms: _selectedSymptoms.toList(),
                    mood: _mood,
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                ),
                child: Text(
                    l10n.symptomSave,
                    style: theme.textTheme.labelSmall?.copyWith(color: Colors.white, fontSize: 16)
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
      case 1: return "😫";
      case 2: return "😕";
      case 3: return "😐";
      case 4: return "🙂";
      case 5: return "🥰";
      default: return "😐";
    }
  }
}