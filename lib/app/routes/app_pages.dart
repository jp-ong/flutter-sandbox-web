import 'package:get/get.dart';

import '../modules/export_csv/bindings/export_csv_binding.dart';
import '../modules/export_csv/views/export_csv_view.dart';
import '../modules/export_pdf/bindings/export_pdf_binding.dart';
import '../modules/export_pdf/views/export_pdf_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.EXPORT_PDF,
      page: () => const ExportPdfView(),
      binding: ExportPdfBinding(),
    ),
    GetPage(
      name: _Paths.EXPORT_CSV,
      page: () => const ExportCsvView(),
      binding: ExportCsvBinding(),
    ),
  ];
}
