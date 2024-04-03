import 'package:beany_core/core/amount.dart';
import 'package:beany_core/core/cost_spec.dart';
import 'package:beany_core/core/posting.dart';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'position.g.dart';

@immutable
@JsonSerializable(includeIfNull: false)
class Position extends Equatable {
  final Amount units;
  final CostBasis? cost;

  Position({
    required this.units,
    this.cost,
  });

  factory Position.fromPosting(Posting posting) {
    return Position(units: posting.amount, cost: posting.costBasis);
  }

  Currency get currency => units.currency;
  Position negate() => Position(units: -units, cost: cost);

  @override
  List<Object?> get props => [units, cost];

  @override
  bool? get stringify => true;

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);
  Map<String, dynamic> toJson() => _$PositionToJson(this);
}
