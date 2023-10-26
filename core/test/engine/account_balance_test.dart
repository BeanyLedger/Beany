import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/amount.dart';
import 'package:beany_core/core/core.dart';
import 'package:beany_core/engine/account_balances.dart';
import 'package:beany_core/engine/multi_amount.dart';
import 'package:test/test.dart';

void main() {
  test('diff should return correct difference', () {
    final startBalances = {
      Account('Expenses:A'): MultiAmount.fromMap({"EUR": D("100.0")}),
      Account('Expenses:B'): MultiAmount.fromMap({"EUR": D("200.0")}),
      Account('Expenses:C'): MultiAmount.fromMap({"EUR": D("600.0")}),
    };
    final endBalances = {
      Account('Expenses:A'): MultiAmount.fromMap({"EUR": D("100.0")}),
      Account('Expenses:B'): MultiAmount.fromMap({"EUR": D("250.0")}),
      Account('Expenses:D'): MultiAmount.fromMap({"EUR": D("300.0")}),
    };
    final start = AccountBalances(startBalances);
    final end = AccountBalances(endBalances);

    final diff = end - start;
    final expected = {
      Account('Expenses:B'): MultiAmount.fromMap({"EUR": D("50.0")}),
      Account('Expenses:C'): MultiAmount.fromMap({"EUR": D("-600.0")}),
      Account('Expenses:D'): MultiAmount.fromMap({"EUR": D("300.0")}),
    };
    expect(diff, AccountBalances(expected));

    final clone1 = start.clone();
    clone1.addMultiAmount(
      Account('Expenses:E'),
      MultiAmount.fromMap({"EUR": D("1.0")}),
    );
    expect(clone1, isNot(same(start)));

    final clone2 = start.clone();
    clone2.add(Account('Expenses:A'), Amount(D("1.0"), "EUR"));
    expect(
      clone2.val(Account("Expenses:A"))!.val("EUR"),
      isNot(start.val(Account("Expenses:A"))!.val("EUR")),
    );
  });
}
