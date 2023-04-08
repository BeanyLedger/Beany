import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'amount.dart';

@immutable
class CostSpec extends Equatable {
  final AmountSpec? amountPer;
  final AmountSpec? amountTotal;
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
  }

  CostSpec copyWith({
    AmountSpec? amountPer,
    AmountSpec? amountTotal,
    String? currency,
    DateTime? date,
    String? lable,
  }) {
    return CostSpec(
      amountPer: amountPer ?? this.amountPer,
      amountTotal: amountTotal ?? this.amountTotal,
      date: date ?? this.date,
      label: label ?? this.label,
    );
  }

  @override
  List<Object?> get props => [amountPer, amountTotal, date, label];

  @override
  String toString() {
    var sb = StringBuffer();

    AmountSpec? amount;
    if (amountPer != null) {
      amount = amountPer!;
      sb.write(' @ ');
    }
    if (amountTotal != null) {
      amount = amountTotal!;
      sb.write(' @@ ');
    }
    if (amount != null) {
      if (amount.number != null) {
        sb.write(amount.number!.toStringAsFixed(2));
      }
      if (amount.currency != null) {
        if (amount.number != null) sb.write(' ');
        sb.write(amount.currency);
      }
    }
    /*
    if (date != null) {
      sb.write(' ');
      sb.write(date);
    }
    if (label != null) {
      sb.write(' ');
      sb.write(label);
    }
    */
    return sb.toString();
  }
}
