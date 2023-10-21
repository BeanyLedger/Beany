import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'account.dart';
import 'core.dart';

part 'open_statement.g.dart';

@immutable
@JsonSerializable(includeIfNull: false)
class OpenStatement extends Equatable implements Directive {
  final DateTime date;
  final IMap<String, dynamic> meta;
  final Account account;

  final ParsingInfo? parsingInfo;

  OpenStatement(
    this.date,
    this.account, {
    Map<String, dynamic>? meta,
    this.parsingInfo,
  }) : meta = IMap(meta);

  @override
  List<Object?> get props => [date, meta, account];

  @override
  bool get stringify => true;

  factory OpenStatement.fromJson(Map<String, dynamic> json) =>
      _$OpenStatementFromJson(json);
  Map<String, dynamic> toJson() => _$OpenStatementToJson(this);
}
