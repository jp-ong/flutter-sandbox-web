// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import '../modules/export_data/bindings/export_data_binding.dart';
import '../modules/export_data/views/export_data_view.dart';
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
      name: _Paths.EXPORT_DATA,
      page: () => const ExportDataView(),
      binding: ExportDataBinding(),
    ),
  ];
}
