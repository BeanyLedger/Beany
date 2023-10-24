import 'package:beany_core/core/account.dart';
import 'package:beany_core/engine/accounts_tree.dart';
import 'package:test/test.dart';

typedef A = Account;

void main() {
  test('Account Tree', () {
    var accounts = [
      "Expenses:Groceries:Water",
      "Expenses:Groceries:Food",
      "Income:Work",
      "Income:Work:Bonus",
    ];

    var tree = AccountsTree(accounts.map((e) => A(e)), null);
    expect(tree.iterDfs().map((e) => e.account().value).toList(), [
      "Expenses",
      "Expenses:Groceries",
      "Expenses:Groceries:Food",
      "Expenses:Groceries:Water",
      "Income",
      "Income:Work",
      "Income:Work:Bonus",
    ]);
    expect(tree.iterByDepth().map((e) => e.account().value).toList(), [
      "Expenses:Groceries:Food",
      "Expenses:Groceries:Water",
      "Income:Work:Bonus",
      "Expenses:Groceries",
      "Income:Work",
      "Expenses",
      "Income",
    ]);
    expect(tree.find(A("Expenses"))!.accountPart, "Expenses");
    expect(tree.find(A("Expenses"))!.account(), A("Expenses"));

    expect(tree.find(A("Expenses:Groceries:Water"))!.accountPart, "Water");
    expect(tree.find(A("Expenses:Groceries:Water"))!.account(),
        A("Expenses:Groceries:Water"));
  });

  test("Accounts Tree with val", () {
    var tree = AccountsTree<String>.empty("");

    var accounts = [
      "Expenses:Groceries:Water",
      "Expenses:Groceries:Food",
      "Expenses:Groceries",
      "Income:Work",
      "Income:Work:Bonus",
      "Expenses",
      "Income",
    ];
    for (var account in accounts) {
      tree.addAccount(A(account), account);
    }

    for (var node in tree.iterByDepth()) {
      expect(node.val, node.account().value);
    }
  });
}
