import 'package:decimal/decimal.dart';
import 'package:gringotts/core/account.dart';
import 'package:gringotts/core/balance.dart';
import 'package:gringotts/core/core.dart';
import 'package:gringotts/parser.dart';
import 'package:test/test.dart';

void main() {
  test('Balance Parser', () {
    var input = "2002-01-15 balance Assets:Personal:Transferwise  98.87 EUR";
    var balance = Balance.parser.parse(input).value;

    expect(balance.toString(), input);
    expect(
      balance,
      Balance(
        DateTime(2002, 01, 15),
        Account('Assets:Personal:Transferwise'),
        Amount(Decimal.parse("98.87"), "EUR"),
      ),
    );

    var transactions = parser.parse(input).value;
    var actual = transactions.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });
}
