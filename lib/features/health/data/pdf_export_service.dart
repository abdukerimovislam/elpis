import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../l10n/app_localizations.dart';
import '../../pregnancy/data/pregnancy_repository.dart';
import 'health_repository.dart';
import 'contraction_repository.dart';
import '../domain/health_record.dart';

final pdfExportServiceProvider = Provider<PdfExportService>((ref) {
  return PdfExportService(
    ref.watch(pregnancyRepositoryProvider),
    ref.watch(healthRepositoryProvider),
    ref.watch(contractionRepositoryProvider),
  );
});

class PdfExportService {
  final PregnancyRepository _pregnancyRepo;
  final HealthRepository _healthRepo;
  final ContractionRepository _contractionRepo;

  PdfExportService(
      this._pregnancyRepo, this._healthRepo, this._contractionRepo);

  Future<void> generateAndShareGeneralReport(
      BuildContext context, AppLocalizations l10n, String locale) async {
    // 1. Сбор данных
    final settings = await _pregnancyRepo.getSettings();
    final dueDate = settings?.estimatedDueDate;
    final momName = settings?.momName ?? l10n.pdfFallbackPatientName;
    final startWeight = settings?.prePregnancyWeightKg;
    final height = settings?.heightCm;

    String bmiString = '';
    if (startWeight != null && height != null && height > 0) {
      final heightM = height / 100;
      final bmi = startWeight / (heightM * heightM);
      bmiString = l10n.pdfBmiValue(bmi.toStringAsFixed(1));
    }

    // Получаем записи здоровья за последние 30 дней
    final now = DateTime.now();
    final healthRecords = <HealthRecord>[];
    for (int i = 0; i < 30; i++) {
      final date = now.subtract(Duration(days: i));
      final record = await _healthRepo.getRecordForDate(date);
      // Если запись не пустая (есть симптомы, вес, шевеления или вода)
      if ((record.symptoms ?? []).isNotEmpty ||
          record.weightKg != null ||
          record.totalKicks > 0 ||
          record.waterGlasses > 0) {
        healthRecords.add(record);
      }
    }

    final contractions = await _contractionRepo.watchHistory().first;

    // 2. Генерация PDF
    final doc = pw.Document();
    final ttf = await PdfGoogleFonts.robotoRegular();
    final ttfBold = await PdfGoogleFonts.robotoBold();

    // Обложка и сводка
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            // Заголовок
            pw.Header(
              level: 0,
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      l10n.paywallProTitle,
                      style: pw.TextStyle(
                          font: ttfBold,
                          fontSize: 28,
                          color: PdfColors.deepPurple),
                    ),
                    pw.Text(
                      l10n.pdfReportTitle,
                      style: pw.TextStyle(
                          font: ttf, fontSize: 16, color: PdfColors.grey700),
                    ),
                  ]),
            ),
            pw.SizedBox(height: 20),

            // Информация о пациенте
            pw.Container(
              padding: const pw.EdgeInsets.all(16),
              decoration: const pw.BoxDecoration(
                color: PdfColors.deepPurple50,
                borderRadius: pw.BorderRadius.all(pw.Radius.circular(12)),
              ),
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('${l10n.pdfPatient}$momName$bmiString',
                            style: pw.TextStyle(font: ttfBold, fontSize: 18)),
                        pw.SizedBox(height: 6),
                        pw.Text(
                            dueDate != null
                                ? '${l10n.pdfDueDate}${DateFormat.yMMMMd(locale).format(dueDate)}'
                                : l10n.pdfDueDateNotSet,
                            style: pw.TextStyle(font: ttf, fontSize: 14)),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(l10n.pdfReportDate,
                            style: pw.TextStyle(
                                font: ttf,
                                fontSize: 12,
                                color: PdfColors.grey)),
                        pw.SizedBox(height: 4),
                        pw.Text(
                            DateFormat.yMMMMd(locale).format(DateTime.now()),
                            style: pw.TextStyle(font: ttfBold, fontSize: 14)),
                      ],
                    )
                  ]),
            ),
            pw.SizedBox(height: 30),

            // Заголовок Сводки Здоровья
            pw.Text(l10n.pdfHealthSummaryTitle,
                style: pw.TextStyle(
                    font: ttfBold, fontSize: 20, color: PdfColors.deepPurple)),
            pw.SizedBox(height: 10),

            if (healthRecords.isEmpty)
              pw.Text(l10n.pdfNoHealthData,
                  style: pw.TextStyle(font: ttf, color: PdfColors.grey))
            else
              pw.TableHelper.fromTextArray(
                headers: [
                  l10n.pdfColDate,
                  l10n.pdfColWeight,
                  l10n.pdfColSymptoms,
                  l10n.pdfColKicks,
                  l10n.pdfColWater
                ],
                data: healthRecords.map((r) {
                  return [
                    DateFormat.MMMd(locale).format(r.date),
                    r.weightKg != null
                        ? '${r.weightKg!.toStringAsFixed(1)} kg'
                        : '-',
                    (r.symptoms ?? []).isNotEmpty
                        ? (r.symptoms ?? []).join('\n')
                        : l10n.pdfNone,
                    r.totalKicks > 0 ? '${r.totalKicks}' : '-',
                    r.waterGlasses > 0 ? '${r.waterGlasses}' : '-'
                  ];
                }).toList(),
                headerStyle: pw.TextStyle(
                    font: ttfBold, color: PdfColors.white, fontSize: 12),
                headerDecoration:
                    const pw.BoxDecoration(color: PdfColors.deepPurple),
                rowDecoration: const pw.BoxDecoration(
                    border: pw.Border(
                        bottom: pw.BorderSide(
                            color: PdfColors.grey300, width: 0.5))),
                cellStyle: pw.TextStyle(font: ttf, fontSize: 10),
                cellAlignment: pw.Alignment.centerLeft,
                cellPadding: const pw.EdgeInsets.all(8),
                oddRowDecoration:
                    const pw.BoxDecoration(color: PdfColors.grey100),
              ),

            pw.SizedBox(height: 40),

            // Заголовок Схваток
            pw.Text(l10n.pdfContractionsHistory,
                style: pw.TextStyle(
                    font: ttfBold, fontSize: 20, color: PdfColors.deepPurple)),
            pw.SizedBox(height: 10),

            if (contractions.isEmpty)
              pw.Text(l10n.pdfNoContractions,
                  style: pw.TextStyle(font: ttf, color: PdfColors.grey))
            else
              pw.TableHelper.fromTextArray(
                headers: [
                  l10n.contractionColStart,
                  l10n.contractionColDuration,
                  l10n.contractionColInterval
                ],
                data: contractions.map((item) {
                  final index = contractions.indexOf(item);
                  String interval = "-";
                  if (index < contractions.length - 1) {
                    final prev = contractions[index + 1];
                    final diff =
                        item.startTime.difference(prev.startTime).inMinutes;
                    interval = "$diff ${l10n.commonMin}";
                  }

                  return [
                    DateFormat.MMMd(locale).add_Hm().format(item.startTime),
                    "${item.durationInSeconds} ${l10n.commonSec}",
                    interval
                  ];
                }).toList(),
                headerStyle: pw.TextStyle(
                    font: ttfBold, color: PdfColors.white, fontSize: 12),
                headerDecoration:
                    const pw.BoxDecoration(color: PdfColors.deepPurple400),
                rowDecoration: const pw.BoxDecoration(
                    border: pw.Border(
                        bottom: pw.BorderSide(
                            color: PdfColors.grey300, width: 0.5))),
                cellStyle: pw.TextStyle(font: ttf, fontSize: 10),
                cellAlignment: pw.Alignment.center,
                cellPadding: const pw.EdgeInsets.all(8),
                oddRowDecoration:
                    const pw.BoxDecoration(color: PdfColors.grey100),
              ),

            pw.SizedBox(height: 40),
            pw.Align(
              alignment: pw.Alignment.bottomCenter,
              child: pw.Text(
                l10n.pdfFooter,
                style: pw.TextStyle(
                    font: ttf, fontSize: 10, color: PdfColors.grey),
              ),
            ),
          ];
        },
      ),
    );

    final bytes = await doc.save();
    await Printing.sharePdf(
        bytes: bytes,
        filename:
            '${l10n.pdfHealthFilePrefix}_${DateTime.now().millisecondsSinceEpoch}.pdf');
  }
}
