import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/ui/glass_card.dart';
import '../../../../core/ui/optimized_image.dart';
import '../../../pregnancy/data/pregnancy_repository.dart';
import '../../../pregnancy/domain/pregnancy_settings.dart';


class WeekPickerSheet extends ConsumerWidget {
  const WeekPickerSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsStream = ref.watch(pregnancyRepositoryProvider).watchSettings();

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          // Ручка шторки
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

          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              "JUMP TO WEEK",
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
            ),
          ),

          // СПИСОК
          Expanded(
            child: StreamBuilder<PregnancySettings?>(
                stream: settingsStream,
                builder: (context, snapshot) {
                  final currentWeek = snapshot.data?.currentWeek ?? 1;
                  final isFruitMode = snapshot.data?.isFruitMode ?? true;

                  // ListView.builder - ленивый рендеринг (строит только то, что на экране)
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: 42,

                    // ВАЖНО: Фиксированная высота элемента.
                    // Это позволяет Flutter пропустить расчет лайаута для всех 42 элементов сразу.
                    itemExtent: 88.0,

                    itemBuilder: (context, index) {
                      final week = index + 1;
                      final isSelected = week == currentWeek;

                      // RepaintBoundary - изолирует каждый элемент списка.
                      // При скролле перерисовывается только смещение, а не контент внутри.
                      return RepaintBoundary(
                        child: _WeekItem(
                          week: week,
                          isSelected: isSelected,
                          isFruitMode: isFruitMode,
                          onTap: () {
                            // Сохраняем новую дату (откатываемся назад или вперед)
                            // Логика: Если LMP была X, а мы ставим неделю Y, то LMP смещается.
                            // Для простоты здесь просто закрываем, реализацию смены даты
                            // лучше вынести в репозиторий (updateCurrentWeek).

                            // Пока просто лог, так как метода updateWeekByNumber нет в репозитории
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

  const _WeekItem({
    required this.week,
    required this.isSelected,
    required this.isFruitMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final folder = isFruitMode ? 'fruits' : 'realistic';
    final path = 'assets/images/$folder/week_$week.webp';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: GlassCard(
          // Если элемент не выбран, отключаем блюр для производительности скролла
          forceNoBlur: !isSelected,
          color: isSelected ? theme.primaryColor.withOpacity(0.2) : theme.cardColor.withOpacity(0.5),
          borderRadius: 16,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              // КАРТИНКА (ОПТИМИЗИРОВАННАЯ)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: OptimizedImage(
                  path: path,
                  width: 56,
                  height: 56,
                  // Для списка нам хватит очень маленького кеша
                  memCacheWidth: 150,
                ),
              ),
              const SizedBox(width: 16),

              // ТЕКСТ
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Week $week",
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