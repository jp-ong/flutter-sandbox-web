import 'package:flutter_sandbox_web/app/helpers/export_data/src/classes/pdf_textstyle.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Headline section of a PDF document.
class PdfHeadline {
  final String title;
  final String dateTime;
  final String status;
  pw.Widget content = pw.SizedBox.shrink();

  PdfHeadline.akin({
    required this.title,
    required this.dateTime,
    required this.status,
  }) {
    pw.Widget buildStatus(String status) {
      PdfColor textColor = PdfColors.white;
      PdfColor backgroundColor = PdfColors.black;
      String statusText = status;
      pw.TextStyle textStyle = PdfTextStyle.labelSmall;

      switch (status) {
        case 'VERIFIED':
          textColor = PdfColor.fromHex('#3A843F');
          backgroundColor = PdfColor.fromHex('#E4F7EC');
          statusText = 'Fully Verified';
          break;
        case 'NEEDS_ACTION':
          textColor = PdfColor.fromHex('#E89937');
          backgroundColor = PdfColor.fromHex('#FCF7E1');
          statusText = 'Needs Action';
          break;
        case 'REJECTED':
          textColor = PdfColor.fromHex('#C0492C');
          backgroundColor = PdfColor.fromHex('#F6E9E7');
          statusText = 'Rejected';
          break;
        case 'REVOKED':
          textColor = PdfColor.fromHex('#3363BB');
          backgroundColor = PdfColor.fromHex('#E5F2FD');
          statusText = 'Revoked';
          break;
        case 'EXPIRED':
          textColor = PdfColor.fromHex('#50535E');
          backgroundColor = PdfColor.fromHex('#EEEEEE');
          statusText = 'Expired';
          break;
        default:
          break;
      }

      return pw.Container(
        padding: const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: pw.BoxDecoration(
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
          color: backgroundColor,
        ),
        child: pw.Text(
          statusText,
          style: pw.TextStyle(
            color: textColor,
            fontSize: textStyle.fontSize,
            fontWeight: textStyle.fontWeight,
          ),
        ),
      );
    }

    content = pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title, style: PdfTextStyle.h1),
        pw.SizedBox(height: PdfPageFormat.inch * .075),
        pw.Row(
          children: [
            pw.Text(dateTime, style: PdfTextStyle.labelSmall),
            pw.SizedBox(width: PdfPageFormat.inch * .1),
            buildStatus(status),
          ],
        )
      ],
    );
  }
}
