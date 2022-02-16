import 'package:gringotts/core/commodity.dart';
import 'package:gringotts/parser.dart';
import 'package:test/test.dart';

void main() {
  test('Commodity Parser', () {
    var input = "2000-11-21 commodity INR\n";

    expect(
      commodityParser.parse(input).value,
      Commodity(DateTime(2000, 11, 21), 'INR'),
    );

    var transactions = parser.parse(input).value;
    var actual = transactions.map((t) => t.toString()).join("\n") + "\n";
    expect(actual, input);
  });
}
