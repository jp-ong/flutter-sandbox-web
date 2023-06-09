import 'dart:convert';

import 'package:flutter_sandbox_web/app/helpers/export_data/export_data.dart';
import 'package:flutter_sandbox_web/app/modules/export_data/models/credentials_table_model.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_sandbox_web/app/modules/export_data/models/credential_detail_model.dart';
import 'package:flutter_sandbox_web/app/modules/export_data/models/credential_model.dart';
import 'package:get/get.dart';

class ExportDataController extends GetxController {
  final dio = Dio();

  RxList<Credential> credentials = <Credential>[].obs;
  RxBool isFetchingCredentials = false.obs;

  Rxn<CredentialDetail> credentialDetail = Rxn<CredentialDetail>();
  RxBool isFetchingCredentialDetail = false.obs;

  RxBool isExportingDetails = false.obs;
  RxBool isExportingList = false.obs;

  Future<void> fetchCredentials() async {
    isFetchingCredentials.value = true;
    try {
      var apiUrl = dotenv.get('BASE_URL_LIST');
      var response = await dio.get(apiUrl);
      var data = jsonEncode(response.data['data']['result']);
      credentials.value = credentialFromJson(data);
      // for (int i = 0; i < 100; i++) {
      //   credentials.add(credentials[i % credentials.length]);
      // }
    } catch (e) {
      credentials.clear();
    } finally {
      isFetchingCredentials.value = false;
    }
  }

  Future<void> fetchCredentialDetail(String reqId) async {
    isFetchingCredentialDetail.value = true;
    try {
      var apiUrl = dotenv.get('BASE_URL_DETAILS');
      var response = await dio.get('$apiUrl/$reqId/details');
      var data = jsonEncode(response.data['data']);
      credentialDetail.value = credentialDetailFromJson(data);
    } catch (e) {
      credentialDetail.value = null;
    } finally {
      isFetchingCredentialDetail.value = false;
    }
  }

  // void exportListAsPDF() async {
  //   isExportingList.value = true;
  //   await fetchCredentials();

  //   await ExportData.tableAsPDF(
  //     columns: [
  //       PdfTableColumn(
  //         field: CredentialKeys.requestId.value,
  //         header: 'RefId',
  //         formatter: (value) => value.substring(0, 7),
  //       ),
  //       PdfTableColumn(
  //         field: CredentialKeys.fullName.value,
  //         header: 'Name',
  //       ),
  //       PdfTableColumn(
  //         field: CredentialKeys.birthdate.value,
  //         header: 'Birthdate',
  //         formatter: (value) => value.split('T')[0],
  //         align: PdfTableColumnAlign.center,
  //       ),
  //       PdfTableColumn(
  //         field: CredentialKeys.created.value,
  //         header: 'Date',
  //         formatter: (value) => value.split('T')[0],
  //         align: PdfTableColumnAlign.center,
  //       ),
  //       PdfTableColumn(
  //         field: CredentialKeys.channelIssuerId.value,
  //         header: 'Channel',
  //       ),
  //       PdfTableColumn(
  //         field: CredentialKeys.status.value,
  //         header: 'Status',
  //         formatter: (value) => _getStatus(value),
  //         align: PdfTableColumnAlign.right,
  //       ),
  //     ],
  //     rows: [...credentials.map((credential) => credential.toJson())],
  //   );

  //   isExportingList.value = false;
  // }

  void exportListAsPDF() async {
    isExportingList.value = true;
    await fetchCredentials();

    CredentialsTable credentialsTable = CredentialsTable.fromJson(
        json: [...credentials.map((credential) => credential.toJson())]);

    await ExportData.tableAsPDF(
      columns: credentialsTable.columns,
      rows: credentialsTable.rows,
    );

    isExportingList.value = false;
  }

  void exportListAsCSV() async {
    isExportingList.value = true;
    await fetchCredentials();

    await ExportData.tableAsCSV(
      columns: [
        CsvTableColumn(
          field: CredentialKeys.requestId.value,
          header: 'RefId',
          formatter: (value) => value.substring(0, 7),
        ),
        CsvTableColumn(
          field: CredentialKeys.fullName.value,
          header: 'Name',
        ),
        CsvTableColumn(
          field: CredentialKeys.birthdate.value,
          header: 'Birthdate',
          formatter: (value) => value.split('T')[0],
        ),
        CsvTableColumn(
          field: CredentialKeys.created.value,
          header: 'Date',
          formatter: (value) => value.split('T')[0],
        ),
        CsvTableColumn(
          field: CredentialKeys.channelIssuerId.value,
          header: 'Channel',
        ),
        CsvTableColumn(
          field: CredentialKeys.status.value,
          header: 'Status',
          formatter: (value) => _getStatus(value),
        ),
      ],
      rows: [...credentials.map((credential) => credential.toJson())],
    );

    isExportingList.value = false;
  }

  void exportDetailsAsPDF() async {
    isExportingDetails.value = true;
    var baseUrlImg = dotenv.get('BASE_URL_IMG');

    await fetchCredentials();
    await fetchCredentialDetail(credentials[0].requestId);
    var cd = credentialDetail.value!;

    List<ImageProvider> images = await Future.wait([
      ...cd.credentialRequestDetails.supportingDocuments
          .map((e) => networkImage('$baseUrlImg${e.filename}'))
    ]);

    ExportData.detailsAsPDF(
      headline: PdfHeadline.akin(
        title: cd.fullName,
        dateTime: cd.created.toIso8601String().split('T')[0],
        status: cd.status,
      ),
      body: [
        PdfSection.rows(
          heading: 'Personal Information',
          rows: [
            PdfSectionRow.text(label: 'Full Name', value: cd.fullName),
            PdfSectionRow.text(
                label: 'Birth Date',
                value: cd.birthdate.toIso8601String().split('T')[0]),
            PdfSectionRow.text(label: 'Gender', value: cd.gender),
            PdfSectionRow.text(label: 'Address', value: cd.address),
            PdfSectionRow.text(label: 'Email Address', value: cd.emailAddress),
            PdfSectionRow.text(label: 'Mobile Number', value: cd.mobileNumber),
          ],
        ),
        PdfSection.rows(
          heading: 'Documents',
          rows: [
            ...cd.credentialRequestDetails.form.map((e) {
              return PdfSectionRow.text(
                  label: e.fieldName, value: e.fieldValue);
            }),
            ...cd.credentialRequestDetails.supportingDocuments
                .asMap()
                .entries
                .map((e) {
              return PdfSectionRow.image(
                  label: e.value.documentName, value: images[e.key]);
            }),
          ],
        ),
      ],
    );

    isExportingDetails.value = false;
  }

  String _getStatus(status) {
    switch (status) {
      case 'VERIFIED':
        return 'Fully Verified';
      case 'NEEDS_ACTION':
        return 'Needs Action';
      case 'REVOKED':
        return 'Revoked';
      case 'REJECTED':
        return 'Rejected';
      case 'EXPIRED':
        return 'Expired';
      default:
        return status;
    }
  }
}
