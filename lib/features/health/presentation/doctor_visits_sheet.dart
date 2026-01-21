import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../l10n/app_localizations.dart';

// Убрали старый импорт
// import '../../../core/theme/app_theme.dart';

import '../../pregnancy/data/pregnancy_repository.dart'; // Используем общий репозиторий
import '../domain/doctor_visit.dart';
import 'visit_edit_sheet.dart';

class DoctorVisitsSheet extends ConsumerWidget {
  const DoctorVisitsSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Используем общий репозиторий
    final visitsAsync = ref.watch(pregnancyRepositoryProvider).watchAllVisits();
    final l10n = AppLocalizations.of(context)!;

    // --- ТЕМИЗАЦИЯ ---
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final scaffoldBg = theme.scaffoldBackgroundColor;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final cardColor = theme.cardColor;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: scaffoldBg, // Динамический фон
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Stack(
        children: [
          Column(
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
                  l10n.visitCalendar,
                  style: theme.textTheme.displayLarge?.copyWith(fontSize: 24)
              ),
              const SizedBox(height: 24),

              Expanded(
                child: StreamBuilder<List<DoctorVisit>>(
                  stream: visitsAsync,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return _buildEmptyState(l10n, theme);
                    }

                    final visits = snapshot.data!;

                    return ListView.separated(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 100), // Отступ снизу для FAB
                      itemCount: visits.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        return _buildVisitCard(context, visits[index], l10n, theme);
                      },
                    );
                  },
                ),
              ),
            ],
          ),

          // FAB (Плавающяя кнопка добавления)
          Positioned(
            bottom: 32, right: 24,
            child: FloatingActionButton.extended(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (c) => const VisitEditSheet()
                );
              },
              icon: const Icon(Icons.add),
              label: Text(l10n.visitFab),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n, ThemeData theme) {
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_month_outlined, size: 64, color: mutedColor.withOpacity(0.2)),
          const SizedBox(height: 16),
          Text(
              l10n.visitEmpty,
              style: theme.textTheme.bodyMedium?.copyWith(color: mutedColor)
          ),
        ],
      ),
    );
  }

  Widget _buildVisitCard(BuildContext context, DoctorVisit visit, AppLocalizations l10n, ThemeData theme) {
    final primaryColor = theme.primaryColor;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final cardColor = theme.cardColor;

    final isDone = DateTime.now().isAfter(visit.date);
    final hasResults = visit.weightKg != null || visit.bpSystolic != null;
    final hasQuestions = visit.questionsToAsk?.isNotEmpty ?? false;

    final locale = Localizations.localeOf(context).toString();

    // Цвет фона карточки (серый если прошел, белый/темовый если предстоит)
    final bg = isDone
        ? (theme.colorScheme.surfaceContainerHighest ?? Colors.grey.withOpacity(0.1))
        : cardColor;

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (c) => VisitEditSheet(existingVisit: visit)
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: mutedColor.withOpacity(0.1)),
            boxShadow: isDone ? [] : [
              BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 4))
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // ДАТА БЛОК
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    // Если прошел - серый, если нет - цвет темы
                    color: isDone ? Colors.grey.withOpacity(0.2) : primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                          DateFormat('dd', locale).format(visit.date),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: isDone ? mutedColor : primaryColor
                          )
                      ),
                      Text(
                          DateFormat('MMM', locale).format(visit.date).toUpperCase(),
                          style: TextStyle(
                              fontSize: 10,
                              color: isDone ? mutedColor : primaryColor
                          )
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // ИНФО
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          visit.title,
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 16)
                      ),
                      if (visit.doctorName != null && visit.doctorName!.isNotEmpty)
                        Text(visit.doctorName!, style: theme.textTheme.labelSmall),
                      const SizedBox(height: 4),
                      Text(
                          DateFormat('HH:mm', locale).format(visit.date),
                          style: TextStyle(color: mutedColor, fontSize: 12)
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // БЕЙДЖИ
            if (hasQuestions || hasResults) ...[
              const SizedBox(height: 12),
              Divider(height: 1, color: mutedColor.withOpacity(0.1)),
              const SizedBox(height: 8),
              Row(
                children: [
                  if (hasQuestions)
                    _buildBadge(Icons.help_outline, l10n.visitBadgeQuestions, Colors.amber),
                  if (hasResults) ...[
                    if (hasQuestions) const SizedBox(width: 8),
                    _buildBadge(Icons.check_circle_outline, l10n.visitBadgeResults, primaryColor),
                  ]
                ],
              )
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}