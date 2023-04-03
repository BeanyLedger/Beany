import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'account.dart';
import 'core.dart';

@immutable
class Document extends Equatable implements Directive {
  final DateTime date;
  final IMap<String, dynamic> meta;

  final Account account;
  final String path;

  Document(
    this.date,
    this.account,
    this.path, {
    Map<String, dynamic>? meta,
  }) : meta = IMap(meta);

  String toString() {
    var sb = StringBuffer();
    sb.write(date.toIso8601String().substring(0, 10));
    sb.write(' document ');
    sb.write(account);
    sb.write(' "$path"');

    return sb.toString();
  }

  @override
  List<Object?> get props => [date, meta, account, path];
}
