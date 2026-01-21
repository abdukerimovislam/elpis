import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';
import '../../pregnancy/data/pregnancy_repository.dart';
// import '../../pregnancy/data/insight_repository.dart'; // Убедись, что этот файл существует

// 1. Провайдер истории (Теперь STREAM для реактивности)
final diaryHistoryProvider = StreamProvider.autoDispose((ref) {
  return ref.watch(pregnancyRepositoryProvider).watchDiaryHistory();
});

// 2. Провайдер настроек
final settingsStreamProvider = StreamProvider.autoDispose((ref) {
  return ref.watch(pregnancyRepositoryProvider).watchSettings();
});

class DiarySheet extends ConsumerWidget {
  const DiarySheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;

    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final accentColor = theme.colorScheme.secondary;
    final mutedTextColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final cardColor = theme.cardColor;

    final historyAsync = ref.watch(diaryHistoryProvider);
    final settingsAsync = ref.watch(settingsStreamProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          // Drag Handle
          Container(
            width: 40, height: 4,
            decoration: BoxDecoration(
              color: mutedTextColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          // Заголовок
          Text(
              l10n.diaryTitle,
              style: theme.textTheme.displayLarge?.copyWith(fontSize: 24)
          ),
          const SizedBox(height: 8),
          Text(
              l10n.diarySubtitle,
              style: theme.textTheme.labelSmall
          ),

          const SizedBox(height: 24),

          Expanded(
            child: historyAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(
                  child: Text('Error loading diary', style: TextStyle(color: mutedTextColor))
              ),
              data: (history) {
                if (history.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(48.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit_note, size: 64, color: mutedTextColor.withOpacity(0.2)),
                          const SizedBox(height: 16),
                          Text(
                            l10n.diaryEmpty,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(color: mutedTextColor),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                // Получаем настройки (фрукты или нет)
                // final isFruitMode = settingsAsync.valueOrNull?.isFruitMode ?? true;

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  itemCount: history.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final item = history[index];

                    // --- ЛОГИКА ОПРЕДЕЛЕНИЯ ОБЪЕКТА (ЗАГЛУШКА) ---
                    // В реальном коде раскомментируй InsightRepository
                    // final objectData = ref.read(insightRepositoryProvider).getObjectData(item.week, locale, isFruitMode);
                    // final objectTitle = objectData[0];

                    // Пока берем просто номер недели, если репозитория инсайтов нет под рукой
                    final objectTitle = "Baby Size at Week ${item.week}";

                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 15,
                              offset: const Offset(0, 5)
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                    l10n.weekLabel(item.week),
                                    style: theme.textTheme.labelSmall?.copyWith(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12
                                    )
                                ),
                              ),
                              Text(
                                DateFormat.yMMMd(locale).format(item.date ?? DateTime.now()),
                                style: theme.textTheme.labelSmall?.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          Text(
                            objectTitle,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: accentColor,
                                letterSpacing: 0.5
                            ),
                          ),
                          const SizedBox(height: 8),

                          Text(
                            item.letterToBaby ?? "",
                            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16, height: 1.5),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: (index * 50).ms).slideY(begin: 0.1, end: 0);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}