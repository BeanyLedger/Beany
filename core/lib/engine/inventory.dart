import 'package:beany_core/core/amount.dart';
import 'package:beany_core/engine/position.dart';
import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

part 'inventory.g.dart';

@immutable
@JsonSerializable(includeIfNull: false)
class Inventory extends Equatable {
  final IList<Position> positions;

  Inventory([Iterable<Position> items = const []]) : positions = IList(items);

  Inventory add(Position item) {
    if (item.cost == null) {
      var existingItems =
          positions.where((e) => e.currency == item.currency && e.cost == null);

      switch (existingItems.length) {
        case 0:
          return Inventory(positions.add(item));
        case 1:
          var existingItem = existingItems.first;
          var newPositions = positions.remove(existingItem);
          var newUnits = existingItem.units + item.units;
          return newUnits.number == Decimal.zero
              ? Inventory(newPositions)
              : Inventory(newPositions.add(Position(units: newUnits)));
        default:
          throw Exception(
              'More than one item of the same currency without cost. This should never happen');
      }
    }

    var existingItems = positions.where((e) => e.currency == item.currency);
    switch (existingItems.length) {
      case 0:
        return Inventory(positions.add(item));
      case 1:
        existingItems = existingItems.where((e) => e.cost == item.cost);
        switch (existingItems.length) {
          case 0:
            return Inventory(positions.add(item));

          case 1:
            var ei = existingItems.first;
            var newUnits = ei.units + item.units;
            if (newUnits == Decimal.zero) {
              return Inventory(positions.remove(ei));
            } else {
              return Inventory(
                positions
                    .remove(ei)
                    .add(Position(units: newUnits, cost: item.cost)),
              );
            }

          default:
            throw Exception(
                'More than one item with the same currency and cost. This should never happen');
        }

      default:
        throw Exception(
            'More than one item of the same currency without cost. This should never happen');
    }
  }

  bool get isEmpty => positions.isEmpty;
  bool get isNotEmpty => positions.isNotEmpty;

  Amount? amountBy(Currency currency) {
    var position = positions
        .firstWhereOrNull((p) => p.currency == currency && p.cost == null);
    return position?.units;
  }

  Decimal? val(Currency currency) => amountBy(currency)?.number;
  Decimal? operator [](Currency currency) => val(currency);
  bool contains(Currency currency) =>
      positions.where((p) => p.currency == currency).isNotEmpty;

  Iterable<Currency> get currencies => positions.map((p) => p.currency).toSet();

  Inventory operator +(Inventory other) {
    var inv = this;
    for (var item in other.positions) {
      inv = inv.add(item);
    }
    return inv;
  }

  Inventory operator -(Inventory other) {
    var inv = this;
    for (var item in other.positions) {
      inv = inv.add(item.negate());
    }
    return inv;
  }

  @override
  List<Object?> get props => [positions];

  @override
  bool? get stringify => false;

  @override
  String toString() => positions.toString();

  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Inventory) return false;

    return DeepCollectionEquality.unordered()
        .equals(other.positions, positions);
  }

  factory Inventory.fromDebugString(String str) {
    var inputs = str.split(",").map((e) => e.trim());
    var positions = inputs.map((input) {
      var number = input.split(' ')[0];
      var currency = input.split(' ')[1];
      return Position(units: Amount(Decimal.parse(number), currency));
    });

    return Inventory(positions);
  }

  String toDebugString() {
    var positionStrs = positions
        .map((p) => "${p.units.number} ${p.units.currency}")
        .sortedBy((s) => s.split(' ')[1]);
    return positionStrs.join(", ");
  }

  factory Inventory.fromJson(Map<String, dynamic> json) =>
      _$InventoryFromJson(json);
  Map<String, dynamic> toJson() => _$InventoryToJson(this);
}
