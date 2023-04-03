import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'core.dart';

@immutable
class Include extends Equatable implements Statement {
  final String path;

  Include(this.path);

  String toString() => 'include "$path"';

  @override
  List<Object?> get props => [path];
}

@immutable
class Option extends Equatable implements Statement {
  final String key;
  final String value;

  Option(this.key, this.value);

  String toString() => 'option "$key" "$value"';

  @override
  List<Object?> get props => [key, value];

  // static Parser<Option> get parser {
  //   final _optionParser = string('option') &
  //       spaceParser.star() &
  //       quotedStringParser &
  //       spaceParser.star() &
  //       quotedStringParser &
  //       eol;

  //   return _optionParser.map((v) => Option(v[2], v[4]));
}

@immutable
class Comment extends Equatable implements Statement {
  final String value;

  Comment(this.value);

  String toString() => '; $value';

  @override
  List<Object?> get props => [value];
}
