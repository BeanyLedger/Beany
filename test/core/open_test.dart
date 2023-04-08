import 'package:test/test.dart';

import 'package:beany/core/account.dart';
import 'package:beany/core/open.dart';
import 'package:beany/parser/parser.dart';

void main() {
  test('Open Parser', () {
    var input = "2000-11-21 open Expenses:Personal";
    var open = parse(input).openStatement().val();

    expect(open.toString(), input);
    expect(open, Open(DateTime(2000, 11, 21), Account('Expenses:Personal')));

    var transactions = parse(input).all().val();
    var actual = transactions.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });
}
