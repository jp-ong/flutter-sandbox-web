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
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Obx(
              () => ElevatedButton(
                onPressed: controller.isExporting.isFalse
                    ? () => controller.exportListAsPDF()
                    : null,
                child: const Text('Export as PDF'),
              ),
            ),
            const SizedBox(height: 8),
            Obx(
              () => ElevatedButton(
                onPressed: controller.isExporting.isFalse
                    ? () => controller.exportListAsCSV()
                    : null,
                child: const Text('Export as CSV'),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Credential Details',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Obx(
              () => ElevatedButton(
                onPressed: controller.isExporting.isFalse
                    ? () => controller.exportDetailsAsPDF()
                    : null,
                // onPressed: () => print('Test'),
                child: const Text('Export as PDF'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
