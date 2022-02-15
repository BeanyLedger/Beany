import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'core.dart';

class Comment implements Directive {
  DateTime get date => throw UnimplementedError();
  IMap<String, dynamic> get meta => throw UnimplementedError();

  final String value;

  Comment(this.value);

  String toString() => '; $value';

  @override
  bool operator ==(Object t) {
    if (t is! Comment) return false;
    return value == t.value;
  }
}
