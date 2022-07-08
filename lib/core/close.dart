import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'account.dart';
import 'core.dart';

@immutable
class Close implements Directive {
  final DateTime date;
  final IMap<String, dynamic> meta;

  final Account account;

  Close(
    this.date,
    this.account, {
    Map<String, dynamic>? meta,
  }) : meta = IMap(meta);

  String toString() {
    var sb = StringBuffer();
    sb.write(date.toIso8601String().substring(0, 10));
    sb.write(' close ');
    sb.write(account);

    return sb.toString();
  }

  @override
  bool operator ==(Object t) {
    if (t is! Close) return false;
    return date == t.date && meta == t.meta && account == t.account;
  }
}
