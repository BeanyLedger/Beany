import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'amount.g.dart';

// I think it woudl be good for this to an actual class!
typedef Currency = String;

@immutable
@JsonSerializable(includeIfNull: false)
class AmountSpec extends Equatable {
  final Decimal? number;
  final Currency? currency;

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

  @override
  bool get stringify => true;

  Amount toAmount() {
    if (number == null) {
      throw ArgumentError('AmountSpec.number is null');
    }
    if (currency == null) {
      throw ArgumentError('AmountSpec.currency is null');
    }
    return Amount(number!, currency!);
  }

  bool get canResolve => number != null && currency != null;

  factory AmountSpec.fromJson(Map<String, dynamic> json) =>
      _$AmountSpecFromJson(json);
  Map<String, dynamic> toJson() => _$AmountSpecToJson(this);
}

@immutable
@JsonSerializable(includeIfNull: false)
class Amount extends Equatable implements AmountSpec, Comparable<Amount> {
  final Decimal number;
  final String currency;

  Amount(this.number, this.currency);
  Amount.zero(this.currency) : number = Decimal.zero;

  @override
  List<Object?> get props => [number, currency];

  @override
  bool get stringify => true;

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

  Amount operator -() {
    return Amount(-number, currency);
  }

  @override
  bool get canResolve => true;

  @override
  int compareTo(Amount other) {
    if (other.currency != currency) {
      throw ArgumentError('Cannot compare amounts with different currencies');
    }
    return number.compareTo(other.number);
  }

  factory Amount.fromJson(Map<String, dynamic> json) => _$AmountFromJson(json);
  Map<String, dynamic> toJson() => _$AmountToJson(this);
}
