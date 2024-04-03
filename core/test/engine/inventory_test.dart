import 'package:beany_core/core/core.dart';
import 'package:beany_core/engine/inventory.dart';
import 'package:test/test.dart';

void main() {
  test('add', () {
    var inv = _inv("10 USD, 20 EUR");
    inv += _inv("5 USD");
    expect(inv.toDebugString(), "20 EUR, 15 USD");

    inv += _inv("10 INR");
    expect(inv.toDebugString(), "20 EUR, 10 INR, 15 USD");

    inv += _inv("-10 EUR");
    expect(inv.toDebugString(), "10 EUR, 10 INR, 15 USD");

    inv += _inv("-10 EUR");
    expect(inv.toDebugString(), "10 INR, 15 USD");
  });

  test('+', () {
    var inv1 = _inv("10 USD, 20 EUR");
    var inv2 = _inv("5 USD, 10 EUR");

    var result = inv1 + inv2;
    expect(result.toDebugString(), "30 EUR, 15 USD");
  });

  test('-', () {
    var inv1 = _inv("10 USD, 20 EUR");
    var inv2 = _inv("5 USD, 10 EUR");

    var result = inv1 - inv2;
    expect(result.toDebugString(), "10 EUR, 5 USD");
  });

  test('==', () {
    var inv1 = _inv("10 USD, 20 EUR");
    var inv2 = _inv("10 USD, 20 EUR");
    var inv3 = _inv("20 EUR, 10 USD");
    expect(inv1 == inv2, isTrue);
    expect(inv1 == inv3, isTrue);
  });
}

Inventory _inv(String str) => Inventory.fromDebugString(str);
