import 'package:beany_core/misc/date.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'amount.dart';

part 'cost_spec.g.dart';

@immutable
@JsonSerializable(includeIfNull: false)
class CostSpec extends Equatable {
  // This should be an AmountSpec instead
  final Amount? amountPer;
  final Amount? amountTotal;
  final DateTime? date;
  final String? label;

  CostSpec({
    this.amountPer,
    this.amountTotal,
    this.date,
    this.label,
  }) {
    if (amountPer != null && amountTotal != null) {
      throw ArgumentError('amountPer and amountTotal cannot both be defined');
    }
    if (amountPer == null && amountTotal == null) {
      throw ArgumentError('amountPer or amountTotal must be defined');
    }
  }

  Currency get currency {
    if (amountPer != null) return amountPer!.currency;
    return amountTotal!.currency;
  }

  @override
  List<Object?> get props => [amountPer, amountTotal, date, label];

  @override
  bool get stringify => true;

  bool get canResolve => date != null;

  CostSpec copyWith({
    DateTime? date,
    String? label,
    Amount? amountPer,
    Amount? amountTotal,
  }) {
    return CostSpec(
      amountPer: amountPer ?? this.amountPer,
      amountTotal: amountTotal ?? this.amountTotal,
      date: date ?? this.date,
      label: label ?? this.label,
    );
  }

  factory CostSpec.fromJson(Map<String, dynamic> json) =>
      _$CostSpecFromJson(json);
  Map<String, dynamic> toJson() => _$CostSpecToJson(this);
}

@immutable
@JsonSerializable(includeIfNull: false)
class CostBasis implements Equatable {
  final Decimal cost;
  final Currency costCurrency;
  final Date lotDate;
  final String? label;

  CostBasis(this.cost, this.costCurrency, this.lotDate, {this.label});

  @override
  String toString() {
    return 'CostBasis{cost: $cost, costCurrency: $costCurrency, lotDate: $lotDate, label: $label}';
  }

  @override
  List<Object?> get props => [cost, costCurrency, lotDate, label];

  @override
  bool? get stringify => false;

  factory CostBasis.fromJson(Map<String, dynamic> json) =>
      _$CostBasisFromJson(json);
  Map<String, dynamic> toJson() => _$CostBasisToJson(this);
}
