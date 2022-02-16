import 'package:gringotts/core/account.dart';
import 'package:gringotts/core/note.dart';
import 'package:gringotts/parser.dart';
import 'package:test/test.dart';

void main() {
  test('Note Parser', () {
    var input = '2013-11-03 note Assets:CreditCard "Called about fraud."';
    var note = Note.parser.parse(input).value;

    expect(note.toString(), input);
    expect(
      note,
      Note(
        DateTime(2013, 11, 03),
        Account('Assets:CreditCard'),
        "Called about fraud.",
      ),
    );

    var transactions = parser.parse(input).value;
    var actual = transactions.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });
}
