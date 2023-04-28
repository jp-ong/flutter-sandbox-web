import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sandbox_web/app/utils/export_pdf/export_pdf.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:csv/csv.dart';

enum FileExtension {
  pdf,
  csv,
}

enum ContentType {
  pdf('application/pdf'),
  csv('text/csv');

  final String type;
  const ContentType(this.type);
}

class PdfHeader {
  final String header;
  final String dateTime;
  final String status;

  PdfHeader({
    required this.header,
    required this.dateTime,
    required this.status,
  });

  pw.Widget get content {
    return pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(header, style: PdfTextStyle.h1),
        pw.SizedBox(height: PdfPageFormat.inch * .075),
        pw.Row(
          children: [
            pw.Text(dateTime, style: labelSmall),
            pw.SizedBox(width: PdfPageFormat.inch * .075),
            pw.Text(status),
          ],
        )
      ],
    );
  }
}

class PdfSection {
  final String header;
  final List<List<String>> rows;

  PdfSection({
    required this.header,
    required this.rows,
  });

  pw.Widget get content {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey200),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
      ),
      padding: const pw.EdgeInsets.symmetric(
        vertical: PdfPageFormat.inch * .125,
        horizontal: PdfPageFormat.inch * .125,
      ),
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(header, style: PdfTextStyle.h2),
          pw.Divider(
            color: PdfColors.grey200,
            height: PdfPageFormat.inch * .25,
          ),
          ...rows.map((row) {
            return pw.Container(
              padding: const pw.EdgeInsets.symmetric(
                vertical: PdfPageFormat.inch * .05,
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(
                    width: PdfPageFormat.inch * 1.5,
                    child: pw.Text(row[0], style: PdfTextStyle.labelMedium),
                  ),
                  pw.Expanded(
                    child: pw.Text(row[1], style: PdfTextStyle.bodyMedium),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class ExportData {
  static void asPDF({
    required String fullName,
    required String dateTime,
    required String status,
    required List<List<String>> personalInfo,
    required List<List<String>> documents,
  }) async {
    final pdf = pw.Document();

    pw.Widget documentHeader = PdfHeader(
      header: fullName,
      dateTime: dateTime,
      status: status,
    ).content;

    pw.Widget personalInfoSection = PdfSection(
      header: 'Personal Information',
      rows: personalInfo,
    ).content;

    pw.Widget documentsSection = PdfSection(
      header: 'Documents',
      rows: documents,
    ).content;

    pw.Widget sectionGap = pw.SizedBox(height: PdfPageFormat.inch * .125);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        build: (context) {
          return [
            documentHeader,
            sectionGap,
            personalInfoSection,
            sectionGap,
            documentsSection,
          ];
        },
      ),
    );

    _saveFile(
      contentType: ContentType.pdf,
      data: await pdf.save(),
      fileExtension: FileExtension.pdf,
      fileName: DateTime.now().toIso8601String(),
    );
  }

  static void _saveFile({
    required Uint8List data,
    required String fileName,
    required FileExtension fileExtension,
    required ContentType contentType,
  }) {
    final blob = html.Blob([data], contentType.type);
    html.AnchorElement(href: html.Url.createObjectUrlFromBlob(blob))
      ..setAttribute('download', '$fileName.${fileExtension.name}')
      ..click();
  }
}

class PdfTextStyle {
  static final h1 = pw.TextStyle(
    color: PdfColors.grey900,
    fontSize: 16,
    fontWeight: pw.FontWeight.bold,
  );

  static final h2 = pw.TextStyle(
    color: PdfColors.grey900,
    fontSize: 14,
    fontWeight: pw.FontWeight.bold,
  );

  static final labelMedium = pw.TextStyle(
    color: PdfColors.grey500,
    fontSize: 12,
    fontWeight: pw.FontWeight.normal,
  );

  static final labelSmall = pw.TextStyle(
    color: PdfColors.grey500,
    fontSize: 10,
    fontWeight: pw.FontWeight.normal,
  );

  static final bodyMedium = pw.TextStyle(
    color: PdfColors.grey800,
    fontSize: 12,
    fontWeight: pw.FontWeight.normal,
  );
}
