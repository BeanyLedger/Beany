import 'package:beany_core/core/meta_value.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'account.dart';
import 'core.dart';

part 'document_statement.g.dart';

@immutable
@JsonSerializable(includeIfNull: false)
class DocumentStatement extends Equatable implements Directive {
  final DateTime date;
  final IMap<String, MetaValue> meta;

  final Account account;
  final String path;

  final ParsingInfo? parsingInfo;

  DocumentStatement(
    this.date,
    this.account,
    this.path, {
    Map<String, MetaValue>? meta,
    this.parsingInfo,
  }) : meta = IMap(meta);

  @override
  List<Object?> get props => [date, meta, account, path];

  @override
  bool get stringify => true;

  factory DocumentStatement.fromJson(Map<String, dynamic> json) =>
      _$DocumentStatementFromJson(json);
  Map<String, dynamic> toJson() => _$DocumentStatementToJson(this);
}
