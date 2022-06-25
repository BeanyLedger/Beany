import 'package:fast_immutable_collections/fast_immutable_collections.dart';

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
}
