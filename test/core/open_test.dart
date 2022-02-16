import 'package:gringotts/core/core.dart';
import 'package:gringotts/core/open.dart';
import 'package:gringotts/parser.dart';
import 'package:test/test.dart';

void main() {
  test('Open Parser', () {
    var input = "2000-11-21 open Expenses:Personal";
    var open = Open.parser.parse(input).value;

    expect(open.toString(), input);
    expect(open, Open(DateTime(2000, 11, 21), Account('Expenses:Personal')));

    var transactions = parser.parse(input).value;
    var actual = transactions.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });
}
