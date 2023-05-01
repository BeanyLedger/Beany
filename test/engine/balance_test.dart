import 'package:beany/core/account.dart';
import 'package:beany/engine/ledger.dart';
import 'package:beany/engine/exceptions.dart';
import 'package:beany/misc/date.dart';
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
""";

    var engine = Ledger.loadString(contents);
    var balances = engine.accountBalances;
    expect(balances, hasLength(1));
    expect(balances[Date(2023, 01, 02)], isNotNull);

    var ab = balances[Date(2023, 01, 02)]!.balances;
    expect(ab, hasLength(2));

    var n26 = ab[Account('Assets:Work:N26')].toList();
    expect(n26, hasLength(1));
    expect(n26.first.currency, 'EUR');
    expect(n26.first.number, Decimal.parse('1000.00'));

    var cash = ab[Account('Assets:Cash')].toList();
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
