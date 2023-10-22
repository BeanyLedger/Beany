import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/amount.dart';
import 'package:beany_core/engine/accounts_tree.dart';
import 'package:decimal/decimal.dart';
import 'package:quiver/collection.dart';
import 'package:collection/collection.dart';

class AccountBalanceInfo {
  final Account account;
  final String currency;

  final Decimal cumulative;
  final Decimal ownValue;

  Decimal get totalValue => cumulative + ownValue;

  AccountBalanceInfo(
    this.account,
    this.currency, {
    required this.ownValue,
    required this.cumulative,
  });

  @override
  String toString() {
    return 'AccountBalanceInfo{account: $account, currency: $currency, cumulative: $cumulative, ownValue: $ownValue}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountBalanceInfo &&
          runtimeType == other.runtimeType &&
          account == other.account &&
          currency == other.currency &&
          cumulative == other.cumulative &&
          ownValue == other.ownValue;

  @override
  int get hashCode =>
      account.hashCode ^
      currency.hashCode ^
      cumulative.hashCode ^
      ownValue.hashCode;
}

Multimap<Account, AccountBalanceInfo> calculateCummulativeBalance(
  Multimap<Account, Amount> balances,
) {
  var results = Multimap<Account, AccountBalanceInfo>();

  var accountTree = AccountsTree(balances.keys, null);
  for (var accountNode in accountTree.iterByDepth()) {
    var account = accountNode.account();
    var amounts = balances[account];

    if (accountNode.isLeaf) {
      for (var amt in amounts) {
        results.add(
          account,
          AccountBalanceInfo(
            account,
            amt.currency,
            ownValue: amt.number,
            cumulative: Decimal.zero,
          ),
        );
      }
    } else {
      var childBalances = accountNode.children
          .map((e) => results[e.account()].toList())
          .expand((e) => e)
          .toList();

      var balanceByCurrency = <String, Decimal>{};
      for (var childBalance in childBalances) {
        var currency = childBalance.currency;
        var value = balanceByCurrency[currency];
        if (value == null) {
          balanceByCurrency[currency] = childBalance.totalValue;
        } else {
          balanceByCurrency[currency] = value + childBalance.totalValue;
        }
      }

      for (var bn in balanceByCurrency.entries) {
        var currency = bn.key;
        var amtForCurrency =
            amounts.firstWhereOrNull((e) => e.currency == currency);

        results.add(
          account,
          AccountBalanceInfo(
            account,
            currency,
            cumulative: bn.value,
            ownValue: amtForCurrency?.number ?? Decimal.zero,
          ),
        );
      }
    }
  }

  return results;
}
