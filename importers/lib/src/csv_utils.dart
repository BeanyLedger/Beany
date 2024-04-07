import 'package:csv/csv.dart';

List<List<String>> parseCsvToList(String csvInput) {
  // FIXME: This fails on empty lines or lines with just spaces
  final rows = const CsvToListConverter()
      .convert(
        csvInput,
        eol: '\n',
        fieldDelimiter: ',',
        shouldParseNumbers: false,
      )
      .map((e) => e.map((e) => e.toString()).toList())
      .where((list) => list.isNotEmpty)
      .toList();

  return rows;
}

List<Map<String, String>> _convertCsvListToMap(List<List<String>> rows) {
  final headers = rows.first;

  // for (var i = 0; i < headers.length; i++) {
  //   print('$i: ${headers[i]}');
  // }

  final List<Map<String, String>> result = [];
  for (var i = 1; i < rows.length; i++) {
    final row = rows[i];
    final map = <String, String>{};
    for (var j = 0; j < headers.length; j++) {
      var header = headers[j].trim();
      map[header] = row[j];
    }

    result.add(map);
  }

  return result;
}

List<Map<String, String>> parseCsvToMap(String csvInput) {
  final rows = parseCsvToList(csvInput);
  return _convertCsvListToMap(rows);
}

List<Map<String, String>> parseCsvToMapInventHeaders(String csvInput) {
  final rows = parseCsvToList(csvInput);
  final headerCount = rows.first.length;
  final headers = List.generate(headerCount, (index) => '$index');

  return _convertCsvListToMap([headers, ...rows]);
}
