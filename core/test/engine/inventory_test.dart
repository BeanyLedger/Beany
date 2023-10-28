import 'package:beany_core/core/amount.dart';
import 'package:beany_core/core/core.dart';
import 'package:beany_core/engine/inventory.dart';
import 'package:test/test.dart';

void main() {
  test('add', () {
    var inv = Inventory([
      Amount(D("10"), 'USD'),
      Amount(D("20"), 'EUR'),
    ]);

    inv = inv.add('USD', D("5"));
    expect(inv.toMap(), {
      'USD': D("15"),
      'EUR': D("20"),
    });

    inv = inv.add('INR', D("10"));
    expect(inv.toMap(), {
      'USD': D("15"),
      'EUR': D("20"),
      'INR': D("10"),
    });

    inv = inv.add('EUR', D("-10"));
    expect(inv.toMap(), {
      'USD': D("15"),
      'EUR': D("10"),
      'INR': D("10"),
    });

    inv = inv.add('EUR', D("-10"));
    expect(inv.toMap(), {
      'USD': D("15"),
      'INR': D("10"),
    });
  });

  test('+', () {
    var inv1 = Inventory([
      Amount(D("10"), 'USD'),
      Amount(D("20"), 'EUR'),
    ]);
    var inv2 = Inventory([
      Amount(D("5"), 'USD'),
      Amount(D("10"), 'EUR'),
    ]);
    var result = inv1 + inv2;
    expect(result.toMap(), {
      'USD': D("15"),
      'EUR': D("30"),
    });
  });

  test('-', () {
    var inv1 = Inventory([
      Amount(D("10"), 'USD'),
      Amount(D("20"), 'EUR'),
    ]);
    var inv2 = Inventory([
      Amount(D("5"), 'USD'),
      Amount(D("10"), 'EUR'),
    ]);
    var result = inv1 - inv2;
    expect(result.toMap(), {
      'USD': D("5"),
      'EUR': D("10"),
    });
  });

  test('fromJson', () {
    var inv = Inventory.fromJson({
      'USD': "10",
      'EUR': "20",
    });
    expect(inv.toMap(), {
      'USD': D("10"),
      'EUR': D("20"),
    });
  });

  test('toJson', () {
    var inv = Inventory([
      Amount(D("10"), 'USD'),
      Amount(D("20"), 'EUR'),
    ]);
    var result = inv.toJson();
    expect(result, {
      'USD': D("10").toJson(),
      'EUR': D("20").toJson(),
    });
  });

  test('==', () {
    var inv1 = Inventory([
      Amount(D("10"), 'USD'),
      Amount(D("20"), 'EUR'),
    ]);
    var inv2 = Inventory([
      Amount(D("10"), 'USD'),
      Amount(D("20"), 'EUR'),
    ]);
    expect(inv1 == inv2, isTrue);
  });
}
