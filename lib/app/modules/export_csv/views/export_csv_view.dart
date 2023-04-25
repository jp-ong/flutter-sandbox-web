import 'package:flutter/material.dart';
import 'package:flutter_sandbox_web/app/utils/export_csv.dart';

import 'package:get/get.dart';

import '../controllers/export_csv_controller.dart';

class ExportCsvView extends GetView<ExportCsvController> {
  const ExportCsvView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Export CSV'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Export CSV'),
          onPressed: () => exportCsv(),
        ),
      ),
    );
  }
}
