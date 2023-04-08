import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'account.dart';
import 'amount.dart';
import 'core.dart';

@immutable
class Balance extends Equatable implements Directive {
  final DateTime date;
  final IMap<String, dynamic> meta;

  final Account account;
  final Amount amount;

  final Decimal? tolerance;
  final Amount? diffAmount;

  Balance(
    this.date,
    this.account,
    this.amount, {
    this.tolerance,
    this.diffAmount,
    Map<String, dynamic>? meta,
  }) : meta = IMap(meta);

  String toString() {
    var sb = StringBuffer();
    sb.write(date.toIso8601String().substring(0, 10));
    sb.write(' balance ');
    sb.write(account);
    sb.write('  ');
    sb.write(amount);

    return sb.toString();
  }

  @override
  List<Object?> get props =>
      [date, meta, account, amount, tolerance, diffAmount];
}
