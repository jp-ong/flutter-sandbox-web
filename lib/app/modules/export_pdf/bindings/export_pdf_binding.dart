import 'package:get/get.dart';

import '../controllers/export_pdf_controller.dart';

class ExportPdfBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExportPdfController>(
      () => ExportPdfController(),
    );
  }
}
