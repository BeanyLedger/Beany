import 'package:beany_core/core/amount.dart';
import 'package:decimal/decimal.dart';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'multi_amount.g.dart';

@JsonSerializable(includeIfNull: false)
class MultiAmount implements Equatable {
  final Map<Currency, Decimal> _amounts = {};

  MultiAmount([Iterable<Amount> amounts = const []]) {
    for (var amount in amounts) {
      _amounts[amount.currency] = amount.number;
    }
  }

  Map<Currency, Decimal> toMap() => _amounts;

  void set(Currency currency, Decimal amount) {
    _amounts[currency] = amount;
  }

  void setAmount(Amount amount) {
    set(amount.currency, amount.number);
  }

  void add(Currency currency, Decimal amount) {
    if (_amounts[currency] == null) {
      _amounts[currency] = amount;
    } else {
      _amounts[currency] = _amounts[currency]! + amount;
    }
  }

  void addAmount(Amount amount) {
    add(amount.currency, amount.number);
  }

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

  MultiAmount clone() {
    var ma = MultiAmount();
    ma._amounts.addAll(_amounts);
    return ma;
  }

  MultiAmount operator +(MultiAmount other) {
    var ma = clone();
    for (var currency in other.currencies) {
      ma.add(currency, other[currency]!);
    }
    return ma;
  }

  void addMultiAmount(MultiAmount other) {
    for (var currency in other.currencies) {
      add(currency, other[currency]!);
    }
  }

  factory MultiAmount.fromJson(Map<String, dynamic> json) =>
      _$MultiAmountFromJson(json);
  Map<String, dynamic> toJson() => _$MultiAmountToJson(this);

  @override
  List<Object?> get props => [_amounts];

  @override
  bool? get stringify => true;
}
