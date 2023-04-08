import 'package:test/test.dart';

import 'package:beany/core/account.dart';
import 'package:beany/core/note.dart';
import 'package:beany/parser/parser.dart';

void main() {
  test('Note Parser', () {
    var input = '2013-11-03 note Assets:CreditCard "Called about fraud."';
    var note = parse(input).noteStatement().val();

    expect(note.toString(), input);
    expect(
      note,
      Note(
        DateTime(2013, 11, 03),
        Account('Assets:CreditCard'),
        "Called about fraud.",
      ),
    );

    var transactions = parse(input).all().val();
    var actual = transactions.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });
}
