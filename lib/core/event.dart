import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'core.dart';

@immutable
class Event implements Directive {
  final DateTime date;
  final IMap<String, dynamic> meta;

  String type;
  String value;

  Event(
    this.date,
    this.type,
    this.value, {
    Map<String, dynamic>? meta,
  }) : meta = IMap(meta);

  String toString() {
    var sb = StringBuffer();
    sb.write(date.toIso8601String().substring(0, 10));
    sb.write(' event "$type" "$value"');

    return sb.toString();
  }

  @override
  bool operator ==(Object t) {
    if (t is! Event) return false;
    return date == t.date &&
        meta == t.meta &&
        type == t.type &&
        value == t.value;
  }
}
