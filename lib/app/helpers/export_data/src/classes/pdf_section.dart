import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'pdf_textstyle.dart';
import 'pdf_section_row.dart';

/// Section within a PDF document
class PdfSection {
  final String heading;
  List<PdfSectionRow> rows = [];
  pw.Widget content = pw.SizedBox.shrink();

  PdfSection.rows({required this.heading, required this.rows}) {
    List<pw.Widget> sectionRows = [
      ...rows.map((row) {
        return row.content;
      })
    ];
    content = pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey200),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
      ),
      margin: const pw.EdgeInsets.only(top: PdfPageFormat.inch * .25),
      padding: const pw.EdgeInsets.symmetric(
        vertical: PdfPageFormat.inch * .125,
        horizontal: PdfPageFormat.inch * .125,
      ),
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(heading, style: PdfTextStyle.h2),
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
