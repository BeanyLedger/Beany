import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'core.dart';

part 'event_statement.g.dart';

@immutable
@JsonSerializable(includeIfNull: false)
class EventStatement extends Equatable implements Directive {
  final DateTime date;
  final IMap<String, dynamic> meta;

  final String type;
  final String value;

  final ParsingInfo? parsingInfo;

  EventStatement(
    this.date,
    this.type,
    this.value, {
    Map<String, dynamic>? meta,
    this.parsingInfo,
  }) : meta = IMap(meta);

  @override
  List<Object?> get props => [date, meta, type, value];

  @override
  bool get stringify => true;

  factory EventStatement.fromJson(Map<String, dynamic> json) =>
      _$EventStatementFromJson(json);
  Map<String, dynamic> toJson() => _$EventStatementToJson(this);
}
