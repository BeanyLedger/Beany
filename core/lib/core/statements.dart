import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'core.dart';

part 'statements.g.dart';

@immutable
@JsonSerializable()
class IncludeStatement extends Equatable implements Statement {
  final String path;
  final ParsingInfo? parsingInfo;

  IncludeStatement(this.path, {this.parsingInfo});

  @override
  List<Object?> get props => [path];

  @override
  bool get stringify => true;

  factory IncludeStatement.fromJson(Map<String, dynamic> json) =>
      _$IncludeStatementFromJson(json);
  Map<String, dynamic> toJson() => _$IncludeStatementToJson(this);
}

@immutable
@JsonSerializable()
class OptionStatement extends Equatable implements Statement {
  final String key;
  final String value;
  final ParsingInfo? parsingInfo;

  OptionStatement(this.key, this.value, {this.parsingInfo});

  @override
  List<Object?> get props => [key, value];

  @override
  bool get stringify => true;

  factory OptionStatement.fromJson(Map<String, dynamic> json) =>
      _$OptionStatementFromJson(json);
  Map<String, dynamic> toJson() => _$OptionStatementToJson(this);
}

@immutable
@JsonSerializable()
class CommentStatement extends Equatable implements Statement {
  final String value;
  final ParsingInfo? parsingInfo;

  CommentStatement(this.value, {this.parsingInfo});

  @override
  List<Object?> get props => [value];

  @override
  bool get stringify => true;

  factory CommentStatement.fromJson(Map<String, dynamic> json) =>
      _$CommentStatementFromJson(json);
  Map<String, dynamic> toJson() => _$CommentStatementToJson(this);
}

@immutable
@JsonSerializable()
class PluginStatement extends Equatable implements Statement {
  final String name;
  final String? value;
  final ParsingInfo? parsingInfo;

  PluginStatement(this.name, this.value, {this.parsingInfo});

  @override
  List<Object?> get props => [name, value];

  @override
  bool get stringify => true;

  factory PluginStatement.fromJson(Map<String, dynamic> json) =>
      _$PluginStatementFromJson(json);
  Map<String, dynamic> toJson() => _$PluginStatementToJson(this);
}
