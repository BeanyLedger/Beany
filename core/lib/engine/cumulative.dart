import 'package:beany_core/core/account.dart';
import 'package:beany_core/engine/account_balance_node.dart';
import 'package:beany_core/engine/accounts_tree.dart';
import 'package:beany_core/engine/multi_amount.dart';
import 'package:decimal/decimal.dart';

AccountsTree<AccountBalanceNode> calculateCummulativeBalance(
  Map<Account, MultiAmount> balances,
) {
  var emptyNode = AccountBalanceNode(
    Account(""),
    ownValue: {},
    cumulative: {},
    children: [],
  );

  var balanceTree = AccountsTree<AccountBalanceNode>.empty(emptyNode);

  var accountTree = AccountsTree(balances.keys, null);
  for (var accountNode in accountTree.iterByDepth()) {
    var account = accountNode.account();
    var amounts = balances[account]?.toAmountList() ?? [];

    if (accountNode.isLeaf) {
      var values = AccountBalanceNode.buildValue(amounts);

      balanceTree.addAccount(
        account,
        AccountBalanceNode(
          account,
          ownValue: values,
          cumulative: values,
          children: [],
        ),
      );
    } else {
      var childBalances =
          balanceTree.find(account)!.children.map((e) => e.val).toList();

      var allCurrencies = amounts.map((e) => e.currency).toSet();
      for (var childBalance in childBalances) {
        allCurrencies.addAll(childBalance.cumulative.keys);
        allCurrencies.addAll(childBalance.ownValue.keys);
      }

      var ownValue = AccountBalanceNode.buildValue(amounts);
      var cumulative = <String, Decimal>{};
      for (var currency in allCurrencies) {
        var value = Decimal.zero;
        for (var childBalance in childBalances) {
          value += childBalance.cumulative[currency] ?? Decimal.zero;
        }

        value += ownValue[currency] ?? Decimal.zero;
        cumulative[currency] = value;
      }

      balanceTree.addAccount(
        account,
        AccountBalanceNode(
          account,
          ownValue: ownValue,
          cumulative: cumulative,
          children: childBalances,
        ),
      );
    }
  }

  return balanceTree;
}
