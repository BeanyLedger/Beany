import 'package:beany_core/core/balance_statement.dart';
import 'package:beany_core/core/transaction.dart';
import 'package:beany_core/misc/date.dart';
import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:json_annotation/json_annotation.dart';

import 'amount.dart';

part 'core.g.dart';

@JsonSerializable(includeIfNull: false)
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

  factory ParsingInfo.fromJson(Map<String, dynamic> json) =>
      _$ParsingInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ParsingInfoToJson(this);
}

abstract class Statement {
  ParsingInfo? get parsingInfo;
}

abstract class Directive extends Statement {
  IMap<String, dynamic> get meta;
  DateTime get date;
}

Decimal D(String value) => Decimal.parse(value);
Date DT(String value) => Date.from(DateTime.parse(value));
Amount AMT(String str) {
  var parts = str.split(' ');
  if (parts.length != 2) throw Exception('Invalid amount: $str');
  return Amount(D(parts[0]), parts[1]);
}

int compareStatements(Statement a, Statement b) {
  if (a is TransactionSpec && b is TransactionSpec) {
    return a.compareTo(b);
  }

  if (a is Directive && b is Directive) {
    var r = a.date.compareTo(b.date);
    if (r != 0) return r;

    if (a is BalanceStatement && b is! BalanceStatement) return -1;
    if (a is! BalanceStatement && b is BalanceStatement) return 1;
    return 0;
  }

  if (a is Directive) {
    return -1;
  }

  if (b is Directive) {
    return 1;
  }

  return 0;
}
