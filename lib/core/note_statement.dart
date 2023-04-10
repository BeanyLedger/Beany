import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'account.dart';
import 'core.dart';

@immutable
class NoteStatement extends Equatable implements Directive {
  final DateTime date;
  final IMap<String, dynamic> meta;

  final Account account;
  final String comment;

  final ParsingInfo? parsingInfo;

  NoteStatement(
    this.date,
    this.account,
    this.comment, {
    Map<String, dynamic>? meta,
    this.parsingInfo,
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
  List<Object?> get props => [date, meta, account, comment];
}
