import 'package:beany_core/core/account.dart';
import 'package:beany_core/engine/account_inventory_map.dart';
import 'package:beany_core/engine/cumulative.dart';
import 'package:beany_core/engine/inventory.dart';
import 'package:test/test.dart';

typedef A = Account;

void main() {
  test('Balance', () {
    var map = <Account, Inventory>{
      A("Expenses:Groceries:Water"): _inv("2 EUR"),
      A("Expenses:Groceries:Food"): _inv("2 EUR"),
      A("Expenses:Cake"): _inv("5 EUR"),
      A("Expenses:DogFood:Rat"): _inv("4 EUR, 2 USD"),
      A("Expenses"): _inv("1 EUR, 1 USD"),
    };

    var balTree = calculateCummulativeBalance(AccountInventoryMap(map));
    expect(balTree.iterBfs().length, 7);

    var expensesBal = balTree.find(A("Expenses"))!.val;
    expect(expensesBal.account, A("Expenses"));
    expect(
      expensesBal.ownValue.toDebugString(),
      "1 EUR, 1 USD",
    );
    expect(
      expensesBal.cumulative.toDebugString(),
      "13 EUR, 2 USD",
    );
  });
}

Inventory _inv(String str) => Inventory.fromDebugString(str);
