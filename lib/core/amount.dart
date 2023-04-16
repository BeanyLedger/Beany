import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class AmountSpec extends Equatable {
  final Decimal? number;
  final String? currency;

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

  String toString() {
    var sb = StringBuffer();
    if (number != null) {
      sb.write(renderNumber(number!));
    }
    if (currency != null) {
      if (number != null) sb.write(' ');
      sb.write(currency);
    }
    return sb.toString();
  }

  @override
  List<Object?> get props => [number, currency];
}

@immutable
class Amount extends Equatable implements AmountSpec {
  final Decimal number;
  final String currency;

  Amount(this.number, this.currency);

  String toString() {
    return '${renderNumber(number)} $currency';
  }

  @override
  List<Object?> get props => [number, currency];
}

String renderNumber(Decimal d) {
  if (d.scale < 2) return d.toStringAsFixed(2);
  return d.toString();
}
