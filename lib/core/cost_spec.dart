import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'amount.dart';

@immutable
class CostSpec extends Equatable {
  final Amount amount;
  final DateTime? date;
  final String? label;

  CostSpec(
    this.amount, {
    this.date,
    this.label,
  }) {
    if (date != null && label != null) {
      throw ArgumentError('CostSpec: Both date and label cannot be specified');
    }
  }

  @override
  List<Object?> get props => [amount, date, label];

  bool get canResolve => date != null;
}
