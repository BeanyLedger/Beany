import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/amount.dart';
import 'package:beany_core/engine/multi_amount.dart';
import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

@immutable
class AccountBalances extends Equatable {
  final Map<Account, MultiAmount> balances;

  AccountBalances([Map<Account, MultiAmount>? bal = null])
      : balances = bal ?? {};

  @override
  List<Object?> get props => [balances];

  Amount? amountBy(Account account, Currency currency) {
    return balances[account]?.amountBy(currency);
  }

  AccountBalances clone() {
    var ab = AccountBalances();
    ab.balances.addAll(balances);
    return ab;
  }

  Iterable<Account> get accounts => balances.keys;

  AccountBalances operator -(AccountBalances other) {
    var diff = AccountBalances();
    var allAccounts = Set<Account>.from([...accounts, ...other.accounts]);

    for (var account in allAccounts) {
      var myAmounts = balances[account] ?? MultiAmount();
      var theirAmounts = other.balances[account] ?? MultiAmount();

      var amountDiff = myAmounts - theirAmounts;
      if (amountDiff.isNotEmpty) {
        diff.addMultiAmount(account, amountDiff);
      }
    }

    return diff;
  }

  void add(Account account, Amount amount) {
    var ma = balances[account] ?? MultiAmount();
    balances[account] = ma.addAmount(amount);
  }

  void addMultiAmount(Account account, MultiAmount amount) {
    var ma = balances[account] ?? MultiAmount();
    balances[account] = ma + amount;
  }

  MultiAmount? val(Account account) => balances[account];

  factory AccountBalances.fromJson(Map<String, dynamic> json) {
    return AccountBalances(json.map((key, value) {
      return MapEntry(Account(key), MultiAmount.fromJson(value));
    }));
  }
  Map<String, dynamic> toJson() => balances.map(
        (key, value) => new MapEntry(key.value, value.toJson()),
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AccountBalances) return false;

    if (other.balances.length != balances.length) return false;
    for (var account in balances.keys) {
      if (other.balances[account] != balances[account]) return false;
    }
    return true;
  }
}
