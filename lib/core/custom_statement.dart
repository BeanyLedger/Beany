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

  String toString() {
    var sb = StringBuffer();
    sb.write(date.toIso8601String().substring(0, 10));
    sb.write(' custom ');
    for (var value in values) {
      sb.write('"$value" ');
    }

    return sb.toString().trimRight();
  }

  @override
  List<Object?> get props => [date, meta, values];
}
