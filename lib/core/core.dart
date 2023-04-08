import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

@immutable
class Amount extends Equatable {
  final Decimal number;
  final String currency;

  Amount(this.number, this.currency);

  String toString() {
    // FIXME: This depends on the precission of the currency!
    return number.toStringAsFixed(2) + ' ' + currency;
  }

  @override
  List<Object?> get props => [number, currency];
}

abstract class Statement {}

abstract class Directive extends Statement {
  IMap<String, dynamic> get meta;
  DateTime get date;
}
