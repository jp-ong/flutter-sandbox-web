import 'package:flutter/material.dart';

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
          children: [
            ElevatedButton(
              child: Text('Export as PDF'),
              onPressed: () {},
            ),
            ElevatedButton(
              child: Text('Export as CSV'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
