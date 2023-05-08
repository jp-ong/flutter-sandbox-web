import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../enums/enums.dart';
import '../utils/utils.dart';
import 'pdf_table_column.dart';
import 'pdf_textstyle.dart';

/// Table to be included in a PDF file.
class PdfTable {
  /// The list of table columns.
  final List<PdfTableColumn> columns;

  /// The list of table rows.
  final List<dynamic> rows;

  PdfTable({required this.columns, required this.rows});

  pw.Table get content {
    pw.Alignment getAlignment(PdfTableColumnAlign? a) {
      switch (a) {
        case PdfTableColumnAlign.right:
          return pw.Alignment.topRight;
        case PdfTableColumnAlign.center:
          return pw.Alignment.topCenter;
        case PdfTableColumnAlign.left:
        default:
          return pw.Alignment.topLeft;
      }
    }

    pw.BorderSide tableBorder = const pw.BorderSide(
      color: PdfColors.grey300,
      width: 0.5,
    );

    pw.TableRow tableHeader = pw.TableRow(
      children: [
        ...columns.map(
          (col) => pw.Container(
            alignment: getAlignment(col.align),
            padding: const pw.EdgeInsets.all(3),
            child: pw.Text(
              col.header ?? col.field,
              style: PdfTextStyle.tableHeaderSmall,
            ),
          ),
        ),
      ],
    );

    Iterable<pw.TableRow> tableBody = rows.map(
      (row) => pw.TableRow(
        children: [
          ...columns.map(
            (col) => pw.Container(
              alignment: getAlignment(col.align),
              padding: const pw.EdgeInsets.all(3),
              width: col.fullWidth == true ? double.infinity : null,
              child: pw.Text(
                getFormattedValue(
                  col.formatter,
                  getMapValue(
                    col.field,
                    row,
                  ),
                ),
                style: PdfTextStyle.tableDataSmall,
              ),
            ),
          ),
        ],
      ),
    );

    return pw.Table(
      border: pw.TableBorder(
        horizontalInside: tableBorder,
        verticalInside: tableBorder,
      ),
      children: [tableHeader, ...tableBody],
    );
  }
}
