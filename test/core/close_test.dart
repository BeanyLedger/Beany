import 'package:test/test.dart';

import 'package:gringotts/core/account.dart';
import 'package:gringotts/core/close.dart';
import 'package:gringotts/parser/parser.dart';

void main() {
  test('Close Parser', () {
    var input = "2000-11-21 close Expenses:Personal";
    var close = parse(input).closeStatement().val();

    expect(close.toString(), input);
    expect(close, Close(DateTime(2000, 11, 21), Account('Expenses:Personal')));

    var transactions = parse(input).all().val();
    var actual = transactions.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });
}
