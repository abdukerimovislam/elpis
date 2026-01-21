import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import '../../../l10n/app_localizations.dart';

class ReportData {
  final String userName;
  final int currentWeek;
  final List<WeightEntry> weightHistory;
  final List<KickSession> kickHistory;
  final List<String> recentSymptoms;

  ReportData({
    required this.userName,
    required this.currentWeek,
    required this.weightHistory,
    required this.kickHistory,
    required this.recentSymptoms,
  });
}

class WeightEntry {
  final DateTime date;
  final double value;
  WeightEntry(this.date, this.value);
}

class KickSession {
  final DateTime date;
  final int durationSeconds;
  final int count;
  KickSession(this.date, this.durationSeconds, this.count);
}

class PdfReportService {
  static const PdfColor _primaryColor = PdfColor.fromInt(0xFF7A9E7E);
  static const PdfColor _textColor = PdfColor.fromInt(0xFF333333);
  static const PdfColor _lightGrey = PdfColor.fromInt(0xFFF5F5F5);

  Future<Uint8List> generateReport(ReportData data, String locale, AppLocalizations l10n) async {
    final doc = pw.Document();

    final fontRegular = await PdfGoogleFonts.robotoRegular();
    final fontBold = await PdfGoogleFonts.robotoBold();
    final fontItalic = await PdfGoogleFonts.robotoItalic();

    final dateFormat = DateFormat.yMMMd(locale);

    doc.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          margin: const pw.EdgeInsets.all(40),
          theme: pw.ThemeData.withFont(
            base: fontRegular,
            bold: fontBold,
            italic: fontItalic,
          ),
        ),
        header: (context) => _buildHeader(data, dateFormat, l10n),
        footer: (context) => _buildFooter(context, l10n),
        build: (context) => [
          _buildSummarySection(data, l10n),
          pw.SizedBox(height: 20),
          _buildWeightSection(data.weightHistory, dateFormat, l10n),
          pw.SizedBox(height: 20),
          _buildKicksSection(data.kickHistory, dateFormat, l10n),
          pw.SizedBox(height: 20),
          _buildSymptomsSection(data.recentSymptoms, l10n),
        ],
      ),
    );

    return doc.save();
  }

  // --- WIDGETS ---

  pw.Widget _buildHeader(ReportData data, DateFormat fmt, AppLocalizations l10n) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(l10n.pdfReportTitle,
                style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    color: _primaryColor)),
            pw.Text(l10n.weightWeek(data.currentWeek),
                style: const pw.TextStyle(fontSize: 18, color: PdfColors.grey)),
          ],
        ),
        pw.SizedBox(height: 5),
        pw.Text("${l10n.generatedDate}: ${fmt.format(DateTime.now())}",
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600)),
        pw.Divider(color: _primaryColor, thickness: 1),
        pw.SizedBox(height: 20),
      ],
    );
  }

  pw.Widget _buildSummarySection(ReportData data, AppLocalizations l10n) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        color: _lightGrey,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(l10n.weightWeek(data.currentWeek), ""),
          _buildStatItem(l10n.weightTitle, "${data.weightHistory.length}"),
          _buildStatItem(l10n.kickTitle, "${data.kickHistory.length}"),
        ],
      ),
    );
  }

  pw.Widget _buildStatItem(String label, String value) {
    return pw.Column(
      children: [
        pw.Text(value.isEmpty ? " " : value,
            style: pw.TextStyle(
                fontSize: 20, fontWeight: pw.FontWeight.bold, color: _textColor)),
        pw.Text(label,
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
      ],
    );
  }

  pw.Widget _buildWeightSection(List<WeightEntry> history, DateFormat fmt, AppLocalizations l10n) {
    if (history.isEmpty) return pw.Container();

    List<List<String>> tableData = [];
    for (int i = 0; i < history.length; i++) {
      final item = history[i];
      String change = "-";

      // Логика расчета разницы веса (опционально)
      // if (i < history.length - 1) { ... }

      tableData.add([
        fmt.format(item.date),
        item.value.toStringAsFixed(1),
        change
      ]);
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(l10n.weightTitle,
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 10),
        pw.TableHelper.fromTextArray(
          headers: [l10n.dateLabel, l10n.weightUnitLabel, l10n.changeLabel],
          data: tableData,
          headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
          headerDecoration: const pw.BoxDecoration(color: _primaryColor),
          rowDecoration: const pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300))),
          cellAlignment: pw.Alignment.centerLeft,
          cellPadding: const pw.EdgeInsets.all(5),
        ),
      ],
    );
  }

  pw.Widget _buildKicksSection(List<KickSession> history, DateFormat fmt, AppLocalizations l10n) {
    if (history.isEmpty) return pw.Container();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(l10n.kickTitle,
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 10),
        pw.TableHelper.fromTextArray(
          headers: [l10n.dateLabel, l10n.durationLabel, l10n.kickCountLabel],
          data: history.map((e) => [
            fmt.format(e.date),
            "${(e.durationSeconds / 60).toStringAsFixed(0)} min",
            "${e.count}",
          ]).toList(),
          headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
          headerDecoration: const pw.BoxDecoration(color: _primaryColor),
          rowDecoration: const pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300))),
          cellAlignment: pw.Alignment.centerLeft,
        ),
      ],
    );
  }

  pw.Widget _buildSymptomsSection(List<String> symptoms, AppLocalizations l10n) {
    if (symptoms.isEmpty) return pw.Container();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(l10n.symptomsTitle,
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 10),
        pw.Wrap(
          spacing: 10,
          runSpacing: 10,
          children: symptoms.map((s) => pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: _primaryColor),
              borderRadius: pw.BorderRadius.circular(10),
            ),
            child: pw.Text(s),
          )).toList(),
        ),
      ],
    );
  }

  pw.Widget _buildFooter(pw.Context context, AppLocalizations l10n) {
    return pw.Column(
      children: [
        pw.Divider(color: PdfColors.grey300),
        pw.SizedBox(height: 5),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
                l10n.pdfDisclaimer,
                style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey)),
            pw.Text("${context.pageNumber} / ${context.pagesCount}",
                style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey)),
          ],
        )
      ],
    );
  }
}