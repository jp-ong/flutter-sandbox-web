import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_sandbox_web/app/helpers/export_data.dart';
import 'package:flutter_sandbox_web/app/modules/export_data/models/credential_detail_model.dart';
import 'package:flutter_sandbox_web/app/modules/export_data/models/credential_model.dart';
import 'package:get/get.dart';

class ExportDataController extends GetxController {
  final dio = Dio();

  RxList<Credential> credentials = <Credential>[].obs;
  RxBool isFetchingCredentials = false.obs;

  Rxn<CredentialDetail> credentialDetail = Rxn<CredentialDetail>();
  RxBool isFetchingCredentialDetail = false.obs;

  Future<void> fetchCredentials() async {
    isFetchingCredentials.value = true;
    try {
      var apiUrl = dotenv.get('BASE_URL_LIST');
      var response = await dio.get(apiUrl);
      var data = jsonEncode(response.data['data']['result']);
      credentials.value = credentialFromJson(data);
    } catch (e) {
      credentials.clear();
    } finally {
      isFetchingCredentials.value = false;
    }
  }

  Future<void> fetchCredentialDetail() async {
    isFetchingCredentialDetail.value = true;
    try {
      var apiUrl = dotenv.get('BASE_URL_DETAILS');
      var response = await dio.get(apiUrl);
      var data = jsonEncode(response.data['data']);
      credentialDetail.value = credentialDetailFromJson(data);
    } catch (e) {
      credentialDetail.value = null;
    } finally {
      isFetchingCredentialDetail.value = false;
    }
  }

  void exportDetailsAsPDF() async {
    await fetchCredentialDetail();
    print(credentialDetail);
  }

  void exportListAsPDF() async {
    await fetchCredentials();
    print(credentials);
  }

  void exportListAsCSV() async {
    await fetchCredentials();
    print(credentials);
  }
}
