import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'pdf_textstyle.dart';

class PdfSection {
  final String header;
  final List<List<dynamic>> rows;
  final bool isImage;

  PdfSection({required this.header, required this.rows, required this.isImage});

  pw.Widget get content {
    List<pw.Widget> sectionRows = [
      ...rows.map((row) {
        return _PdfSectionRow(label: row[0], value: row[1], isImage: isImage)
            .content;
      })
    ];
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
          ...sectionRows,
        ],
      ),
    );
  }
}

class _PdfSectionRow {
  final String label;
  final dynamic value;
  final bool isImage;

  _PdfSectionRow(
      {required this.label, required this.value, required this.isImage});

  pw.Widget get content {
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
            child: pw.Text(label, style: PdfTextStyle.labelMedium),
          ),
          pw.Expanded(
            child: !isImage
                ? pw.Text(value, style: PdfTextStyle.bodyMedium)
                : pw.Image(value, width: PdfPageFormat.inch * 4),
          ),
        ],
      ),
    );
  }
}
