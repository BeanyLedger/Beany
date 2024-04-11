import 'package:beany_core/core/currency.dart';
import 'package:beany_core/core/meta_value.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'core.dart';

part 'commodity_statement.g.dart';

@immutable
@JsonSerializable(includeIfNull: false)
class CommodityStatement extends Equatable implements Directive {
  final DateTime date;
  final IMap<String, MetaValue> meta;

  final Currency commodity;
  final ParsingInfo? parsingInfo;

  CommodityStatement(
    this.date,
    this.commodity, {
    Map<String, MetaValue>? meta,
    this.parsingInfo,
  }) : meta = IMap(meta);

  @override
  List<Object?> get props => [date, meta, commodity];

  @override
  bool get stringify => true;

  factory CommodityStatement.fromJson(Map<String, dynamic> json) =>
      _$CommodityStatementFromJson(json);
  Map<String, dynamic> toJson() => _$CommodityStatementToJson(this);
}
