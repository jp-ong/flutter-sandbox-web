import 'dart:html' as html;
import 'dart:math';
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

class ExportData {
  static void asPDF({
    required String fullName,
    required String dateTime,
    required String status,
    required List<List<String>> personalInfo,
    required List<List<String>> documents,
  }) async {
    final pdf = pw.Document();

    pw.Widget documentHeader = _PdfHeader(
      header: fullName,
      dateTime: dateTime,
      status: _getStatus(status),
    ).content;

    pw.Widget personalInfoSection = _PdfSection(
      header: 'Personal Information',
      rows: personalInfo,
    ).content;

    pw.Widget documentsSection = _PdfSection(
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
      fileName: 'details_${DateTime.now().toIso8601String()}',
    );
  }

  static void tableAsPDF({
    required List<String> headers,
    required List<List<String>> rows,
  }) async {
    final pdf = pw.Document();

    pw.Widget documentTable = _PdfTable(headers: headers, rows: rows).content;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        build: (context) {
          return [
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.grey300,
                  width: 0.75,
                ),
              ),
              child: documentTable,
            ),
          ];
        },
      ),
    );

    _saveFile(
      contentType: ContentType.pdf,
      data: await pdf.save(),
      fileExtension: FileExtension.pdf,
      fileName: 'table_${DateTime.now().toIso8601String()}',
    );
  }

  static void tableAsCSV({
    required List<String> headers,
    required List<List<String>> rows,
  }) {
    String csvData = const ListToCsvConverter().convert([headers, ...rows]);

    _saveFile(
      contentType: ContentType.csv,
      data: csvData,
      fileExtension: FileExtension.csv,
      fileName: 'table_${DateTime.now().toIso8601String()}',
    );
  }

  static void _saveFile({
    required dynamic data,
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

class _PdfTable {
  final List<String> headers;
  final List<List<String>> rows;

  _PdfTable({
    required this.headers,
    required this.rows,
  });

  pw.Table get content {
    pw.TableRow tableHeaders = _PdfTableHeader(headers: headers).content;
    List<pw.TableRow> tableBody = _PdfTableBody(rows: rows).content;
    return pw.Table(
      border: const pw.TableBorder(
        horizontalInside: pw.BorderSide(
          color: PdfColors.grey300,
          width: 0.5,
        ),
        verticalInside: pw.BorderSide(
          color: PdfColors.grey300,
          width: 0.5,
        ),
      ),
      children: [tableHeaders, ...tableBody],
    );
  }
}

class _PdfTableHeader {
  final List<String> headers;

  _PdfTableHeader({required this.headers});

  pw.TableRow get content {
    return pw.TableRow(children: [
      ...headers.map((header) {
        return pw.Container(
          padding: const pw.EdgeInsets.all(3),
          child: pw.Text(
            header,
            style: _PdfTextStyle.tableHeader,
          ),
        );
      })
    ]);
  }
}

class _PdfTableBody {
  final List<List<String>> rows;

  _PdfTableBody({required this.rows});

  List<pw.TableRow> get content {
    return [
      ...rows.map((row) {
        return pw.TableRow(children: [
          ...row.map((r) {
            return pw.Container(
              padding: const pw.EdgeInsets.all(3),
              child: pw.Text(
                _getStatus(r),
                style: _PdfTextStyle.tableData,
              ),
            );
          })
        ]);
      })
    ];
  }
}

class _PdfHeader {
  final String header;
  final String dateTime;
  final String status;

  _PdfHeader({
    required this.header,
    required this.dateTime,
    required this.status,
  });

  pw.Widget get content {
    return pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(header, style: _PdfTextStyle.h1),
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

class _PdfSection {
  final String header;
  final List<List<String>> rows;

  _PdfSection({
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
          pw.Text(header, style: _PdfTextStyle.h2),
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
                    child: pw.Text(row[0], style: _PdfTextStyle.labelMedium),
                  ),
                  pw.Expanded(
                    child: pw.Text(row[1], style: _PdfTextStyle.bodyMedium),
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

class _PdfTextStyle {
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
    fontWeight: pw.FontWeight.bold,
  );

  static final bodyMedium = pw.TextStyle(
    color: PdfColors.grey800,
    fontSize: 12,
    fontWeight: pw.FontWeight.normal,
  );

  static final bodySmall = pw.TextStyle(
    color: PdfColors.grey800,
    fontSize: 10,
    fontWeight: pw.FontWeight.normal,
  );

  static final tableHeader = pw.TextStyle(
    color: PdfColors.grey700,
    fontSize: 8,
    fontWeight: pw.FontWeight.bold,
  );

  static final tableData = pw.TextStyle(
    color: PdfColors.grey900,
    fontSize: 8,
    fontWeight: pw.FontWeight.normal,
  );
}

String _getStatus(String status) {
  switch (status) {
    case 'VERIFIED':
      return 'Fully Verified';
    case 'NEEDS_ACTION':
      return 'Needs Action';
    case 'REVOKED':
      return 'Revoked';
    case 'REJECTED':
      return 'Rejected';
    case 'EXPIRED':
      return 'Expired';
    default:
      return status;
  }
}
