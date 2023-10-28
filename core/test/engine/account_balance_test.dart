import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/core.dart';
import 'package:beany_core/engine/account_balances.dart';
import 'package:beany_core/engine/inventory.dart';
import 'package:test/test.dart';

void main() {
  test('diff should return correct difference', () {
    final startBalances = {
      Account('Expenses:A'): Inventory.fromMap({"EUR": D("100.0")}),
      Account('Expenses:B'): Inventory.fromMap({"EUR": D("200.0")}),
      Account('Expenses:C'): Inventory.fromMap({"EUR": D("600.0")}),
    };
    final endBalances = {
      Account('Expenses:A'): Inventory.fromMap({"EUR": D("100.0")}),
      Account('Expenses:B'): Inventory.fromMap({"EUR": D("250.0")}),
      Account('Expenses:D'): Inventory.fromMap({"EUR": D("300.0")}),
    };
    final start = AccountBalances(startBalances);
    final end = AccountBalances(endBalances);

    final diff = end - start;
    final expected = {
      Account('Expenses:B'): Inventory.fromMap({"EUR": D("50.0")}),
      Account('Expenses:C'): Inventory.fromMap({"EUR": D("-600.0")}),
      Account('Expenses:D'): Inventory.fromMap({"EUR": D("300.0")}),
    };
    expect(diff, AccountBalances(expected));
  });
}
