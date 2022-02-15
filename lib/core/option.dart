import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'core.dart';

class Option implements Directive {
  DateTime get date => throw UnimplementedError();
  IMap<String, dynamic> get meta => throw UnimplementedError();

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
