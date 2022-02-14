import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'core.dart';

class Commodity implements Directive {
  final DateTime date;
  final IMap<String, dynamic> meta;

  final String commodity;

  Commodity(
    this.date,
    this.commodity, {
    Map<String, dynamic>? meta,
  }) : meta = IMap(meta);

  String toString() {
    var sb = StringBuffer();
    sb.write(date.toIso8601String().substring(0, 10));
    sb.write(' commodity ');
    sb.write(commodity);

    return sb.toString();
  }

  @override
  bool operator ==(Object t) {
    if (t is! Commodity) return false;
    return date == t.date && meta == t.meta && commodity == t.commodity;
  }
}
