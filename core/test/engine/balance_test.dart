import 'package:beany_core/core/account.dart';
import 'package:beany_core/engine/ledger.dart';
import 'package:beany_core/engine/exceptions.dart';
import 'package:beany_core/misc/date.dart';
import 'package:decimal/decimal.dart';
import 'package:test/test.dart';

void main() {
  test('Balance', () {
    var contents = """

2023-01-01 open Assets:Work:N26
2023-01-01 open Assets:Cash
2023-01-02 * "Salary"
  Assets:Work:N26  1000.00 EUR
  Assets:Cash

2023-01-03 balance Assets:Work:N26  1000.00 EUR
2023-01-14 balance Assets:Work:N26  1000.00 EUR
""";

    var engine = Ledger.loadString(contents);
    var ab = engine.inventoryAtEndOfDate(Date(2023, 01, 02))!;
    expect(ab, hasLength(2));

    var n26 = ab[Account('Assets:Work:N26')]!.toAmountList();
    expect(n26, hasLength(1));
    expect(n26.first.currency, 'EUR');
    expect(n26.first.number, Decimal.parse('1000.00'));

    var cash = ab[Account('Assets:Cash')]!.toAmountList();
    expect(cash, hasLength(1));
    expect(cash.first.currency, 'EUR');
    expect(cash.first.number, Decimal.parse('-1000.00'));
  });

  test("Account cannot be closed before it is opened", () {
    var contents = """
2023-01-02 open Assets:Cash
2023-01-01 close Assets:Cash
""";

    expect(
      () => Ledger.loadString(contents),
      throwsA(isA<AccountNotOpenException>()),
    );
  });

  test("Account must be opened before use", () {
    var contents = """
2023-01-02 * "Salary"
  Assets:Work:N26  1000.00 EUR
  Assets:Cash
""";

    expect(
      () => Ledger.loadString(contents),
      throwsA(isA<AccountNotOpenException>()),
    );
  });

  test("Account must be opened before use date", () {
    var contents = """
2023-01-03 open Assets:Cash
2023-01-02 * "Salary"
  Assets:Work:N26  1000.00 EUR
  Assets:Cash
""";

    expect(
      () => Ledger.loadString(contents),
      throwsA(isA<AccountNotOpenException>()),
    );
  });

  test("Account must be opened twice", () {
    var contents = """
2023-01-02 open Assets:Cash
2023-01-01 open Assets:Cash
""";

    expect(
      () => Ledger.loadString(contents),
      throwsA(isA<AccountAlreadyOpenException>()),
    );
  });

  test("Account must not be closed before use", () {
    var contents = """
2023-01-01 open Assets:Work:N26
2023-01-01 open Assets:Cash
2023-01-02 close Assets:Cash

2023-01-03 * "Salary"
  Assets:Work:N26  1000.00 EUR
  Assets:Cash
""";

    expect(
      () => Ledger.loadString(contents),
      throwsA(isA<AccountAlreadyClosed>()),
    );
  });

  test('Validate Balance Statement', () {
    var contents = """

2023-01-01 open Assets:Work:N26
2023-01-01 open Assets:Cash
2023-01-02 * "Salary"
  Assets:Work:N26  1000.00 EUR
  Assets:Cash

2023-01-03 balance Assets:Work:N26  2000.00 EUR
""";

    expect(
      () => Ledger.loadString(contents),
      throwsA(isA<BalanceFailure>()),
    );
  });
}
