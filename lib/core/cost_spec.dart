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

  @override
  String toString() {
    var sb = StringBuffer();

    sb.write('{');
    sb.write(amount);
    if (date != null) {
      sb.write(', ');
      sb.write(date!.toIso8601String().substring(0, 10));
    }
    if (label != null) {
      sb.write(', ');
      sb.write('"$label"');
    }
    sb.write('}');
    return sb.toString();
  }

  bool get canResolve => date != null;
}
