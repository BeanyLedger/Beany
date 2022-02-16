import 'package:gringotts/core/core.dart';
import 'package:gringotts/core/open.dart';
import 'package:gringotts/parser.dart';
import 'package:test/test.dart';

void main() {
  test('Open Parser', () {
    var input = "2000-11-21 open Expenses:Personal:Amazon\n";

    expect(
      Open.parser.parse(input).value,
      Open(DateTime(2000, 11, 21), Account('Expenses:Personal:Amazon')),
    );

    var transactions = parser.parse(input).value;
    var actual = transactions.map((t) => t.toString()).join("\n") + "\n";
    expect(actual, input);
  });
}
