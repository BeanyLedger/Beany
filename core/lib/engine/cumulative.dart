import 'package:beany_core/core/account.dart';
import 'package:beany_core/engine/account_balance_node.dart';
import 'package:beany_core/engine/account_balances.dart';
import 'package:beany_core/engine/accounts_tree.dart';
import 'package:beany_core/engine/inventory.dart';

AccountsTree<AccountBalanceNode> calculateCummulativeBalance(
  AccountBalances balances,
) {
  var emptyNode = AccountBalanceNode(
    Account(""),
    ownValue: Inventory(),
    cumulative: Inventory(),
    children: [],
  );

  var balanceTree = AccountsTree<AccountBalanceNode>.empty(emptyNode);

  var accountTree = AccountsTree(balances.accounts, null);
  for (var accountNode in accountTree.iterByDepth()) {
    var account = accountNode.account();
    var ownValue = balances.val(account) ?? Inventory();

    if (accountNode.isLeaf) {
      balanceTree.addAccount(
        account,
        AccountBalanceNode(
          account,
          ownValue: ownValue,
          cumulative: Inventory(),
          children: [],
        ),
      );
    } else {
      var childBalances =
          balanceTree.find(account)!.children.map((e) => e.val).toList();

      var cumulative = Inventory();
      for (var childBalance in childBalances) {
        cumulative += childBalance.totalValue;
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
