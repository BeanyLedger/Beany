import 'core.dart';

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

class Option implements Statement {
  final String key;
  final String value;

  Option(this.key, this.value);

  String toString() => 'optional $key $value';

  @override
  bool operator ==(Object t) {
    if (t is! Option) return false;
    return key == t.key && value == t.value;
  }
}

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