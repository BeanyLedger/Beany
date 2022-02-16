import 'package:gringotts/core/commodity.dart';
import 'package:gringotts/parser.dart';
import 'package:test/test.dart';

void main() {
  test('Commodity Parser', () {
    var input = "2000-11-21 commodity INR";
    var c = Commodity.parser.parse(input).value;

    expect(c.toString(), input);
    expect(c, Commodity(DateTime(2000, 11, 21), 'INR'));

    var transactions = parser.parse(input).value;
    var actual = transactions.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });
}
