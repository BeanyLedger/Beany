import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/amount.dart';
import 'package:beany_core/engine/inventory.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:meta/meta.dart';

@immutable
class AccountBalances extends Equatable {
  final IMap<Account, Inventory> balances;

  AccountBalances([Map<Account, Inventory>? bal = null]) : balances = IMap(bal);

  @override
  List<Object?> get props => [balances];

  Amount? amountBy(Account account, Currency currency) {
    return balances[account]?.amountBy(currency);
  }

  Iterable<Account> get accounts => balances.keys;

  AccountBalances operator -(AccountBalances other) {
    var diff = AccountBalances();
    var allAccounts = Set<Account>.from([...accounts, ...other.accounts]);

    for (var account in allAccounts) {
      var myAmounts = balances[account] ?? Inventory();
      var theirAmounts = other.balances[account] ?? Inventory();

      var amountDiff = myAmounts - theirAmounts;
      if (amountDiff.isNotEmpty) {
        diff = diff.addMultiAmount(account, amountDiff);
      }
    }

    return diff;
  }

  AccountBalances add(Account account, Amount amount) {
    return addMultiAmount(account, Inventory([amount]));
  }

  AccountBalances addMultiAmount(Account account, Inventory ma) {
    return AccountBalances(
      {
        ...balances.unlockView,
        account: (balances[account] ?? Inventory()) + ma,
      },
    );
  }

  Inventory? val(Account account) => balances[account];

  factory AccountBalances.fromJson(Map<String, dynamic> json) {
    return AccountBalances(json.map((key, value) {
      return MapEntry(Account(key), Inventory.fromJson(value));
    }));
  }
  Map<String, dynamic> toJson() => balances.unlockView.map(
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
