//ignore_for_file:avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html' as html;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_sandbox_web/app/modules/export_data/models/credential_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import './pdf_textstyle.dart';

Future<List<Credential>> getVerifiableCredentials() async {
  final dio = Dio();
  var apiUrl = dotenv.get('BASE_URL_VC');

  var response = await dio.get(apiUrl);
  List<Credential> credentials =
      credentialFromJson(jsonEncode(response.data['data']['result']));
  return credentials;
}

void exportTablePDF() async {
  try {
    final pdf = await buildPDF(pw.Document());
    Uint8List pdfInBytes = await pdf.save();
    var blob = html.Blob([pdfInBytes], 'application/pdf');
    html.AnchorElement(href: html.Url.createObjectUrlFromBlob(blob))
      ..setAttribute("download", "example.pdf")
      ..click();
  } catch (e) {
    print(e);
  }
}

pw.TableRow tableHeader(List<String> headers) {
  return pw.TableRow(children: [
    ...headers.map((h) {
      return pw.Container(
        padding: const pw.EdgeInsets.all(3),
        child: pw.Text(h, style: PdfTextStyle.smallBold),
      );
    }),
  ]);
}

pw.TableRow tableRow(List<String> items, PdfColor color) {
  return pw.TableRow(
    children: [
      ...items.map((i) {
        return pw.Container(
          padding: const pw.EdgeInsets.all(3),
          color: color,
          child: pw.Text(i, style: PdfTextStyle.smallNormal),
        );
      })
    ],
  );
}

List<pw.TableRow> tableBody(List<Credential> credentials) {
  for (var i = 0; i < 300; i++) {
    credentials.add(credentials[0]);
  }
  return [
    ...credentials.asMap().entries.map((entry) {
      var c = entry.value;
      return tableRow([
        '${c.requestId.substring(0, 5)}***',
        c.fullName,
        c.birthdate.toString().split(' ')[0],
        c.created.toString().split(' ')[0],
        c.channelIssuerId,
        c.status
      ], entry.key % 2 == 0 ? PdfColors.grey100 : PdfColors.white);
    })
  ];
}

Future<pw.Document> buildPDF(pw.Document pdf) async {
  List<Credential> credentials = await getVerifiableCredentials();

  List<String> headers = [
    'Reference ID',
    'Name',
    'Birthdate',
    'Date and Time',
    'Channel',
    'Status'
  ];

  pdf.addPage(
    pw.MultiPage(
      build: (context) {
        return [
          pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(
                color: PdfColors.grey300,
                width: 0.75,
              ),
            ),
            child: pw.Table(
              children: [
                tableHeader(headers),
                ...tableBody(credentials),
              ],
              border: const pw.TableBorder(
                horizontalInside: pw.BorderSide(
                  color: PdfColors.grey300,
                  width: 0.5,
                ),
                verticalInside: pw.BorderSide(
                  color: PdfColors.grey300,
                  width: 0.5,
                ),
              ),
            ),
          ),
        ];
      },
      footer: (context) {
        var pageLabel = context.pageLabel;
        var pagesCount = context.pagesCount;
        return pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.RichText(
              text: pw.TextSpan(
                children: [
                  const pw.TextSpan(text: 'Page '),
                  pw.TextSpan(text: pageLabel, style: PdfTextStyle.smallBold),
                  const pw.TextSpan(text: ' of '),
                  pw.TextSpan(
                      text: '$pagesCount', style: PdfTextStyle.smallBold),
                ],
                style: PdfTextStyle.smallNormal,
              ),
            )
          ],
        );
      },
    ),
  );

  return pdf;
}