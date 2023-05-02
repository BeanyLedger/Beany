import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'account.dart';
import 'amount.dart';
import 'core.dart';

@immutable
class BalanceStatement extends Equatable implements Directive {
  final DateTime date;
  final IMap<String, dynamic> meta;

  final Account account;
  final Amount amount;

  final Decimal? tolerance;
  final Amount? diffAmount;

  final ParsingInfo? parsingInfo;

  BalanceStatement(
    this.date,
    this.account,
    this.amount, {
    this.tolerance,
    this.diffAmount,
    Map<String, dynamic>? meta,
    this.parsingInfo,
  }) : meta = IMap(meta);

  @override
  List<Object?> get props =>
      [date, meta, account, amount, tolerance, diffAmount];

  @override
  bool get stringify => true;
}
