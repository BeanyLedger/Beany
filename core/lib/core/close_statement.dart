import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'account.dart';
import 'core.dart';

part 'close_statement.g.dart';

@immutable
@JsonSerializable()
class CloseStatement extends Equatable implements Directive {
  final DateTime date;
  final IMap<String, dynamic> meta;

  final Account account;
  final ParsingInfo? parsingInfo;

  CloseStatement(
    this.date,
    this.account, {
    Map<String, dynamic>? meta,
    this.parsingInfo,
  }) : meta = IMap(meta);

  @override
  List<Object?> get props => [date, meta, account];

  @override
  bool get stringify => true;

  factory CloseStatement.fromJson(Map<String, dynamic> json) =>
      _$CloseStatementFromJson(json);
  Map<String, dynamic> toJson() => _$CloseStatementToJson(this);
}
