import 'package:beany_core/core/meta_value.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'account.dart';
import 'core.dart';

part 'note_statement.g.dart';

@immutable
@JsonSerializable(includeIfNull: false)
class NoteStatement extends Equatable implements Directive {
  final DateTime date;
  final IMap<String, MetaValue> meta;

  final Account account;
  final String comment;

  final ParsingInfo? parsingInfo;

  NoteStatement(
    this.date,
    this.account,
    this.comment, {
    Map<String, MetaValue>? meta,
    this.parsingInfo,
  }) : meta = IMap(meta);

  @override
  List<Object?> get props => [date, meta, account, comment];

  @override
  bool get stringify => true;

  factory NoteStatement.fromJson(Map<String, dynamic> json) =>
      _$NoteStatementFromJson(json);
  Map<String, dynamic> toJson() => _$NoteStatementToJson(this);
}
