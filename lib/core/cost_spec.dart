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
    if (amountPer == null && amountTotal == null) {
      throw ArgumentError('amountPer or amountTotal must be defined');
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

    if (amountPer != null) {
      sb.write(' @ $amountPer');
    }
    if (amountTotal != null) {
      sb.write(' @@ $amountTotal');
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
