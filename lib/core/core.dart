import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:petitparser/petitparser.dart';

import 'common.dart';

class Amount {
  final Decimal number;
  final String currency;

  Amount(this.number, this.currency);

  String toString() {
    return number.toString() + ' ' + currency;
  }

  bool operator ==(Object other) =>
      other is Amount && other.number == number && other.currency == currency;

  static Parser<Amount> get parser {
    return (numberParser & char(' ') & currencyParser)
        .map((v) => Amount(v[0], v[2]));
  }
}

final _decimal = char('.');
final _number = char('-').optional() &
    digit().star() &
    (_decimal & digit().plus()).optional();

final numberParser = _number.flatten().map((value) {
  assert(value.isNotEmpty);
  try {
    return Decimal.parse(value);
  } catch (ex) {
    throw Exception("Failed to parse '$value' as Decimal");
  }
});

abstract class Statement {}

abstract class Directive extends Statement {
  IMap<String, dynamic> get meta;
  DateTime get date;
}
