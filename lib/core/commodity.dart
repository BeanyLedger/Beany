import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'core.dart';

@immutable
class Commodity extends Equatable implements Directive {
  final DateTime date;
  final IMap<String, dynamic> meta;

  final String commodity;

  Commodity(
    this.date,
    this.commodity, {
    Map<String, dynamic>? meta,
  }) : meta = IMap(meta);

  String toString() {
    var sb = StringBuffer();
    sb.write(date.toIso8601String().substring(0, 10));
    sb.write(' commodity ');
    sb.write(commodity);

    return sb.toString();
  }

  @override
  List<Object?> get props => [date, meta, commodity];
}
