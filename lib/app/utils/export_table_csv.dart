// //ignore_for_file:avoid_web_libraries_in_flutter

// import 'dart:convert';
// import 'dart:html' as html;
// import 'package:csv/csv.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_sandbox_web/app/utils/credential_model.dart';

// Future<List<Credential>> getVerifiableCredentials() async {
//   final dio = Dio();
//   var apiUrl = dotenv.get('BASE_URL_VC');

//   var response = await dio.get(apiUrl);
//   List<Credential> credentials =
//       credentialFromJson(jsonEncode(response.data['data']['result']));
//   return credentials;
// }

// void exportTableCSV() async {
//   try {
//     List<Credential> credentials = await getVerifiableCredentials();
//     int length = credentials.length;
//     for (var i = 0; i < 100; i++) {
//       credentials.add(credentials[i % length]);
//     }
//     List<List<String>> credentials2d = credentials.asMap().entries.map((entry) {
//       var c = entry.value;
//       return [
//         c.requestId,
//         c.fullName,
//         c.birthdate.toString().split(' ')[0],
//         c.created.toString().split(' ')[0],
//         c.channelIssuerId,
//         getStatus(c.status),
//       ];
//     }).toList();

//     String csvData = const ListToCsvConverter().convert(credentials2d);
//     var blob = html.Blob([csvData], 'text/csv');
//     html.AnchorElement(
//       href: html.Url.createObjectUrlFromBlob(blob),
//     )
//       ..setAttribute("download", "example.csv")
//       ..click();
//   } catch (e) {
//     print(e);
//   }
// }

// String getStatus(String status) {
//   switch (status) {
//     case 'VERIFIED':
//       return 'Fully Verified';
//     case 'NEEDS_ACTION':
//       return 'Needs Action';
//     case 'REVOKED':
//       return 'Revoked';
//     case 'REJECTED':
//       return 'Rejected';
//     case 'EXPIRED':
//       return 'Expired';
//     default:
//       return status;
//   }
// }
