//ignore_for_file:avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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

Future<pw.Document> buildPdf() async {
  final pdf = pw.Document();
  final cardImage = pw.MemoryImage(
    (await rootBundle.load('card.png')).buffer.asUint8List(),
  );

  pw.Row personalInfoRow(label, value) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(
          width: PdfPageFormat.inch * 1.5,
          child: pw.Text(
            label,
            style: const pw.TextStyle(color: PdfColors.grey500),
          ),
        ),
        pw.Text(
          value,
          style: const pw.TextStyle(color: PdfColors.black),
        ),
      ],
    );
  }

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.letter,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.start,
          children: [
            pw.Text(
              'Jobelle Angela Watiwat Abatayo',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 18,
              ),
            ),
            pw.Row(
              children: [
                pw.Text(
                  'April 21, 2023 12:19:07 AM',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.normal,
                    fontSize: 12,
                    color: PdfColors.grey500,
                  ),
                ),
                pw.SizedBox(width: PdfPageFormat.inch * .15),
                pw.Container(
                  decoration: const pw.BoxDecoration(
                    color: PdfColors.green100,
                    borderRadius: pw.BorderRadius.all(
                      pw.Radius.circular(8),
                    ),
                  ),
                  padding: const pw.EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: pw.Text(
                    'Verified',
                    style: pw.TextStyle(
                      fontSize: 12,
                      color: PdfColors.green700,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: PdfPageFormat.inch * .3),
            pw.Text(
              'Personal Information',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 16,
              ),
            ),
            pw.Divider(
              color: PdfColors.grey400,
              height: PdfPageFormat.inch * .3,
            ),
            personalInfoRow('Fullname', 'Jobelle Angela Watiwat Abatayo'),
            pw.SizedBox(height: PdfPageFormat.inch * .15),
            personalInfoRow('Birthdate', 'June 02, 1997'),
            pw.SizedBox(height: PdfPageFormat.inch * .15),
            personalInfoRow('Gender', 'Female'),
            pw.SizedBox(height: PdfPageFormat.inch * .15),
            personalInfoRow('Address',
                'Testing Test SAN PEDRO CITY LAGUNA wait wtf long \naddress ohw to deal w this hahaha\n kek am i in new line yes no'),
            pw.SizedBox(height: PdfPageFormat.inch * .15),
            personalInfoRow('Email Address', 'akin_dev001@yopmail.com'),
            pw.SizedBox(height: PdfPageFormat.inch * .15),
            personalInfoRow('Mobile Number', '+639750744831'),
            pw.SizedBox(height: PdfPageFormat.inch * .3),
            pw.Text(
              'Documents',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 16,
              ),
            ),
            pw.Divider(
              color: PdfColors.grey400,
              height: PdfPageFormat.inch * .3,
            ),
            personalInfoRow('Valid ID', 'UMID'),
            pw.SizedBox(height: PdfPageFormat.inch * .15),
            personalInfoRow('CRN', '616896763131'),
            pw.SizedBox(height: PdfPageFormat.inch * .15),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Front ID Photo',
                      style: const pw.TextStyle(color: PdfColors.grey500),
                    ),
                    pw.Image(
                      cardImage,
                      alignment: pw.Alignment.topLeft,
                      fit: pw.BoxFit.contain,
                      width: 120,
                      height: 240,
                    ),
                  ],
                ),
                pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Back ID Photo',
                      style: const pw.TextStyle(color: PdfColors.grey500),
                    ),
                    pw.Image(
                      cardImage,
                      alignment: pw.Alignment.topLeft,
                      fit: pw.BoxFit.contain,
                      width: 120,
                      height: 240,
                    ),
                  ],
                ),
                pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Selfie with ID Photo',
                      style: const pw.TextStyle(color: PdfColors.grey500),
                    ),
                    pw.Image(
                      cardImage,
                      alignment: pw.Alignment.topLeft,
                      fit: pw.BoxFit.contain,
                      width: 120,
                      height: 240,
                    ),
                  ],
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
