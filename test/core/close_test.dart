import 'package:gringotts/core/close.dart';
import 'package:gringotts/core/core.dart';
import 'package:gringotts/parser.dart';
import 'package:test/test.dart';

void main() {
  test('Close Parser', () {
    var input = "2000-11-21 close Expenses:Personal:Amazon\n";

    expect(
      closeParser.parse(input).value,
      Close(DateTime(2000, 11, 21), Account('Expenses:Personal:Amazon')),
    );

    var transactions = parser.parse(input).value;
    var actual = transactions.map((t) => t.toString()).join("\n") + "\n";
    expect(actual, input);
  });
}
