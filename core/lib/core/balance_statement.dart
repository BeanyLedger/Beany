import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'account.dart';
import 'amount.dart';
import 'core.dart';

part 'balance_statement.g.dart';

@immutable
@JsonSerializable(includeIfNull: false)
class BalanceStatement extends Equatable implements Directive {
  final DateTime date;
  final IMap<String, dynamic> meta;

  final Account account;
  final Amount amount;

  final ParsingInfo? parsingInfo;

  BalanceStatement(
    this.date,
    this.account,
    this.amount, {
    Map<String, dynamic>? meta,
    this.parsingInfo,
  }) : meta = IMap(meta);

  @override
  List<Object?> get props => [date, meta, account, amount];

  @override
  bool get stringify => true;

  factory BalanceStatement.fromJson(Map<String, dynamic> json) =>
      _$BalanceStatementFromJson(json);
  Map<String, dynamic> toJson() => _$BalanceStatementToJson(this);
}
