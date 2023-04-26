import 'package:get/get.dart';

import '../controllers/export_table_controller.dart';

class ExportTableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExportTableController>(
      () => ExportTableController(),
    );
  }
}
