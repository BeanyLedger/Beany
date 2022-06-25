import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:gringotts/parser/GringottsParser.dart';
import 'package:petitparser/petitparser.dart';

import 'common.dart';
import 'core.dart';

class Price implements Directive {
  final DateTime date;
  final IMap<String, dynamic> meta;

  final String currency;
  final Amount amount;

  Price(
    this.date,
    this.currency,
    this.amount, {
    Map<String, dynamic>? meta,
  }) : meta = IMap(meta);

  String toString() {
    var sb = StringBuffer();
    sb.write(date.toIso8601String().substring(0, 10));
    sb.write(' price ');
    sb.write(currency);
    sb.write('  ');
    sb.write(amount);

    return sb.toString();
  }

  @override
  bool operator ==(Object t) {
    if (t is! Price) return false;
    return date == t.date &&
        meta == t.meta &&
        currency == t.currency &&
        amount == t.amount;
  }

  static Parser<Price> get parser {
    return _priceParser.map((value) {
      return Price(value[0], value[4], value[7]);
    });
  }
}

final _priceParser = dateParser &
    spaceParser &
    string('price').labeled('price keyword') &
    spaceParser &
    currencyParser &
    indent &
    whitespace().star().token() &
    Amount.parser &
    eol;

extension DateParsing on DateContext {
  DateTime val() {
    if (exception != null) {
      // FIXME: How to show a better error?
      print("WTF  $exception#");
    }

    return DateTime.parse(DATE()!.text!);
  }
}

extension AmountParsing on AmountContext {
  Amount val() {
    var c = currency()!.text;
    var n = Decimal.parse(NUMBER()!.text!);
    return Amount(n, c);
  }
}

extension PriceParsing on PriceStatementContext {
  Price val() => Price(date()!.val(), currency()!.text, amount()!.val());
}
