import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'core.dart';

class Open implements Directive {
  final DateTime date;
  final IMap<String, dynamic> meta;

  final Account account;

  Open(
    this.date,
    this.account, {
    Map<String, dynamic>? meta,
  }) : meta = IMap(meta);

  String toString() {
    var sb = StringBuffer();
    sb.write(date.toIso8601String().substring(0, 10));
    sb.write(' open ');
    sb.write(account);

    return sb.toString();
  }

  @override
  bool operator ==(Object t) {
    if (t is! Open) return false;
    return date == t.date && meta == t.meta && account == t.account;
  }
}