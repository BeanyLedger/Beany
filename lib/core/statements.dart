import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'core.dart';

@immutable
class Include extends Equatable implements Statement {
  final String path;
  final ParsingInfo? parsingInfo;

  Include(this.path, {this.parsingInfo});

  String toString() => 'include "$path"';

  @override
  List<Object?> get props => [path];
}

@immutable
class Option extends Equatable implements Statement {
  final String key;
  final String value;
  final ParsingInfo? parsingInfo;

  Option(this.key, this.value, {this.parsingInfo});

  String toString() => 'option "$key" "$value"';

  @override
  List<Object?> get props => [key, value];
}

@immutable
class Comment extends Equatable implements Statement {
  final String value;
  final ParsingInfo? parsingInfo;

  Comment(this.value, {this.parsingInfo});

  String toString() => '; $value';

  @override
  List<Object?> get props => [value];
}
