import 'package:beany_core/core/meta_value.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'core.dart';

part 'query_statement.g.dart';

@immutable
@JsonSerializable(includeIfNull: false)
class QueryStatement extends Equatable implements Directive {
  final DateTime date;
  final IMap<String, MetaValue> meta;

  final String name;
  final String content;

  final ParsingInfo? parsingInfo;

  QueryStatement(
    this.date,
    this.name,
    this.content, {
    Map<String, MetaValue>? meta,
    this.parsingInfo,
  }) : meta = IMap(meta);

  @override
  List<Object?> get props => [date, meta, name, content];

  @override
  bool get stringify => true;

  factory QueryStatement.fromJson(Map<String, dynamic> json) =>
      _$QueryStatementFromJson(json);
  Map<String, dynamic> toJson() => _$QueryStatementToJson(this);
}
