import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'amount.dart';
import 'core.dart';

part 'price_statement.g.dart';

@immutable
@JsonSerializable()
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

  factory PriceStatement.fromJson(Map<String, dynamic> json) =>
      _$PriceStatementFromJson(json);
  Map<String, dynamic> toJson() => _$PriceStatementToJson(this);
}
