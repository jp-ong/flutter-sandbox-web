import 'dart:html' as html;

import '../enums/enums.dart';

/// This function takes a formatter function and a string value as input,
/// and returns the formatted value as a string.
///
/// The [formatter] parameter is an optional function that takes a string
/// as input and returns another string. If provided and the [value] is not
/// empty, the function applies the formatter to the value.
///
/// The [value] parameter is a string that represents the value to be formatted.
///
/// If the formatter function throws an exception, the function returns the
/// original value unformatted.
String getFormattedValue(
  String Function(String)? formatter,
  String value,
) {
  String formattedValue = value;
  try {
    if (formatter != null && value.isNotEmpty) {
      formattedValue = formatter(value);
    }
  } catch (e) {
    formattedValue = value;
  }
  return formattedValue;
}

/// This function takes a key and a map as input, and returns the value
/// associated with the key in the map, or an empty string if the key is
/// not found in the map.
///
/// The [key] parameter is a string that represents the key to look up in the map.
///
/// The [map] parameter is a map that contains key-value pairs.
///
/// If the [key] is found in the [map], the function returns the value associated
/// with that key. Otherwise, the function returns an empty string.
String getMapValue(String key, Map map) {
  return map.containsKey(key) ? map[key] : '';
}

/// This function saves data to a file on the client-side using a web browser.
///
/// The [data] parameter is the data to be saved to the file.
///
/// The [fileName] parameter is the name of the file to be saved, without the
/// file extension.
///
/// The [fileExtension] parameter is an enum that represents the file extension
/// of the file to be saved.
///
/// The [contentType] parameter is an enum that represents the content type
/// of the file to be saved.
///
/// This function creates a new Blob object from the [data] and [contentType],
/// creates a new AnchorElement with a download URL for the Blob object, sets
/// the download attribute of the AnchorElement to the [fileName] with the
/// appropriate [fileExtension] appended, and triggers a click event on the
/// AnchorElement to download the file.
void saveFile({
  required dynamic data,
  required String fileName,
  required FileExtension fileExtension,
  required ContentType contentType,
}) {
  final blob = html.Blob([data], contentType.type);
  html.AnchorElement(href: html.Url.createObjectUrlFromBlob(blob))
    ..setAttribute('download', '$fileName.${fileExtension.name}')
    ..click();
}
