import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'amount.dart';

@immutable
class CostSpec extends Equatable {
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
    if (date != null && label != null) {
      throw ArgumentError('CostSpec: Both date and label cannot be specified');
    }
    if (amountPer != null && amountTotal != null) {
      throw ArgumentError('amountPer and amountTotal cannot both be defined');
    }
    if (amountPer == null && amountTotal == null) {
      throw ArgumentError('amountPer or amountTotal must be defined');
    }
  }

  @override
  List<Object?> get props => [amountPer, amountTotal, date, label];

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
}
