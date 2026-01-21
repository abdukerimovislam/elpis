import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../pregnancy/data/pregnancy_repository.dart'; // Импорт репозитория
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
    // Запускаем генерацию один раз при открытии
    if (_pdfFuture == null) {
      _pdfFuture = _generatePdf();
    }
  }

  Future<Uint8List> _generatePdf() async {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final repo = ref.read(pregnancyRepositoryProvider);

    // 1. ПОЛУЧАЕМ РЕАЛЬНЫЕ ДАННЫЕ ИЗ БАЗЫ
    // (используем Future.wait для параллельной загрузки)
    final results = await Future.wait([
      repo.getSettings(),
      repo.getWeights(),
      repo.getKickHistory(),
    ]);

    final settings = results[0] as dynamic; // PregnancySettings?
    final weights = results[1] as List<dynamic>; // List<HealthRecord>
    final kicks = results[2] as List<dynamic>; // List<HealthRecord>

    // 2. ПРЕОБРАЗУЕМ В DTO ДЛЯ ОТЧЕТА
    final reportData = ReportData(
      userName: settings?.babyName ?? "Mom-to-be", // Имя ребенка или мамы
      currentWeek: settings?.currentWeek ?? 1,

      // Конвертируем историю веса
      weightHistory: weights
          .where((w) => w.weightKg != null)
          .map((w) => WeightEntry(w.date, w.weightKg!))
          .toList(),

      // Конвертируем историю пинков
      kickHistory: kicks.map((k) => KickSession(
          k.date,
          0, // Длительность пока не храним, ставим 0
          k.totalKicks
      )).toList(),

      // Симптомы (пока заглушка, так как нет истории симптомов в этом репозитории)
      recentSymptoms: [
        l10n.symptomsTitle, // Просто пример
      ],
    );

    // 3. ГЕНЕРИРУЕМ PDF (Передаем l10n!)
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
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: mutedColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ЗАГОЛОВОК (Локализован)
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
                  // Показываем ошибку красиво
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, size: 48, color: Colors.red),
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
                  return Center(child: Text(l10n.kickHistoryEmpty)); // "No data"
                }

                // Виджет PDF Preview
                return PdfPreview(
                  build: (format) => snapshot.data!,
                  allowPrinting: true,
                  allowSharing: true,
                  canChangeOrientation: false,
                  canChangePageFormat: false,
                  // Убираем лишние действия, оставляем чистый UI
                  actions: const [],
                  scrollViewDecoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                  ),
                  // Имя файла при экспорте
                  pdfFileName: "Bloom_Report_${DateTime.now().millisecondsSinceEpoch}.pdf",
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}