import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'pdf_details_header.dart';
import 'pdf_details_section.dart';

class PdfDetails {
  final String fullName;
  final String dateTime;
  final String status;
  final List<List<String>> personalInfo;
  final List<List<String>> documents;
  final List<List<dynamic>> images;

  PdfDetails({
    required this.fullName,
    required this.dateTime,
    required this.status,
    required this.personalInfo,
    required this.documents,
    required this.images,
  });

  List<pw.Widget> get content {
    pw.Widget documentHeader = PdfHeader(
      header: fullName,
      dateTime: dateTime,
      status: status,
    ).content;

    pw.Widget personalInfoSection = PdfSection(
      header: 'Personal Information',
      rows: personalInfo,
      isImage: false,
    ).content;

    pw.Widget documentsSection = PdfSection(
      header: 'Documents',
      rows: documents,
      isImage: false,
    ).content;

    pw.Widget photosSection = PdfSection(
      header: 'Photos',
      rows: images,
      isImage: true,
    ).content;

    pw.Widget sectionGap = pw.SizedBox(height: PdfPageFormat.inch * .125);

    return [
      documentHeader,
      sectionGap,
      personalInfoSection,
      sectionGap,
      documentsSection,
      sectionGap,
      photosSection,
    ];
  }
}
