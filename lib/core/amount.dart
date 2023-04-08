import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class AmountSpec extends Equatable {
  final Decimal? number;
  final String? currency;

  AmountSpec(this.number, this.currency);

  @override
  List<Object?> get props => [number, currency];
}

@immutable
class Amount extends Equatable implements AmountSpec {
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