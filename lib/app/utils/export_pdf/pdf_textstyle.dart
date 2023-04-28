import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfTextStyle {
  static final pw.TextStyle smallNormal = pw.TextStyle(
    color: PdfColors.grey800,
    fontSize: 8,
    fontWeight: pw.FontWeight.normal,
  );

  static final pw.TextStyle smallBold = pw.TextStyle(
    color: PdfColors.grey800,
    fontSize: 8,
    fontWeight: pw.FontWeight.bold,
  );
}
