import 'package:decimal/decimal.dart';
import 'package:gringotts/core/core.dart';
import 'package:gringotts/core/price.dart';
import 'package:gringotts/parser.dart';
import 'package:test/test.dart';

void main() {
  test('Price Parser', () {
    var input = "2002-01-15 price INR  98.87 EUR";
    var price = Price.parser.parse(input).value;

    expect(price.toString(), input);
    expect(
      price,
      Price(
        DateTime(2002, 01, 15),
        'INR',
        Amount(Decimal.parse("98.87"), "EUR"),
      ),
    );

    var transactions = parser.parse(input).value;
    var actual = transactions.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });
}
