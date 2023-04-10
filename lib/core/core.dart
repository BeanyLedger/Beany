import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'amount.dart';

class ParsingInfo {
  final String filePath;

  final int startLine;
  final int startCol;

  final int endLine;
  final int endCold;

  ParsingInfo({
    required this.filePath,
    required this.startLine,
    required this.startCol,
    required this.endLine,
    required this.endCold,
  });
}

abstract class Statement {
  ParsingInfo? get parsingInfo;
}

abstract class Directive extends Statement {
  IMap<String, dynamic> get meta;
  DateTime get date;
}

Decimal D(String value) => Decimal.parse(value);
DateTime DT(String value) => DateTime.parse(value);
Amount AMT(String str) {
  var parts = str.split(' ');
  if (parts.length != 2) throw Exception('Invalid amount: $str');
  return Amount(D(parts[0]), parts[1]);
}
