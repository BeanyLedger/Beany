import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'amount.dart';
import 'core.dart';

@immutable
class Price extends Equatable implements Directive {
  final DateTime date;
  final IMap<String, dynamic> meta;

  final String currency;
  final Amount amount;

  final ParsingInfo? parsingInfo;

  Price(
    this.date,
    this.currency,
    this.amount, {
    Map<String, dynamic>? meta,
    this.parsingInfo,
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
  List<Object?> get props => [date, meta, currency, amount];
}
