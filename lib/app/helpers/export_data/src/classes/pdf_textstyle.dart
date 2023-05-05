import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// PDF text styles that can be used when generating
/// PDF files using the pdf library.
class PdfTextStyle {
  static final tableHeaderSmall = pw.TextStyle(
    color: PdfColors.grey700,
    fontSize: 8,
    fontWeight: pw.FontWeight.bold,
  );

  static final tableDataSmall = pw.TextStyle(
    color: PdfColors.grey900,
    fontSize: 8,
    fontWeight: pw.FontWeight.normal,
  );

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
}
