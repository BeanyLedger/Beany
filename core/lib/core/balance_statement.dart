import 'package:beany_core/core/meta_value.dart';
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
  final IMap<String, MetaValue> meta;

  final Account account;
  final Amount amount;

  final ParsingInfo? parsingInfo;
  final String? comment;

  BalanceStatement(
    this.date,
    this.account,
    this.amount, {
    Map<String, MetaValue>? meta,
    this.parsingInfo,
    this.comment,
  }) : meta = IMap(meta);

  @override
  List<Object?> get props => [date, meta, account, amount];

  @override
  bool get stringify => true;

  factory BalanceStatement.fromJson(Map<String, dynamic> json) =>
      _$BalanceStatementFromJson(json);
  Map<String, dynamic> toJson() => _$BalanceStatementToJson(this);
}
