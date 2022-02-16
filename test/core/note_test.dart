import 'package:gringotts/core/core.dart';
import 'package:gringotts/core/note.dart';
import 'package:gringotts/parser.dart';
import 'package:test/test.dart';

void main() {
  test('Note Parser', () {
    expect(
      noteParser
          .parse('2013-11-03 note Assets:CreditCard "Called about fraud."\n')
          .value,
      Note(
        DateTime(2013, 11, 03),
        Account('Assets:CreditCard'),
        "Called about fraud.",
      ),
    );
  });
}
