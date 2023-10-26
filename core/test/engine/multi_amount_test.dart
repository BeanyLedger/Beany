import 'package:beany_core/core/amount.dart';
import 'package:beany_core/core/core.dart';
import 'package:beany_core/engine/multi_amount.dart';
import 'package:test/test.dart';

void main() {
  test('add', () {
    var ma = MultiAmount([
      Amount(D("10"), 'USD'),
      Amount(D("20"), 'EUR'),
    ]);

    ma = ma.add('USD', D("5"));
    expect(ma.toMap(), {
      'USD': D("15"),
      'EUR': D("20"),
    });

    ma = ma.add('INR', D("10"));
    expect(ma.toMap(), {
      'USD': D("15"),
      'EUR': D("20"),
      'INR': D("10"),
    });

    ma = ma.add('EUR', D("-10"));
    expect(ma.toMap(), {
      'USD': D("15"),
      'EUR': D("10"),
      'INR': D("10"),
    });

    ma = ma.add('EUR', D("-10"));
    expect(ma.toMap(), {
      'USD': D("15"),
      'INR': D("10"),
    });
  });

  test('+', () {
    var multiAmount1 = MultiAmount([
      Amount(D("10"), 'USD'),
      Amount(D("20"), 'EUR'),
    ]);
    var multiAmount2 = MultiAmount([
      Amount(D("5"), 'USD'),
      Amount(D("10"), 'EUR'),
    ]);
    var result = multiAmount1 + multiAmount2;
    expect(result.toMap(), {
      'USD': D("15"),
      'EUR': D("30"),
    });
  });

  test('-', () {
    var multiAmount1 = MultiAmount([
      Amount(D("10"), 'USD'),
      Amount(D("20"), 'EUR'),
    ]);
    var multiAmount2 = MultiAmount([
      Amount(D("5"), 'USD'),
      Amount(D("10"), 'EUR'),
    ]);
    var result = multiAmount1 - multiAmount2;
    expect(result.toMap(), {
      'USD': D("5"),
      'EUR': D("10"),
    });
  });

  test('fromJson', () {
    var ma = MultiAmount.fromJson({
      'USD': "10",
      'EUR': "20",
    });
    expect(ma.toMap(), {
      'USD': D("10"),
      'EUR': D("20"),
    });
  });

  test('toJson', () {
    var multiAmount = MultiAmount([
      Amount(D("10"), 'USD'),
      Amount(D("20"), 'EUR'),
    ]);
    var result = multiAmount.toJson();
    expect(result, {
      'USD': D("10").toJson(),
      'EUR': D("20").toJson(),
    });
  });

  test('==', () {
    var multiAmount1 = MultiAmount([
      Amount(D("10"), 'USD'),
      Amount(D("20"), 'EUR'),
    ]);
    var multiAmount2 = MultiAmount([
      Amount(D("10"), 'USD'),
      Amount(D("20"), 'EUR'),
    ]);
    expect(multiAmount1 == multiAmount2, isTrue);
  });
}
