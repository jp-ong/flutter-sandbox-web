import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// PDF text styles that can be used when generating
/// PDF files using the pdf library.
class PdfTextStyle {
  /// Small table headers
  ///
  /// The [color] property sets the color of the text to `PdfColors.grey700`.
  ///
  /// The [fontSize] property sets the font size to `8`.
  ///
  /// The [fontWeight] property sets the font weight to `pw.FontWeight.bold`.
  static final tableHeaderSmall = pw.TextStyle(
    color: PdfColors.grey700,
    fontSize: 8,
    fontWeight: pw.FontWeight.bold,
  );

  /// For small table data
  ///
  /// The [color] property sets the color of the text to `PdfColors.grey900`.
  ///
  /// The [fontSize] property sets the font size to `8`.
  ///
  /// The [fontWeight] property sets the font weight to `pw.FontWeight.normal`.
  static final tableDataSmall = pw.TextStyle(
    color: PdfColors.grey900,
    fontSize: 8,
    fontWeight: pw.FontWeight.normal,
  );
}
