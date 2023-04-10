import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'core.dart';

@immutable
class IncludeStatement extends Equatable implements Statement {
  final String path;
  final ParsingInfo? parsingInfo;

  IncludeStatement(this.path, {this.parsingInfo});

  String toString() => 'include "$path"';

  @override
  List<Object?> get props => [path];
}

@immutable
class OptionStatement extends Equatable implements Statement {
  final String key;
  final String value;
  final ParsingInfo? parsingInfo;

  OptionStatement(this.key, this.value, {this.parsingInfo});

  String toString() => 'option "$key" "$value"';

  @override
  List<Object?> get props => [key, value];
}

@immutable
class CommentStatement extends Equatable implements Statement {
  final String value;
  final ParsingInfo? parsingInfo;

  CommentStatement(this.value, {this.parsingInfo});

  String toString() => '; $value';

  @override
  List<Object?> get props => [value];
}
