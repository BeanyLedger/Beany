import 'package:gringotts/core/close.dart';
import 'package:gringotts/core/core.dart';
import 'package:gringotts/parser.dart';
import 'package:test/test.dart';

void main() {
  test('Close Parser', () {
    var input = "2000-11-21 close Expenses:Personal";
    var close = Close.parser.parse(input).value;

    expect(close.toString(), input);
    expect(close, Close(DateTime(2000, 11, 21), Account('Expenses:Personal')));

    var transactions = parser.parse(input).value;
    var actual = transactions.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });
}
