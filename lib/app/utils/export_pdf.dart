//ignore_for_file:avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Info {
  final String label;
  final String value;
  final pw.ImageProvider image;
  final bool isImage;
  Info({
    required this.label,
    required this.value,
    required this.isImage,
    required this.image,
  });
}

void exportPdf() async {
  if (kIsWeb) {
    try {
      // Build PDF contents
      pw.Document pdf = await buildPdf();

      // Convert PDF document object to bytes
      Uint8List pdfInBytes = await pdf.save();

      // Create blob from PDF data
      var blob = html.Blob([pdfInBytes], 'application/pdf');

      // Create temporary anchor element and trigger click to download
      html.AnchorElement(
        href: html.Url.createObjectUrlFromBlob(blob),
      )
        ..setAttribute("download", "example.pdf")
        ..click();
    } catch (e) {
      print(e);
    }
  }
}

pw.TextStyle headerLarge = pw.TextStyle(
  fontWeight: pw.FontWeight.bold,
  fontSize: 18,
);

pw.TextStyle headerMedium = pw.TextStyle(
  fontWeight: pw.FontWeight.bold,
  fontSize: 16,
);

pw.TextStyle labelSmall = pw.TextStyle(
  fontWeight: pw.FontWeight.normal,
  fontSize: 12,
  color: PdfColors.grey500,
);

pw.TextStyle bodySmall = pw.TextStyle(
  fontWeight: pw.FontWeight.normal,
  fontSize: 12,
  color: PdfColors.black,
);

pw.Container statusBadge(status) {
  PdfColor textColor;
  PdfColor backgroundColor;
  String label;
  switch (status) {
    case 'VERIFIED':
      {
        backgroundColor = PdfColor.fromHex('E4F7EC');
        textColor = PdfColor.fromHex('3A843F');
        label = 'Fully Verified';
        break;
      }
    case 'NEEDS_ACTION':
      {
        backgroundColor = PdfColor.fromHex('FCF7E1');
        textColor = PdfColor.fromHex('E89937');
        label = 'Needs Action';
        break;
      }
    case 'REVOKED':
      {
        backgroundColor = PdfColor.fromHex('E5F2FD');
        textColor = PdfColor.fromHex('3363BB');
        label = 'Revoked';
        break;
      }
    case 'REJECTED':
      {
        backgroundColor = PdfColor.fromHex('F6E9E7');
        textColor = PdfColor.fromHex('C0492C');
        label = 'Rejected';
        break;
      }
    case 'EXPIRED':
      {
        backgroundColor = PdfColor.fromHex('EEEEEE');
        textColor = PdfColor.fromHex('50535E');
        label = 'Expired';
        break;
      }
    default:
      {
        backgroundColor = PdfColor.fromHex('EEEEEE');
        textColor = PdfColor.fromHex('50535E');
        label = '';
        break;
      }
  }

  return pw.Container(
    decoration: pw.BoxDecoration(
      color: backgroundColor,
      borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
    ),
    padding: const pw.EdgeInsets.symmetric(
      horizontal: 8,
      vertical: 4,
    ),
    child: pw.Text(
      label,
      style: pw.TextStyle(
        color: textColor,
        fontSize: labelSmall.fontSize,
        fontWeight: pw.FontWeight.bold,
      ),
    ),
  );
}

pw.Column documentHeader(String name, String dateTime, String status) {
  return pw.Column(
    mainAxisAlignment: pw.MainAxisAlignment.start,
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(name, style: headerLarge),
      pw.Row(
        children: [
          pw.Text(dateTime, style: labelSmall),
          pw.SizedBox(width: PdfPageFormat.inch * .15),
          statusBadge(status),
        ],
      ),
    ],
  );
}

pw.Text sectionHeader(String header) {
  return pw.Text(header, style: headerMedium);
}

pw.Container sectionInfo(Info info) {
  return pw.Container(
    padding: const pw.EdgeInsets.symmetric(vertical: PdfPageFormat.inch * .075),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(
          width: PdfPageFormat.inch * 1.75,
          child: pw.Text(info.label, style: labelSmall),
        ),
        !info.isImage
            ? pw.Text(info.value, style: bodySmall)
            : pw.Image(
                info.image,
                alignment: pw.Alignment.topLeft,
                fit: pw.BoxFit.contain,
                width: PdfPageFormat.inch * 4,
                height: PdfPageFormat.inch * 4,
              ),
      ],
    ),
  );
}

pw.Divider sectionDivider() {
  return pw.Divider(
    color: PdfColors.grey400,
    height: PdfPageFormat.inch * .3,
  );
}

pw.Container section({required String header, required List<Info> infoList}) {
  return pw.Container(
    padding: const pw.EdgeInsets.only(top: PdfPageFormat.inch * .175),
    child: pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        sectionHeader(header),
        sectionDivider(),
        ...infoList.map((Info info) => sectionInfo(info)),
      ],
    ),
  );
}

Future<pw.Document> buildPdf() async {
  final pdf = pw.Document();
  final cardImage = pw.MemoryImage(
    (await rootBundle.load('card.png')).buffer.asUint8List(),
  );
  final blankImage = pw.MemoryImage(Uint8List(6));

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.letter,
      margin: const pw.EdgeInsets.symmetric(
        horizontal: PdfPageFormat.inch * .75,
        vertical: PdfPageFormat.inch * .5,
      ),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.start,
          children: [
            documentHeader(
              'John Paul Ong',
              'April 25, 2023 09:24:13 AM',
              'NEEDS_ACTION',
            ),
            section(
              header: 'Personal Information',
              infoList: <Info>[
                Info(
                  label: 'Fullname',
                  value: 'John Paul Ong',
                  isImage: false,
                  image: blankImage,
                ),
                Info(
                  label: 'Birthdate',
                  value: 'December 29, 1997',
                  isImage: false,
                  image: blankImage,
                ),
                Info(
                  label: 'Gender',
                  value: 'Male',
                  isImage: false,
                  image: blankImage,
                ),
                Info(
                  label: 'Address',
                  value: '420 Mag. Abad Santos St., Bacood, Sta. Mesa, Manila',
                  isImage: false,
                  image: blankImage,
                ),
                Info(
                  label: 'Email Address',
                  value: 'johnpaulong@yahoo.com',
                  isImage: false,
                  image: blankImage,
                ),
                Info(
                  label: 'Mobile Number',
                  value: '+639123456789',
                  isImage: false,
                  image: blankImage,
                ),
              ],
            ),
            section(
              header: 'Documents',
              infoList: [
                Info(
                  label: 'Valid ID',
                  value: 'UMID',
                  isImage: false,
                  image: blankImage,
                ),
                Info(
                  label: 'CRN',
                  value: '616896763131',
                  isImage: false,
                  image: blankImage,
                ),
              ],
            ),
          ],
        );
      },
    ),
  );

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.letter,
      margin: const pw.EdgeInsets.symmetric(
        horizontal: PdfPageFormat.inch * .75,
        vertical: PdfPageFormat.inch * .5,
      ),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.start,
          children: [
            documentHeader(
              'John Paul Ong',
              'April 25, 2023 09:24:13 AM',
              'NEEDS_ACTION',
            ),
            section(
              header: 'Photos',
              infoList: [
                Info(
                  label: 'Front ID Photo',
                  value: '',
                  image: cardImage,
                  isImage: true,
                ),
                Info(
                  label: 'Back ID Photo',
                  value: '',
                  image: cardImage,
                  isImage: true,
                ),
                Info(
                  label: 'Selfie with ID Photo',
                  value: '',
                  image: cardImage,
                  isImage: true,
                ),
              ],
            ),
          ],
        );
      },
    ),
  );
  return pdf;
}
