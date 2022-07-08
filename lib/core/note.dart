import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'account.dart';
import 'core.dart';

@immutable
class Note implements Directive {
  final DateTime date;
  final IMap<String, dynamic> meta;

  final Account account;
  final String comment;

  Note(
    this.date,
    this.account,
    this.comment, {
    Map<String, dynamic>? meta,
  }) : meta = IMap(meta);

  String toString() {
    var sb = StringBuffer();
    sb.write(date.toIso8601String().substring(0, 10));
    sb.write(' note ');
    sb.write(account);
    sb.write(' "$comment"');

    return sb.toString();
  }

  @override
  bool operator ==(Object t) {
    if (t is! Note) return false;
    return date == t.date &&
        meta == t.meta &&
        account == t.account &&
        comment == t.comment;
  }
}
