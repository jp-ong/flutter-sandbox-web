import 'dart:convert';
import 'dart:html';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_sandbox_web/app/modules/export_data/models/credential_model.dart';
import 'package:get/get.dart';

class ExportDataController extends GetxController {
  final dio = Dio();

  RxList<Credential> credentials = <Credential>[].obs;
  RxBool isFetchingCredentials = false.obs;

  void fetchCredentials() async {
    isFetchingCredentials.value = true;
    try {
      var apiUrl = dotenv.get('BASE_URL_VC');
      var response = await dio.get(apiUrl);
      var data = jsonEncode(response.data['data']['result']);
      credentials.value = credentialFromJson(jsonEncode(data));
    } catch (e) {
      credentials.value = [];
    } finally {
      isFetchingCredentials.value = false;
    }
  }
}
