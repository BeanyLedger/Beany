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

  @override
  String toString() {
    var sb = StringBuffer();

    if (amountPer != null) sb.write(' @ $amountPer');
    if (amountTotal != null) sb.write(' @@ $amountTotal');

    return sb.toString();
  }
}