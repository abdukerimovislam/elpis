import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../pregnancy/data/pregnancy_repository.dart'; // Ð˜Ð¼Ð¿Ð¾Ñ€Ñ‚ Ñ€ÐµÐ¿Ð¾Ð·Ð¸Ñ‚Ð¾Ñ€Ð¸Ñ
import '../services/pdf_report_service.dart';
import '../../../l10n/app_localizations.dart';

class ReportSheet extends ConsumerStatefulWidget {
  const ReportSheet({super.key});

  @override
  ConsumerState<ReportSheet> createState() => _ReportSheetState();
}

class _ReportSheetState extends ConsumerState<ReportSheet> {
  Future<Uint8List>? _pdfFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Ð—Ð°Ð¿ÑƒÑÐºÐ°ÐµÐ¼ Ð³ÐµÐ½ÐµÑ€Ð°Ñ†Ð¸ÑŽ Ð¾Ð´Ð¸Ð½ Ñ€Ð°Ð· Ð¿Ñ€Ð¸ Ð¾Ñ‚ÐºÑ€Ñ‹Ñ‚Ð¸Ð¸
    _pdfFuture ??= _generatePdf();
  }

  Future<Uint8List> _generatePdf() async {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final repo = ref.read(pregnancyRepositoryProvider);

    // 1. ÐŸÐžÐ›Ð£Ð§ÐÐ•Ðœ Ð Ð•ÐÐ›Ð¬ÐÐ«Ð• Ð”ÐÐÐÐ«Ð• Ð˜Ð— Ð‘ÐÐ—Ð«
    // (Ð¸ÑÐ¿Ð¾Ð»ÑŒÐ·ÑƒÐµÐ¼ Future.wait Ð´Ð»Ñ Ð¿Ð°Ñ€Ð°Ð»Ð»ÐµÐ»ÑŒÐ½Ð¾Ð¹ Ð·Ð°Ð³Ñ€ÑƒÐ·ÐºÐ¸)
    final results = await Future.wait([
      repo.getSettings(),
      repo.getWeights(),
      repo.getKickHistory(),
      repo.getRecentSymptoms(),
    ]);

    final settings = results[0] as dynamic; // PregnancySettings?
    final weights = results[1] as List<dynamic>; // List<HealthRecord>
    final kicks = results[2] as List<dynamic>; // List<HealthRecord>
    final symptoms = results[3] as List<String>;

    // 2. ÐŸÐ Ð•ÐžÐ‘Ð ÐÐ—Ð£Ð•Ðœ Ð’ DTO Ð”Ð›Ð¯ ÐžÐ¢Ð§Ð•Ð¢Ð
    final reportData = ReportData(
      userName: settings?.babyName ?? l10n.defaultMomName,
      currentWeek: settings?.currentWeek ?? 1,

      // ÐšÐ¾Ð½Ð²ÐµÑ€Ñ‚Ð¸Ñ€ÑƒÐµÐ¼ Ð¸ÑÑ‚Ð¾Ñ€Ð¸ÑŽ Ð²ÐµÑÐ°
      weightHistory: weights
          .where((w) => w.weightKg != null)
          .map((w) => WeightEntry(w.date, w.weightKg!))
          .toList(),

      // ÐšÐ¾Ð½Ð²ÐµÑ€Ñ‚Ð¸Ñ€ÑƒÐµÐ¼ Ð¸ÑÑ‚Ð¾Ñ€Ð¸ÑŽ Ð¿Ð¸Ð½ÐºÐ¾Ð²
      kickHistory: kicks
          .map((k) => KickSession(
              k.date,
              0, // Ð”Ð»Ð¸Ñ‚ÐµÐ»ÑŒÐ½Ð¾ÑÑ‚ÑŒ Ð¿Ð¾ÐºÐ° Ð½Ðµ Ñ…Ñ€Ð°Ð½Ð¸Ð¼, ÑÑ‚Ð°Ð²Ð¸Ð¼ 0
              k.totalKicks))
          .toList(),

      recentSymptoms: symptoms,
    );

    // 3. Ð“Ð•ÐÐ•Ð Ð˜Ð Ð£Ð•Ðœ PDF (ÐŸÐµÑ€ÐµÐ´Ð°ÐµÐ¼ l10n!)
    return PdfReportService().generateReport(reportData, locale, l10n);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          // Drag Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: mutedColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Ð—ÐÐ“ÐžÐ›ÐžÐ’ÐžÐš (Ð›Ð¾ÐºÐ°Ð»Ð¸Ð·Ð¾Ð²Ð°Ð½)
          Text(
            l10n.pdfReportTitle,
            style: theme.textTheme.displayLarge?.copyWith(fontSize: 24),
          ),

          const SizedBox(height: 16),

          // PREVIEW
          Expanded(
            child: FutureBuilder<Uint8List>(
              future: _pdfFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  // ÐŸÐ¾ÐºÐ°Ð·Ñ‹Ð²Ð°ÐµÐ¼ Ð¾ÑˆÐ¸Ð±ÐºÑƒ ÐºÑ€Ð°ÑÐ¸Ð²Ð¾
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline,
                              size: 48, color: Colors.red),
                          const SizedBox(height: 16),
                          Text(
                            "Error generating report:\n${snapshot.error}",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: mutedColor),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return Center(
                      child: Text(l10n.kickHistoryEmpty)); // "No data"
                }

                // Ð’Ð¸Ð´Ð¶ÐµÑ‚ PDF Preview
                return PdfPreview(
                  build: (format) => snapshot.data!,
                  allowPrinting: true,
                  allowSharing: true,
                  canChangeOrientation: false,
                  canChangePageFormat: false,
                  // Ð£Ð±Ð¸Ñ€Ð°ÐµÐ¼ Ð»Ð¸ÑˆÐ½Ð¸Ðµ Ð´ÐµÐ¹ÑÑ‚Ð²Ð¸Ñ, Ð¾ÑÑ‚Ð°Ð²Ð»ÑÐµÐ¼ Ñ‡Ð¸ÑÑ‚Ñ‹Ð¹ UI
                  actions: const [],
                  scrollViewDecoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                  ),
                  // Ð˜Ð¼Ñ Ñ„Ð°Ð¹Ð»Ð° Ð¿Ñ€Ð¸ ÑÐºÑÐ¿Ð¾Ñ€Ñ‚Ðµ
                  pdfFileName:
                      "Bloom_Report_${DateTime.now().millisecondsSinceEpoch}.pdf",
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
