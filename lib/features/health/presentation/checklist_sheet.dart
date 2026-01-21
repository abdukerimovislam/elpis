import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../l10n/app_localizations.dart';

// Убрали старый импорт
// import '../../../core/theme/app_theme.dart';

import '../data/checklist_repository.dart';
import '../data/checklist_item.dart';

class ChecklistSheet extends ConsumerStatefulWidget {
  const ChecklistSheet({super.key});

  @override
  ConsumerState<ChecklistSheet> createState() => _ChecklistSheetState();
}

class _ChecklistSheetState extends ConsumerState<ChecklistSheet> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Инициализация данных (текстов) при первом запуске
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ref.read(checklistRepositoryProvider).ensureInitialized(l10n);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // --- ТЕМИЗАЦИЯ ---
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final mainTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final bgColor = theme.scaffoldBackgroundColor;
    final cardColor = theme.cardColor;

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
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
              l10n.checklistTitle,
              style: theme.textTheme.displayLarge?.copyWith(fontSize: 24)
          ),
          const SizedBox(height: 16),

          // 2. ГЛАВНЫЙ STREAM BUILDER
          Expanded(
            child: StreamBuilder<List<ChecklistItem>>(
              stream: ref.watch(checklistRepositoryProvider).watchItems(),
              builder: (context, snapshot) {
                // Если данных нет или загрузка
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final allItems = snapshot.data!;

                // Расчет прогресса
                final completed = allItems.where((e) => e.isCompleted).length;
                final total = allItems.length;
                final percent = total == 0 ? 0.0 : completed / total;
                final percentInt = (percent * 100).toInt();

                return Column(
                  children: [
                    // A. ПРОГРЕСС БАР
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: percent,
                              // Фон полоски серый, заполнение - цветом темы
                              backgroundColor: mutedColor.withOpacity(0.1),
                              valueColor: AlwaysStoppedAnimation(primaryColor),
                              minHeight: 8,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l10n.checklistProgress(percentInt),
                            style: theme.textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // B. ТАБЫ (Заголовки)
                    TabBar(
                      controller: _tabController,
                      // Цвета табов берем из темы
                      labelColor: primaryColor,
                      unselectedLabelColor: mutedColor,
                      labelStyle: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      indicatorColor: primaryColor,
                      indicatorSize: TabBarIndicatorSize.label,
                      dividerColor: Colors.transparent,
                      tabs: [
                        Tab(text: l10n.checklistTabDocs),
                        Tab(text: l10n.checklistTabMom),
                        Tab(text: l10n.checklistTabBaby),
                      ],
                    ),

                    // C. СПИСКИ (Контент табов)
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildList(allItems.where((e) => e.category == "docs").toList(), l10n, theme),
                          _buildList(allItems.where((e) => e.category == "mom").toList(), l10n, theme),
                          _buildList(allItems.where((e) => e.category == "baby").toList(), l10n, theme),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<ChecklistItem> items, AppLocalizations l10n, ThemeData theme) {
    final primaryColor = theme.primaryColor;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final mainTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final cardColor = theme.cardColor;

    if (items.isEmpty) {
      return Center(
          child: Text(
              l10n.checklistEmpty,
              style: theme.textTheme.labelSmall
          )
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () {
            ref.read(checklistRepositoryProvider).toggleItem(item.id);
          },
          child: AnimatedContainer(
            duration: 200.ms,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              // Если выполнено - легкий оттенок темы, иначе цвет карточки
              color: item.isCompleted ? primaryColor.withOpacity(0.1) : cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: item.isCompleted ? Colors.transparent : mutedColor.withOpacity(0.1)
              ),
              boxShadow: item.isCompleted ? [] : [
                BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))
              ],
            ),
            child: Row(
              children: [
                Icon(
                  item.isCompleted ? Icons.check_circle : Icons.circle_outlined,
                  color: item.isCompleted ? primaryColor : mutedColor.withOpacity(0.3),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    item.title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: item.isCompleted ? mutedColor : mainTextColor,
                      decoration: item.isCompleted ? TextDecoration.lineThrough : null,
                      decorationColor: mutedColor, // Цвет зачеркивания
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}