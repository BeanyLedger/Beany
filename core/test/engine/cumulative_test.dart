import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/core.dart';
import 'package:beany_core/engine/cumulative.dart';
import 'package:beany_core/engine/multi_amount.dart';
import 'package:test/test.dart';

typedef A = Account;

void main() {
  test('Balance', () {
    var map = <Account, MultiAmount>{
      A("Expenses:Groceries:Water"): MultiAmount([AMT('2 EUR')]),
      A("Expenses:Groceries:Food"): MultiAmount([AMT('2 EUR')]),
      A("Expenses:Cake"): MultiAmount([AMT('5 EUR')]),
      A("Expenses:DogFood:Rat"): MultiAmount([AMT('4 EUR'), AMT('2 USD')]),
      A("Expenses"): MultiAmount([AMT('1 EUR'), AMT('1 USD')]),
    };

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
