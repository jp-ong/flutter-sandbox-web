/// File extensions that can be used
/// when saving files on the client-side using a web browser.
///
/// The [pdf] value represents the PDF file extension.
///
/// The [csv] value represents the CSV file extension.
enum FileExtension {
  pdf,
  csv,
}

/// Text alignments for columns in a PDF table.
///
/// The [left] value represents left-aligned text.
///
/// The [center] value represents centered text.
///
/// The [right] value represents right-aligned text.
enum PdfTableColumnAlign {
  left,
  center,
  right,
}

/// Possible content types for files that can be saved
/// on the client-side using a web browser.
///
/// The [pdf] value represents the PDF content type,
/// with a value of `application/pdf`.
///
/// The [csv] value represents the CSV content type,
/// with a value of `text/csv`.
enum ContentType {
  pdf('application/pdf'),
  csv('text/csv');

  final String type;
  const ContentType(this.type);
}
