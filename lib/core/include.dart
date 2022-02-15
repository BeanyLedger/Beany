import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'core.dart';

class Include implements Directive {
  DateTime get date => throw UnimplementedError();
  IMap<String, dynamic> get meta => throw UnimplementedError();

  final String path;

  Include(this.path);

  String toString() => 'include "$path"';

  @override
  bool operator ==(Object t) {
    if (t is! Include) return false;
    return path == t.path;
  }
}
