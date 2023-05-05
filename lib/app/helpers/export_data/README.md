# `ExportData` Class Documentation

`ExportData` is a class that provides a method to export tabular data to either PDF or CSV formats. It uses the Dart programming language and the Flutter framework's `pdf` and `html` packages.

## Enumerations

The `ExportData` class has three enumerations:

### `FileExtension`

An enumeration that represents the file extension for the exported file. Currently, only two file extensions are available:

- `pdf` - The exported file will be in PDF format.
- `csv` - The exported file will be in CSV format.

### `PdfTableColumnAlign`

An enumeration that represents the horizontal alignment of a column's content in the exported PDF file. The available options are:

- `left` - The content is aligned to the left.
- `center` - The content is centered.
- `right` - The content is aligned to the right.

### `ContentType`

An enumeration that represents the MIME type of the exported file. Currently, only two MIME types are available:

- `pdf` - The exported file will be in PDF format.
- `csv` - The exported file will be in CSV format.

## Methods

### `tableAsPDF`

The `tableAsPDF` method builds and downloads a PDF file containing tabularized data. The method takes three parameters:

- `columns` - A list of `PdfTableColumn` objects that describe the columns in the table.
- `rows` - A list of dynamic objects that represent the rows in the table.
- `fileName` (optional) - A string that represents the name of the file to be downloaded. If not provided, a default name will be generated based on the current date and time.

The `PdfTableColumn` object has the following properties:

- `field` - A string that represents the field in the `row` object that will provide the data for this column.
- `header` (optional) - A string that represents the text to be displayed in the column header. If not provided, the `field` value will be used instead.
- `formatter` (optional) - A function that takes a string value and returns a formatted string. The formatted string will be used as the cell value in the table. If not provided, the original value will be used instead.
- `align` (optional) - An enum value that represents the horizontal alignment of the content in the cell. If not provided, the default value is `left`.
- `fullWidth` (optional) - A boolean value that indicates whether the column should take up the full width of the table. If set to `true`, the column will have a width of `double.infinity`.

The `rows` parameter is a list of dynamic objects that represent the rows in the table. The method will try to find the values for each column in the `row` object using the `field` property of the `PdfTableColumn`.

```dart
await ExportData.tableAsPDF(
  columns:[
    PdfTableColumn(
      field: 'userId',
      header: 'User ID',
      formatter: (value) => '${value.substring(0,7)}***',
    ),
    PdfTableColumn(
      field: 'fullName',
      header: 'Full Name',
      fullWidth: true,
    ),
    PdfTableColumn(
      field: 'age',
      header: 'Age',
      align: PdfTableColumnAlign.right,
    ),
    PdfTableColumn(
      field: 'birthdate',
      header: 'Birth Date',
      align: PdfTableColumnAlign.center,
      formatter: (value) => value.split('T')[0],
    ),
  ],
  row:[...users.map((user) => user.toJson())],
);
```

### `tableAsCSV`

The `tableAsCSV` method builds and downloads a CSV file containing tabularized data. The method takes three parameters:

- `columns` - A list of `CsvTableColumn` objects that describe the columns in the table.
- `rows` - A list of dynamic objects that represent the rows in the table.
- `fileName` (optional) - A string that represents the name of the file to be downloaded. If not provided, a default name will be generated based on the current date and time.

The `CsvTableColumn` object has the following properties:

- `field` - A string that represents the field in the `row` object that will provide the data for this column.
- `header` (optional) - A string that represents the text to be displayed in the column header. If not provided, the `field` value will be used instead.
- `formatter` (optional) - A function that takes a string value and returns a formatted string. The formatted string will be used as the cell value in the table. If not provided, the original value will be used instead.

The `rows` parameter is a list of dynamic objects that represent the rows in the table. The method will try to find the values for each column in the `row` object using the `field` property of the `CsvTableColumn`.

```dart
await ExportData.tableAsCSV(
  columns:[
    CsvTableColumn(
      field: 'userId',
      header: 'User ID',
      formatter: (value) => '${value.substring(0,7)}***',
    ),
    CsvTableColumn(
      field: 'fullName',
      header: 'Full Name',
    ),
    CsvTableColumn(
      field: 'age',
    ),
    CsvTableColumn(
      field: 'birthdate',
      header: 'Birth Date',
      formatter: (value) => value.split('T')[0],
    ),
  ],
  row:[...users.map((user) => user.toJson())],
);
```

### `detailsAsPDF`

The `tableAsCSV` method builds and downloads a CSV file containing tabularized data. The method takes three parameters:

- `fullName` - The full name of the person.
- `dateTime` - The date and time of the credential request.
- `status` - The status of the credential request.
- `personalInfo` - A list of lists representing personal information of the person. Each inner list should have two elements: the label of the personal information and the value.
- `documents` - A list of lists representing document details related to the person. Each inner list should have two elements: the label of the document and the value.
- `images` - A list of lists representing images related to the document. Each inner list should have two elements: the title of the image and the file name of the image.
- `fileName` - The name of the file to save the PDF document as. If not provided, the file will be named "details\_[current datetime].pdf".

```dart
ExportData.detailsAsPDF(
  fullName: 'Juan dela Cruz',
  dateTime: '2023-04-29',
  status: 'Fully Verified',
  personalInfo: [
    ['Full Name', 'Juan dela Cruz'],
    ['Birthdate', '1998-04-29'],
    ['Gender', 'Male'],
    ['Address', '123 Street, City'],
    ['Email Address', 'address@example.com'],
    ['Mobile Number', '639123456789'],
    // ...
  ],
  documents: [
    ['Valid ID', 'UMID'],
    ['ID Number', '1234567890'],
    // ...
  ],
  images: [
    ['Front ID Photo', <ImageProvider>],
    ['Back ID Photo', <ImageProvider>],
    ['Selfie Photo', <ImageProvider>],
  ],
);
```
