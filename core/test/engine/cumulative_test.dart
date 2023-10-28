import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/core.dart';
import 'package:beany_core/engine/account_balances.dart';
import 'package:beany_core/engine/cumulative.dart';
import 'package:beany_core/engine/inventory.dart';
import 'package:test/test.dart';

typedef A = Account;

void main() {
  test('Balance', () {
    var map = <Account, Inventory>{
      A("Expenses:Groceries:Water"): Inventory([AMT('2 EUR')]),
      A("Expenses:Groceries:Food"): Inventory([AMT('2 EUR')]),
      A("Expenses:Cake"): Inventory([AMT('5 EUR')]),
      A("Expenses:DogFood:Rat"): Inventory([AMT('4 EUR'), AMT('2 USD')]),
      A("Expenses"): Inventory([AMT('1 EUR'), AMT('1 USD')]),
    };

    var balTree = calculateCummulativeBalance(AccountBalances(map));
    expect(balTree.iterBfs().length, 7);

    var expensesBal = balTree.find(A("Expenses"))!.val;
    expect(expensesBal.account, A("Expenses"));
    expect(
      expensesBal.ownValue.toMap(),
      {"EUR": D("1"), "USD": D("1")},
    );
    expect(
      expensesBal.cumulative.toMap(),
      {"EUR": D("13"), "USD": D("2")},
    );
  });
}
