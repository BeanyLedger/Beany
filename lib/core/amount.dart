import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class AmountSpec extends Equatable {
  final Decimal? number;
  final String currency;

  AmountSpec(this.number, this.currency) {
    if (number != null) {
      var d = number!.toDouble();
      if (d.isNegative) {
        throw ArgumentError('AmountSpec cannot be negative');
      }
      if (d.isInfinite) {
        throw ArgumentError('AmountSpec cannot be infinite');
      }
      if (d.isNaN) {
        throw ArgumentError('AmountSpec cannot be NaN');
      }
    }
  }

  @override
  List<Object?> get props => [number, currency];

  Amount toAmount() {
    if (number == null) {
      throw ArgumentError('AmountSpec.number is null');
    }
    return Amount(number!, currency);
  }

  bool get canResolve => number != null;
}

@immutable
class Amount extends Equatable implements AmountSpec {
  final Decimal number;
  final String currency;

  Amount(this.number, this.currency);
  Amount.zero(this.currency) : number = Decimal.zero;

  @override
  List<Object?> get props => [number, currency];

  @override
  Amount toAmount() => this;

  Amount operator +(Amount other) {
    if (currency != other.currency) {
      throw ArgumentError('Cannot add amounts with different currencies');
    }
    return Amount(number + other.number, currency);
  }

  Amount operator -(Amount other) {
    if (currency != other.currency) {
      throw ArgumentError('Cannot subtract amounts with different currencies');
    }
    return Amount(number - other.number, currency);
  }

  @override
  bool get canResolve => true;
}
