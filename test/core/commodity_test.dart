import 'package:test/test.dart';

import 'package:beany/core/commodity.dart';
import 'package:beany/parser/parser.dart';

void main() {
  test('Commodity Parser', () {
    var input = "2000-11-21 commodity INR";
    var c = parse(input).commodityStatement().val();

    expect(c.toString(), input);
    expect(c, Commodity(DateTime(2000, 11, 21), 'INR'));

    var transactions = parse(input).all().val();
    var actual = transactions.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });
}
