import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'pdf_textstyle.dart';

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
            pw.Text(dateTime, style: PdfTextStyle.labelSmall),
            pw.SizedBox(width: PdfPageFormat.inch * .075),
            pw.Text(status),
          ],
        )
      ],
    );
  }
}
