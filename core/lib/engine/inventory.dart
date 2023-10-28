import 'package:beany_core/core/amount.dart';
import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

@immutable
class Inventory implements Equatable {
  final IMap<Currency, Decimal> _amounts;

  Inventory([Iterable<Amount> amounts = const []])
      : _amounts = IMap<Currency, Decimal>.fromEntries(
          amounts.map((e) => MapEntry(e.currency, e.number)),
        );

  Inventory.fromMap(Map<Currency, Decimal> amounts) : _amounts = IMap(amounts);

  Map<Currency, Decimal> toMap() => _amounts.unlockView;

  Inventory add(Currency currency, Decimal amount) {
    if (_amounts[currency] == null) {
      return Inventory.fromMap({
        ..._amounts.unlockView,
        currency: amount,
      });
    } else {
      var newAmount = _amounts[currency]! + amount;
      if (newAmount == Decimal.zero) {
        return Inventory.fromMap(_amounts.remove(currency).unlockView);
      } else {
        return Inventory.fromMap({
          ..._amounts.unlockView,
          currency: newAmount,
        });
      }
    }
  }

  Inventory addAmount(Amount amount) => add(amount.currency, amount.number);

  bool get isEmpty => _amounts.isEmpty;
  bool get isNotEmpty => _amounts.isNotEmpty;

  List<Amount> toAmountList() {
    return _amounts.entries.map((e) => Amount(e.value, e.key)).toList();
  }

  Amount? amountBy(Currency currency) {
    return _amounts[currency] == null
        ? null
        : Amount(_amounts[currency]!, currency);
  }

  Decimal? val(Currency currency) => _amounts[currency];
  Decimal? operator [](Currency currency) => val(currency);
  bool contains(Currency currency) => _amounts.containsKey(currency);

  Iterable<Currency> get currencies => _amounts.keys;

  Inventory operator +(Inventory other) {
    var ma = this;
    for (var currency in other.currencies) {
      ma = ma.add(currency, other[currency]!);
    }
    return ma;
  }

  Inventory operator -(Inventory other) {
    var ma = this;
    for (var currency in other.currencies) {
      ma = ma.add(currency, -other[currency]!);
    }
    return ma;
  }

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory.fromMap(json.map((key, value) {
      return MapEntry(key, Decimal.fromJson(value));
    }));
  }
  Map<String, dynamic> toJson() => _amounts.unlockView.map(
        (key, value) => new MapEntry(key, value.toJson()),
      );

  @override
  List<Object?> get props => [_amounts];

  @override
  bool? get stringify => false;

  @override
  String toString() => _amounts.toString();

  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Inventory) return false;

    return DeepCollectionEquality.unordered().equals(other._amounts, _amounts);
  }
}
