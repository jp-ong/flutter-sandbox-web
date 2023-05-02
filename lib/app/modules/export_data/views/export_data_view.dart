import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/export_data_controller.dart';

class ExportDataView extends GetView<ExportDataController> {
  const ExportDataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Export Data'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Credentials List',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              child: const Text('Export as PDF'),
              onPressed: () {
                controller.exportListAsPDF();
              },
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              child: const Text('Export as CSV'),
              onPressed: () {
                controller.exportListAsCSV();
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Credential Details',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              child: const Text('Export as PDF'),
              onPressed: () {
                controller.exportDetailsAsPDF();
              },
            ),
          ],
        ),
      ),
    );
  }
}
