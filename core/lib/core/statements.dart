import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'core.dart';

@immutable
class IncludeStatement extends Equatable implements Statement {
  final String path;
  final ParsingInfo? parsingInfo;

  IncludeStatement(this.path, {this.parsingInfo});

  @override
  List<Object?> get props => [path];

  @override
  bool get stringify => true;
}

@immutable
class OptionStatement extends Equatable implements Statement {
  final String key;
  final String value;
  final ParsingInfo? parsingInfo;

  OptionStatement(this.key, this.value, {this.parsingInfo});

  @override
  List<Object?> get props => [key, value];

  @override
  bool get stringify => true;
}

@immutable
class CommentStatement extends Equatable implements Statement {
  final String value;
  final ParsingInfo? parsingInfo;

  CommentStatement(this.value, {this.parsingInfo});

  @override
  List<Object?> get props => [value];

  @override
  bool get stringify => true;
}

@immutable
class PluginStatement extends Equatable implements Statement {
  final String name;
  final String? value;
  final ParsingInfo? parsingInfo;

  PluginStatement(this.name, this.value, {this.parsingInfo});

  @override
  List<Object?> get props => [name, value];

  @override
  bool get stringify => true;
}
