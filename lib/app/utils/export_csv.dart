//ignore_for_file:avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:csv/csv.dart';

final List<List<String>> mockData = [
  [
    'Reference ID',
    'Name',
    'Birthdate',
    'Date and Time',
    'Channel',
    'Status',
  ],
  [
    '31127d3b-7683-4244-9f6f-dd70568cea26',
    'John Paul Ong',
    DateTime(1998).toString(),
    DateTime.now().toString(),
    'PHLPost',
    'Rejected',
  ],
  [
    '31127d3b-7683-4244-9f6f-dd70568cea26',
    'John Paul Ong',
    DateTime(1998).toString(),
    DateTime.now().toString(),
    'PHLPost',
    'Rejected',
  ],
  [
    '31127d3b-7683-4244-9f6f-dd70568cea26',
    'John Paul Ong',
    DateTime(1998).toString(),
    DateTime.now().toString(),
    'PHLPost',
    'Rejected',
  ],
  [
    '31127d3b-7683-4244-9f6f-dd70568cea26',
    'John Paul Ong',
    DateTime(1998).toString(),
    DateTime.now().toString(),
    'PHLPost',
    'Rejected',
  ],
  [
    '31127d3b-7683-4244-9f6f-dd70568cea26',
    'John Paul Ong',
    DateTime(1998).toString(),
    DateTime.now().toString(),
    'PHLPost',
    'Rejected',
  ],
  [
    '31127d3b-7683-4244-9f6f-dd70568cea26',
    'John Paul Ong',
    DateTime(1998).toString(),
    DateTime.now().toString(),
    'PHLPost',
    'Rejected',
  ],
  [
    '31127d3b-7683-4244-9f6f-dd70568cea26',
    'John Paul Ong',
    DateTime(1998).toString(),
    DateTime.now().toString(),
    'PHLPost',
    'Rejected',
  ],
  [
    '31127d3b-7683-4244-9f6f-dd70568cea26',
    'John Paul Ong',
    DateTime(1998).toString(),
    DateTime.now().toString(),
    'PHLPost',
    'Rejected',
  ],
  [
    '31127d3b-7683-4244-9f6f-dd70568cea26',
    'John Paul Ong',
    DateTime(1998).toString(),
    DateTime.now().toString(),
    'PHLPost',
    'Rejected',
  ],
  [
    '31127d3b-7683-4244-9f6f-dd70568cea26',
    'John Paul Ong',
    DateTime(1998).toString(),
    DateTime.now().toString(),
    'PHLPost',
    'Rejected',
  ],
  [
    '31127d3b-7683-4244-9f6f-dd70568cea26',
    'John Paul Ong',
    DateTime(1998).toString(),
    DateTime.now().toString(),
    'PHLPost',
    'Rejected',
  ],
  [
    '31127d3b-7683-4244-9f6f-dd70568cea26',
    'John Paul Ong',
    DateTime(1998).toString(),
    DateTime.now().toString(),
    'PHLPost',
    'Rejected',
  ],
  [
    '31127d3b-7683-4244-9f6f-dd70568cea26',
    'John Paul Ong',
    DateTime(1998).toString(),
    DateTime.now().toString(),
    'PHLPost',
    'Rejected',
  ],
  [
    '31127d3b-7683-4244-9f6f-dd70568cea26',
    'John Paul Ong',
    DateTime(1998).toString(),
    DateTime.now().toString(),
    'PHLPost',
    'Rejected',
  ],
  [
    '31127d3b-7683-4244-9f6f-dd70568cea26',
    'John Paul Ong',
    DateTime(1998).toString(),
    DateTime.now().toString(),
    'PHLPost',
    'Rejected',
  ],
];

void exportCsv() async {
  if (kIsWeb) {
    try {
      // Build CSV contents
      String csvData = const ListToCsvConverter().convert(mockData);

      // Create blob from CSV string data
      var blob = html.Blob([csvData], 'text/csv');

      // Create temporary anchor element and trigger click to download
      html.AnchorElement(
        href: html.Url.createObjectUrlFromBlob(blob),
      )
        ..setAttribute("download", "example.csv")
        ..click();
    } catch (e) {
      print(e);
    }
  }
}
