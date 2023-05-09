import 'package:flutter_sandbox_web/app/helpers/export_data/export_data.dart';

class CredentialsTable {
  List<PdfTableColumn> columns;
  List<Map<String, dynamic>> rows;

  CredentialsTable({required this.columns, required this.rows});

  factory CredentialsTable.fromJson({json}) {
    return CredentialsTable(
      columns: [
        PdfTableColumn(field: 'requestId'),
        PdfTableColumn(field: 'fullName'),
        PdfTableColumn(
          field: 'birthdate',
          formatter: (value) => value.split('T')[0],
        ),
        PdfTableColumn(field: 'created'),
        PdfTableColumn(field: 'channel_issuer_id', header: 'Channel'),
        PdfTableColumn(field: 'status'),
      ],
      rows: json,
    );
  }
}
