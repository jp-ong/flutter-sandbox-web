import 'package:flutter/material.dart';
import 'package:flutter_sandbox_web/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class FeatureButton {
  final String route;
  final String label;

  FeatureButton({required this.route, required this.label});
}

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  static List<FeatureButton> featureButtons = [
    FeatureButton(label: 'PDF', route: Routes.EXPORT_PDF),
    FeatureButton(label: 'CSV', route: Routes.EXPORT_CSV),
    FeatureButton(label: 'Tabulated Data', route: Routes.EXPORT_TABLE),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: featureButtons.length,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
            itemBuilder: (context, index) {
              return ElevatedButton(
                onPressed: () => Get.toNamed(featureButtons[index].route),
                child: Text(featureButtons[index].label),
              );
            },
          ),
        ),
      ),
    );
  }
}
