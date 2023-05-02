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
    ExportData.tableAsPDF(headers: [
      'RefID',
      'Name',
      'Birthdate',
      'Date',
      'Channel',
      'Status'
    ], rows: [
      ...credentials.map((credential) {
        return [
          credential.requestId.substring(0, 7),
          credential.fullName,
          credential.birthdate.toIso8601String().split('T')[0],
          credential.created.toIso8601String().split('T')[0],
          credential.channelIssuerId,
          credential.status
        ];
      })
    ]);
  }

  void exportListAsCSV() async {
    await fetchCredentials();
    ExportData.tableAsCSV(headers: [
      'RefID',
      'Name',
      'Birthdate',
      'Date',
      'Channel',
      'Status'
    ], rows: [
      ...credentials.map((credential) {
        return [
          credential.requestId,
          credential.fullName,
          credential.birthdate.toIso8601String(),
          credential.created.toIso8601String(),
          credential.channelIssuerId,
          credential.status
        ];
      })
    ]);
  }
}
