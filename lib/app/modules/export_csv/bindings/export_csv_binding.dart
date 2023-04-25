import 'package:get/get.dart';

import '../controllers/export_csv_controller.dart';

class ExportCsvBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExportCsvController>(
      () => ExportCsvController(),
    );
  }
}
