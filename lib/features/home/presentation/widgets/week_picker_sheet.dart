import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart'; // Не забудь импорт!
import '../../../../core/ui/glass_card.dart';
import '../../../../core/ui/optimized_image.dart';
import '../../../pregnancy/data/pregnancy_repository.dart';
import '../../../pregnancy/domain/pregnancy_settings.dart';

class WeekPickerSheet extends ConsumerWidget {
  const WeekPickerSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsStream = ref.watch(pregnancyRepositoryProvider).watchSettings();
    final l10n = AppLocalizations.of(context); // Получаем переводы

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              // 🔥 ИСПРАВЛЕНИЕ: Локализация заголовка
              l10n?.jumpToWeek ?? "JUMP TO WEEK", // Убедись, что добавил ключ в ARB, или оставь хардкод если нет
              style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
            ),
          ),

          Expanded(
            child: StreamBuilder<PregnancySettings?>(
                stream: settingsStream,
                builder: (context, snapshot) {
                  final currentWeek = snapshot.data?.currentWeek ?? 1;
                  final isFruitMode = snapshot.data?.isFruitMode ?? true;

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: 42,
                    itemExtent: 88.0,
                    itemBuilder: (context, index) {
                      final week = index + 1;
                      final isSelected = week == currentWeek;

                      return RepaintBoundary(
                        child: _WeekItem(
                          week: week,
                          isSelected: isSelected,
                          isFruitMode: isFruitMode,
                          // 🔥 Передаем l10n внутрь
                          weekLabel: l10n?.weekLabel(week) ?? "Week $week",
                          onTap: () {
                            Navigator.pop(context, week);
                          },
                        ),
                      );
                    },
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}

class _WeekItem extends StatelessWidget {
  final int week;
  final bool isSelected;
  final bool isFruitMode;
  final VoidCallback onTap;
  final String weekLabel; // Новый параметр

  const _WeekItem({
    required this.week,
    required this.isSelected,
    required this.isFruitMode,
    required this.onTap,
    required this.weekLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Логика заглушки (оставляем как было)
    int imageWeek = week;
    if (week < 4) imageWeek = 4;
    if (week > 40) imageWeek = 40;

    final folder = isFruitMode ? 'fruits' : 'realistic';
    final path = 'assets/images/$folder/week_$imageWeek.webp';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: GlassCard(
          forceNoBlur: !isSelected,
          color: isSelected ? theme.primaryColor.withOpacity(0.2) : theme.cardColor.withOpacity(0.5),
          borderRadius: 16,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: OptimizedImage(
                  path: path,
                  width: 56,
                  height: 56,
                  memCacheWidth: 150,
                ),
              ),
              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      // 🔥 ИСПРАВЛЕНИЕ: Используем локализованную строку (например "Неделя 5")
                      weekLabel.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isSelected ? theme.primaryColor : theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                  ],
                ),
              ),

              if (isSelected)
                Icon(Icons.check_circle, color: theme.primaryColor),
            ],
          ),
        ),
      ),
    );
  }
}