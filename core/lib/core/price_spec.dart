import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'amount.dart';

part 'price_spec.g.dart';

@immutable
@JsonSerializable()
class PriceSpec extends Equatable {
  final AmountSpec? amountPer;
  final AmountSpec? amountTotal;

  PriceSpec({
    this.amountPer,
    this.amountTotal,
  }) {
    if (amountPer != null && amountTotal != null) {
      throw ArgumentError('amountPer and amountTotal cannot both be defined');
    }
    if (amountPer == null && amountTotal == null) {
      throw ArgumentError('amountPer or amountTotal must be defined');
    }
  }

  PriceSpec copyWith({
    AmountSpec? amountPer,
    AmountSpec? amountTotal,
  }) {
    return PriceSpec(
      amountPer: amountPer ?? this.amountPer,
      amountTotal: amountTotal ?? this.amountTotal,
    );
  }

  @override
  List<Object?> get props => [amountPer, amountTotal];

  @override
  bool get stringify => true;

  bool get canResolve {
    if (amountPer != null) {
      return amountPer!.canResolve;
    }
    if (amountTotal != null) {
      return amountTotal!.canResolve;
    }
    return false;
  }

  factory PriceSpec.fromJson(Map<String, dynamic> json) =>
      _$PriceSpecFromJson(json);
  Map<String, dynamic> toJson() => _$PriceSpecToJson(this);
}

@immutable
@JsonSerializable()
class Price extends Equatable implements PriceSpec {
  final Amount? amountPer;
  final Amount? amountTotal;

  Price({
    this.amountPer,
    this.amountTotal,
  }) {
    if (amountPer != null && amountTotal != null) {
      throw ArgumentError('amountPer and amountTotal cannot both be defined');
    }
    if (amountPer == null && amountTotal == null) {
      throw ArgumentError('amountPer or amountTotal must be defined');
    }
  }

  Price copyWith({
    AmountSpec? amountPer,
    AmountSpec? amountTotal,
  }) {
    return Price(
      amountPer: (amountPer ?? this.amountPer)?.toAmount(),
      amountTotal: (amountTotal ?? this.amountTotal)?.toAmount(),
    );
  }

  @override
  List<Object?> get props => [amountPer, amountTotal];

  @override
  bool get stringify => true;

  @override
  bool get canResolve => true;

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
  Map<String, dynamic> toJson() => _$PriceToJson(this);
}
