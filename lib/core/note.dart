import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:petitparser/petitparser.dart';

import 'account.dart';
import 'common.dart';
import 'core.dart';

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

  static Parser<Note> get parser {
    return _noteParser.map((value) {
      return Note(value[0], value[4], value[6]);
    });
  }
}

final _noteParser = dateParser &
    spaceParser &
    string('note') &
    spaceParser &
    Account.parser &
    spaceParser &
    quotedStringParser &
    eol;
