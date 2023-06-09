import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:csv/csv.dart';

import 'src/enums/enums.dart';
import 'src/utils/utils.dart';
import 'src/classes/pdf_table.dart';
import 'src/classes/pdf_table_column.dart';
import 'src/classes/csv_table_column.dart';
import 'src/classes/pdf_headline.dart';
import 'src/classes/pdf_section.dart';

export 'src/enums/enums.dart';
export 'src/classes/pdf_table_column.dart';
export 'src/classes/csv_table_column.dart';
export 'src/classes/pdf_headline.dart';
export 'src/classes/pdf_section.dart';
export 'src/classes/pdf_section_row.dart';

class ExportData {
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
  /// await ExportData.tableAsPDF(
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

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        build: (context) {
          PdfTable pdfTable = PdfTable(columns: columns, rows: rows);
          return [
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.grey300,
                  width: 0.75,
                ),
              ),
              child: pdfTable.content,
            )
          ];
        },
      ),
    );

    saveFile(
      contentType: ContentType.pdf,
      data: await pdf.save(),
      fileExtension: FileExtension.pdf,
      fileName: fileName ?? 'table_${DateTime.now().toIso8601String()}',
    );
  }

  /// Generates a PDF document with a headline and a body consisting of multiple sections.
  ///
  /// [headline]: The headline to be displayed at the top of the PDF document.
  ///
  /// [body]: A list of [PdfSection] objects representing the content of the body.
  ///
  /// [fileName]: The name of the file to save the PDF document as. If not provided, the file
  /// will be named "details_[current datetime].pdf".
  static Future<void> detailsAsPDF({
    required PdfHeadline headline,
    required List<PdfSection> body,
    String? fileName,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        build: (context) {
          return [
            headline.content,
            ...body.map((b) => b.content),
          ];
        },
      ),
    );

    saveFile(
      contentType: ContentType.pdf,
      data: await pdf.save(),
      fileExtension: FileExtension.pdf,
      fileName: fileName ?? 'details_${DateTime.now().toIso8601String()}',
    );
  }

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
  /// await ExportData.tableAsCSV(
  ///   column:[
  ///     CsvTableColumn(
  ///       field: 'userId',
  ///       header: 'User ID',
  ///       formatter: (value) => '${value.substring(0,7)}***',
  ///     ),
  ///     CsvTableColumn(
  ///       field: 'fullName',
  ///       header: 'Full Name',
  ///       fullWidth: true,
  ///     ),
  ///     CsvTableColumn(
  ///       field: 'age',
  ///       header: 'Age',
  ///     ),
  ///     CsvTableColumn(
  ///       field: 'birthdate',
  ///       header: 'Birth Date',
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
  static Future<void> tableAsCSV({
    required List<CsvTableColumn> columns,
    required List<dynamic> rows,
    String? fileName,
  }) async {
    List<String> headers = [...columns.map((col) => col.header ?? col.field)];
    List<List<String>> body = [
      ...rows.map(
        (row) => [
          ...columns.map((col) {
            return getFormattedValue(
              col.formatter,
              getMapValue(
                col.field,
                row,
              ),
            );
          }),
        ],
      ),
    ];

    String csvData = const ListToCsvConverter().convert([headers, ...body]);
    saveFile(
      contentType: ContentType.csv,
      data: csvData,
      fileExtension: FileExtension.csv,
      fileName: fileName ?? 'table_${DateTime.now().toIso8601String()}',
    );
  }
}
