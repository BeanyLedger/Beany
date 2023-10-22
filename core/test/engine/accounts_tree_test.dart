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

    var tree = AccountsTree(accounts.map((e) => A(e)));
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
  });
}
