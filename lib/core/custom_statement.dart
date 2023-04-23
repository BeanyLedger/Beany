import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'core.dart';

@immutable
class CustomStatement extends Equatable implements Directive {
  final DateTime date;
  final IMap<String, dynamic> meta;

  final List<String> values;

  final ParsingInfo? parsingInfo;

  CustomStatement(
    this.date,
    this.values, {
    Map<String, dynamic>? meta,
    this.parsingInfo,
  }) : meta = IMap(meta);

  @override
  List<Object?> get props => [date, meta, values];
}
