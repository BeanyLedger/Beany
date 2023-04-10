import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'account.dart';
import 'core.dart';

@immutable
class OpenStatement extends Equatable implements Directive {
  final DateTime date;
  final IMap<String, dynamic> meta;
  final Account account;

  final ParsingInfo? parsingInfo;

  OpenStatement(
    this.date,
    this.account, {
    Map<String, dynamic>? meta,
    this.parsingInfo,
  }) : meta = IMap(meta);

  String toString() {
    var sb = StringBuffer();
    sb.write(date.toIso8601String().substring(0, 10));
    sb.write(' open ');
    sb.write(account);

    return sb.toString();
  }

  @override
  List<Object?> get props => [date, meta, account];
}
