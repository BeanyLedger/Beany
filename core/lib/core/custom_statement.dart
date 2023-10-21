import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'core.dart';

part 'custom_statement.g.dart';

@immutable
@JsonSerializable(includeIfNull: false)
class CustomStatement extends Equatable implements Directive {
  final DateTime date;
  final IMap<String, dynamic> meta;

  final List<String> values;

  final ParsingInfo? parsingInfo;

  CustomStatement(
    this.date,
    this.values, {
    Map<String, dynamic>? meta,
    this.parsingInfo,
  }) : meta = IMap(meta);

  @override
  List<Object?> get props => [date, meta, values];

  @override
  bool get stringify => true;

  factory CustomStatement.fromJson(Map<String, dynamic> json) =>
      _$CustomStatementFromJson(json);
  Map<String, dynamic> toJson() => _$CustomStatementToJson(this);
}
