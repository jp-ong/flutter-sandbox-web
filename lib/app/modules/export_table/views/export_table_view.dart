import 'package:flutter/material.dart';
import 'package:flutter_sandbox_web/app/utils/export_table_csv.dart';
import 'package:flutter_sandbox_web/app/utils/export_table_pdf.dart';

import 'package:get/get.dart';

import '../controllers/export_table_controller.dart';

class ExportTableView extends GetView<ExportTableController> {
  const ExportTableView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExportTableView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Export as PDF'),
              onPressed: () {
                exportTablePDF();
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Export as CSV'),
              onPressed: () {
                exportTableCSV();
              },
            ),
          ],
        ),
      ),
    );
  }
}
