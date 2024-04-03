import 'package:beany_core/core/account.dart';
import 'package:beany_core/engine/account_inventory_map.dart';
import 'package:beany_core/engine/inventory.dart';
import 'package:test/test.dart';

void main() {
  test('diff should return correct difference', () {
    final startInv = {
      Account('Expenses:A'): _inv("100 EUR"),
      Account('Expenses:B'): _inv("200 EUR"),
      Account('Expenses:C'): _inv("600 EUR"),
    };
    final endInv = {
      Account('Expenses:A'): _inv("100 EUR"),
      Account('Expenses:B'): _inv("250 EUR"),
      Account('Expenses:D'): _inv("300 EUR"),
    };
    final start = AccountInventoryMap(startInv);
    final end = AccountInventoryMap(endInv);

    final diff = end - start;
    final expected = {
      Account('Expenses:B'): _inv("50 EUR"),
      Account('Expenses:C'): _inv("-600 EUR"),
      Account('Expenses:D'): _inv("300 EUR"),
    };
    expect(diff, AccountInventoryMap(expected));
  });
}

Inventory _inv(String str) => Inventory.fromDebugString(str);
