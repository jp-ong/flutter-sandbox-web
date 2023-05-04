import 'dart:html' as html;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

enum FileExtension {
  pdf,
  csv,
}

enum PdfTableColumnAlign {
  left,
  center,
  right,
}

enum ContentType {
  pdf('application/pdf'),
  csv('text/csv');

  final String type;
  const ContentType(this.type);
}

class ExportDataV2 {
  /// Builds and downloads a PDF file containing tabularized data.
  ///
  /// ---
  /// Given the following data:
  /// ```json
  /// [
  ///   {
  ///     "userId": "e179f83c783ac8730f633dcda67e9195",
  ///     "fullName": "John Paul Ong",
  ///     "age": 25,
  ///     "birthdate": "1865-04-29T00:00:00.000Z",
  ///   },
  ///   // ...
  /// ]
  /// ```
  /// ---
  /// Example:
  /// ```dart
  /// await ExportDataV2.tableAsPDF(
  ///   column:[
  ///     PdfTableColumn(
  ///       field: 'userId',
  ///       header: 'User ID',
  ///       formatter: (value) => '${value.substring(0,7)}***',
  ///     ),
  ///     PdfTableColumn(
  ///       field: 'fullName',
  ///       header: 'Full Name',
  ///       fullWidth: true,
  ///     ),
  ///     PdfTableColumn(
  ///       field: 'age',
  ///       header: 'Age',
  ///       align: PdfTableColumnAlign.right,
  ///     ),
  ///     PdfTableColumn(
  ///       field: 'birthdate',
  ///       header: 'Birth Date',
  ///       align: PdfTableColumnAlign.center,
  ///       formatter: (value) => value.split('T')[0],
  ///     ),
  ///   ],
  ///   row:[...users.map((user) => user.toJson())],
  /// );
  /// ```
  /// ---
  /// Output:
  /// | User ID | Full Name | Age | Birth Date |
  /// | :--------- | :--------- | ---------: | :---------: |
  /// | e179f83c*** | John Paul Ong | 25 | 1865-04-29 |
  /// | <img width=100/> | <img width=200/>| <img width=100/> | <img width=100/> |
  static Future<void> tableAsPDF({
    required List<PdfTableColumn> columns,
    required List<dynamic> rows,
    String? fileName,
  }) async {
    final pdf = pw.Document();
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

    pw.TableRow tableHeader = pw.TableRow(
      children: [
        ...columns.map(
          (col) => pw.Container(
            alignment: getAlignment(col.align),
            padding: const pw.EdgeInsets.all(3),
            child: pw.Text(
              col.header ?? col.field,
              style: _PdfTextStyle.tableHeaderSmall,
            ),
          ),
        ),
      ],
    );

    String getFormattedValue(
      String Function(String)? formatter,
      String value,
    ) {
      String formattedValue = value;
      try {
        if (formatter != null && value.isNotEmpty) {
          formattedValue = formatter(value);
        }
      } catch (e) {
        formattedValue = value;
      }
      return formattedValue;
    }

    dynamic getMapValue(String key, Map map) {
      return map.containsKey(key) ? map[key] : '';
    }

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
                style: _PdfTextStyle.tableDataSmall,
              ),
            ),
          ),
        ],
      ),
    );

    pw.BorderSide tableBorder = const pw.BorderSide(
      color: PdfColors.grey300,
      width: 0.5,
    );

    pw.Table table = pw.Table(
      border: pw.TableBorder(
        horizontalInside: tableBorder,
        verticalInside: tableBorder,
      ),
      children: [tableHeader, ...tableBody],
    );

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
              child: table,
            )
          ];
        },
      ),
    );

    _saveFile(
      contentType: ContentType.pdf,
      data: await pdf.save(),
      fileExtension: FileExtension.pdf,
      fileName: fileName ?? 'table_${DateTime.now().toIso8601String()}',
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

/// Represents a colum and its configurations.
class PdfTableColumn {
  /// Key of the object's property to be displayed as this column's data.
  final String field;

  /// Text to display as this column's header.
  ///
  /// Defaults to `field` if no `header` provided.
  String? header;

  /// Provides access to this column's data for modification.
  ///
  /// Example:
  /// ```dart
  /// PdfTableColumn(
  ///     field: 'longId',
  ///     header: 'Long ID',
  ///     formatter: (value) => value.substring(0, 7), // <-- Modifies the data to display only the first 8 characters
  /// );
  /// ```
  final String Function(String value)? formatter;

  /// Allows this column to expand and push others to their minimum widths.
  bool? fullWidth = false;

  /// Aligns the text in this column's cells
  PdfTableColumnAlign? align = PdfTableColumnAlign.left;

  PdfTableColumn({
    required this.field,
    this.header,
    this.formatter,
    this.fullWidth,
    this.align,
  });
}

class _PdfTextStyle {
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
}
