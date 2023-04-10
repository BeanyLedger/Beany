import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

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
