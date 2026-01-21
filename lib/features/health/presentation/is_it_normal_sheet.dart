import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../l10n/app_localizations.dart';

// Removed static theme import
// import '../../../core/theme/app_theme.dart';

import '../data/symptoms_repository.dart';

class IsItNormalSheet extends ConsumerStatefulWidget {
  const IsItNormalSheet({super.key});

  @override
  ConsumerState<IsItNormalSheet> createState() => _IsItNormalSheetState();
}

class _IsItNormalSheetState extends ConsumerState<IsItNormalSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Get Localization & Theme
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;

    final theme = Theme.of(context);
    final scaffoldBg = theme.scaffoldBackgroundColor;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final cardColor = theme.cardColor;

    final repository = ref.read(symptomsRepositoryProvider);
    final symptoms = repository.search(_query, locale);

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: scaffoldBg, // Dynamic background
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          // Drag Handle
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: mutedColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Title
          Text(
            l10n.toolIsItNormal ?? "Is it Normal?",
            style: theme.textTheme.displayLarge?.copyWith(fontSize: 24),
          ),

          const SizedBox(height: 16),

          // DISCLAIMER
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              // Keep orange for warning semantics, but softer
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.orange, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.normalDisclaimer,
                    style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.brown,
                        fontSize: 11,
                        height: 1.3
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _searchController,
              onChanged: (val) => setState(() => _query = val),
              style: theme.textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: l10n.normalSearchHint,
                hintStyle: TextStyle(color: mutedColor.withOpacity(0.5)),
                prefixIcon: Icon(Icons.search, color: mutedColor),
                filled: true,
                fillColor: cardColor, // Dynamic card color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: symptoms.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = symptoms[index];
                return _SymptomCard(symptom: item);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SymptomCard extends StatelessWidget {
  final Symptom symptom;

  const _SymptomCard({required this.symptom});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Theme
    final theme = Theme.of(context);
    final cardColor = theme.cardColor;
    final mainTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;

    final statusColor = _getStatusColor(symptom.severity, theme);
    final statusText = _getStatusText(symptom.severity, l10n);
    final statusIcon = _getStatusIcon(symptom.severity);

    return GestureDetector(
      onTap: () {
        _showDetail(context);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4)
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Color Indicator
            Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          symptom.title,
                          style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                      ),
                      // Status Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(statusIcon, size: 12, color: statusColor),
                            const SizedBox(width: 4),
                            Text(
                              statusText.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: statusColor
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    symptom.shortDescription,
                    style: theme.textTheme.labelSmall?.copyWith(
                        fontSize: 13,
                        color: mainTextColor.withOpacity(0.7)
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.1, end: 0);
  }

  void _showDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _SymptomDetailSheet(symptom: symptom),
    );
  }

  Color _getStatusColor(SymptomSeverity s, ThemeData theme) {
    switch (s) {
      case SymptomSeverity.common: return theme.primaryColor; // Green/Blue/Peach depending on theme
      case SymptomSeverity.monitor: return const Color(0xFFE6A23C); // Orange (Warning)
      case SymptomSeverity.urgent: return const Color(0xFFF56C6C); // Red (Danger)
    }
  }

  String _getStatusText(SymptomSeverity s, AppLocalizations l10n) {
    switch (s) {
      case SymptomSeverity.common: return l10n.statusCommon;
      case SymptomSeverity.monitor: return l10n.statusMonitor;
      case SymptomSeverity.urgent: return l10n.statusUrgent;
    }
  }

  IconData _getStatusIcon(SymptomSeverity s) {
    switch (s) {
      case SymptomSeverity.common: return Icons.check_circle_outline;
      case SymptomSeverity.monitor: return Icons.info_outline;
      case SymptomSeverity.urgent: return Icons.add_alert_rounded;
    }
  }
}

// Detail Screen
class _SymptomDetailSheet extends StatelessWidget {
  final Symptom symptom;

  const _SymptomDetailSheet({required this.symptom});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: mutedColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),

          Text(
              symptom.title,
              style: theme.textTheme.displayLarge?.copyWith(fontSize: 28)
          ),
          const SizedBox(height: 16),

          // Body
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                symptom.fullDescription,
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16, height: 1.6),
              ),
            ),
          ),

          // Action Button (If Urgent)
          if (symptom.severity == SymptomSeverity.urgent)
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF56C6C),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    icon: const Icon(Icons.call, color: Colors.white),
                    label: Text(
                        l10n.actionContactDoctor,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}