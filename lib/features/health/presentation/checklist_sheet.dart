import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../data/checklist_item.dart';
import '../data/checklist_repository.dart';

class ChecklistSheet extends ConsumerStatefulWidget {
  const ChecklistSheet({super.key});

  @override
  ConsumerState<ChecklistSheet> createState() => _ChecklistSheetState();
}

class _ChecklistSheetState extends ConsumerState<ChecklistSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Set<int> _pendingItems = {};
  bool _isInitializing = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeChecklist();
    });
  }

  Future<void> _initializeChecklist() async {
    if (!mounted || _isInitializing) {
      return;
    }

    setState(() => _isInitializing = true);

    try {
      final l10n = AppLocalizations.of(context)!;
      await ref.read(checklistRepositoryProvider).ensureInitialized(l10n);
    } catch (_) {
      if (mounted) {
        _showError();
      }
    } finally {
      if (mounted) {
        setState(() => _isInitializing = false);
      }
    }
  }

  Future<void> _toggleItem(ChecklistItem item) async {
    if (_pendingItems.contains(item.id)) {
      return;
    }

    setState(() => _pendingItems.add(item.id));

    try {
      await ref.read(checklistRepositoryProvider).toggleItem(item.id);
    } catch (_) {
      if (mounted) {
        _showError();
      }
    } finally {
      if (mounted) {
        setState(() => _pendingItems.remove(item.id));
      }
    }
  }

  void _showError() {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.errorGeneric)),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final bgColor = theme.scaffoldBackgroundColor;

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
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
            l10n.checklistTitle,
            style: theme.textTheme.displayLarge?.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: StreamBuilder<List<ChecklistItem>>(
              stream: ref.watch(checklistRepositoryProvider).watchItems(),
              builder: (context, snapshot) {
                if (_isInitializing && !snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final allItems = snapshot.data!;
                final completed =
                    allItems.where((item) => item.isCompleted).length;
                final total = allItems.length;
                final percent = total == 0 ? 0.0 : completed / total;
                final percentInt = (percent * 100).toInt();

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: percent,
                              backgroundColor:
                                  mutedColor.withValues(alpha: 0.1),
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
                    TabBar(
                      controller: _tabController,
                      labelColor: primaryColor,
                      unselectedLabelColor: mutedColor,
                      labelStyle: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      indicatorColor: primaryColor,
                      indicatorSize: TabBarIndicatorSize.label,
                      dividerColor: Colors.transparent,
                      tabs: [
                        Tab(text: l10n.checklistTabDocs),
                        Tab(text: l10n.checklistTabMom),
                        Tab(text: l10n.checklistTabBaby),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildList(
                            allItems
                                .where((item) => item.category == 'docs')
                                .toList(),
                            l10n,
                            theme,
                          ),
                          _buildList(
                            allItems
                                .where((item) => item.category == 'mom')
                                .toList(),
                            l10n,
                            theme,
                          ),
                          _buildList(
                            allItems
                                .where((item) => item.category == 'baby')
                                .toList(),
                            l10n,
                            theme,
                          ),
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

  Widget _buildList(
    List<ChecklistItem> items,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    final primaryColor = theme.primaryColor;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final mainTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final cardColor = theme.cardColor;

    if (items.isEmpty) {
      return Center(
        child: Text(l10n.checklistEmpty, style: theme.textTheme.labelSmall),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = items[index];
        final isPending = _pendingItems.contains(item.id);

        return GestureDetector(
          onTap: isPending ? null : () => _toggleItem(item),
          child: AnimatedContainer(
            duration: 200.ms,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: item.isCompleted
                  ? primaryColor.withValues(alpha: 0.1)
                  : cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: item.isCompleted
                    ? Colors.transparent
                    : mutedColor.withValues(alpha: 0.1),
              ),
              boxShadow: item.isCompleted
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: Row(
              children: [
                if (isPending)
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: primaryColor,
                    ),
                  )
                else
                  Icon(
                    item.isCompleted
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    color: item.isCompleted
                        ? primaryColor
                        : mutedColor.withValues(alpha: 0.3),
                  ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    item.title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: item.isCompleted ? mutedColor : mainTextColor,
                      decoration:
                          item.isCompleted ? TextDecoration.lineThrough : null,
                      decorationColor: mutedColor,
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
