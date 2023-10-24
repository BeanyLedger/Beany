import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/amount.dart';
import 'package:beany_core/core/core.dart';
import 'package:beany_core/engine/cumulative.dart';
import 'package:quiver/collection.dart';
import 'package:test/test.dart';

typedef A = Account;

void main() {
  test('Balance', () {
    var map = Multimap<Account, Amount>();
    map.add(A("Expenses:Groceries:Water"), AMT('2 EUR'));
    map.add(A("Expenses:Groceries:Food"), AMT('2 EUR'));
    map.add(A("Expenses:Cake"), AMT('5 EUR'));
    map.add(A("Expenses:DogFood:Rat"), AMT('4 EUR'));
    map.add(A("Expenses:DogFood:Rat"), AMT('2 USD'));
    map.add(A("Expenses"), AMT('1 EUR'));
    map.add(A("Expenses"), AMT('1 USD'));

    var balTree = calculateCummulativeBalance(map);
    expect(balTree.iterBfs().length, 7);

    var expensesBal = balTree.find(A("Expenses"))!.val;
    expect(expensesBal.account, A("Expenses"));
    expect(
      expensesBal.ownValue,
      {"EUR": D("1"), "USD": D("1")},
    );
    expect(
      expensesBal.cumulative,
      {"EUR": D("14"), "USD": D("3")},
    );
  });
}
