import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'amount.dart';
import 'core.dart';

@immutable
class PriceStatement extends Equatable implements Directive {
  final DateTime date;
  final IMap<String, dynamic> meta;

  final String currency;
  final Amount amount;

  final ParsingInfo? parsingInfo;

  PriceStatement(
    this.date,
    this.currency,
    this.amount, {
    Map<String, dynamic>? meta,
    this.parsingInfo,
  }) : meta = IMap(meta);

  @override
  List<Object?> get props => [date, meta, currency, amount];

  @override
  bool get stringify => true;
}
