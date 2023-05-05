import '../enums/enums.dart';

/// Represents a colum and its configurations.
class PdfTableColumn {
  /// Key of the object's property to be displayed as this column's data.
  final String field;

  /// Text to display as this column's header.
  ///
  /// Defaults to `field` if no `header` provided.
  String? header;

  /// Provides access to this column's data for modification.
  ///
  /// Example:
  /// ```dart
  /// PdfTableColumn(
  ///     field: 'longId',
  ///     header: 'Long ID',
  ///     formatter: (value) => value.substring(0, 7), // <-- Modifies the data to display only the first 8 characters
  /// );
  /// ```
  final String Function(String value)? formatter;

  /// Allows this column to expand and push others to their minimum widths.
  bool? fullWidth = false;

  /// Aligns the text in this column's cells
  PdfTableColumnAlign? align = PdfTableColumnAlign.left;

  PdfTableColumn({
    required this.field,
    this.header,
    this.formatter,
    this.fullWidth,
    this.align,
  });
}
