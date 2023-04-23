import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'amount.dart';

@immutable
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

  bool get canResolve {
    if (amountPer != null) {
      return amountPer!.canResolve;
    }
    if (amountTotal != null) {
      return amountTotal!.canResolve;
    }
    return false;
  }
}

@immutable
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
  bool get canResolve => true;
}
