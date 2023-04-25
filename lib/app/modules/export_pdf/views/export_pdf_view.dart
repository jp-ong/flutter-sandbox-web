import 'package:flutter/material.dart';
import 'package:flutter_sandbox_web/app/utils/export_pdf.dart';

import 'package:get/get.dart';

import '../controllers/export_pdf_controller.dart';

class ExportPdfView extends GetView<ExportPdfController> {
  const ExportPdfView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Export PDF'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Export PDF'),
          onPressed: () => exportPdf(),
        ),
      ),
    );
  }
}
