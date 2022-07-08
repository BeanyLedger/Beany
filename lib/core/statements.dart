import 'package:meta/meta.dart';

import 'core.dart';

@immutable
class Include implements Statement {
  final String path;

  Include(this.path);

  String toString() => 'include "$path"';

  @override
  bool operator ==(Object t) {
    if (t is! Include) return false;
    return path == t.path;
  }
}

@immutable
class Option implements Statement {
  final String key;
  final String value;

  Option(this.key, this.value);

  String toString() => 'option "$key" "$value"';

  @override
  bool operator ==(Object t) {
    if (t is! Option) return false;
    return key == t.key && value == t.value;
  }

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
class Comment implements Statement {
  final String value;

  Comment(this.value);

  String toString() => '; $value';

  @override
  bool operator ==(Object t) {
    if (t is! Comment) return false;
    return value == t.value;
  }
}
