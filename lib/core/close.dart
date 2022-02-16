import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:petitparser/petitparser.dart';

import 'common.dart';
import 'core.dart';

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

  static Parser<Close> get parser {
    return _closeParser.map((value) {
      return Close(value[0], value[4]);
    });
  }
}

final _closeParser = dateParser &
    spaceParser &
    string('close') &
    spaceParser &
    Account.parser &
    eol;
