import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'core.dart';

@immutable
class EventStatement extends Equatable implements Directive {
  final DateTime date;
  final IMap<String, dynamic> meta;

  final String type;
  final String value;

  final ParsingInfo? parsingInfo;

  EventStatement(
    this.date,
    this.type,
    this.value, {
    Map<String, dynamic>? meta,
    this.parsingInfo,
  }) : meta = IMap(meta);

  @override
  List<Object?> get props => [date, meta, type, value];
}
