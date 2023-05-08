import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'pdf_textstyle.dart';

/// A Row within a section of a PDF document.
class PdfSectionRow {
  final String label;
  final dynamic value;

  pw.Widget content = pw.SizedBox.shrink();

  PdfSectionRow.text({
    required this.label,
    required this.value,
  }) {
    content = _rowContainer([
      pw.SizedBox(
        width: PdfPageFormat.inch * 1.5,
        child: pw.Text(label, style: PdfTextStyle.labelMedium),
      ),
      pw.Expanded(child: pw.Text(value, style: PdfTextStyle.bodyMedium)),
    ]);
  }

  PdfSectionRow.image({
    required this.label,
    required this.value,
  }) {
    content = _rowContainer([
      pw.SizedBox(
        width: PdfPageFormat.inch * 1.5,
        child: pw.Text(label, style: PdfTextStyle.labelMedium),
      ),
      pw.Expanded(
        child: pw.Image(value, width: PdfPageFormat.inch * 4),
      ),
    ]);
  }

  _rowContainer(List<pw.Widget> rowContent) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(
        vertical: PdfPageFormat.inch * .05,
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: rowContent,
      ),
    );
  }
}
