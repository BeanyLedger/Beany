import 'package:gringotts/core/statements.dart';
import 'package:gringotts/parser.dart';
import 'package:test/test.dart';

void main() {
  test('Include Parser', () {
    expect(
      includeParser.parse('include "../path" \n').value,
      Include('../path'),
    );
  });

  test('Option Parser', () {
    expect(
      optionParser.parse('option "title" "Ed’s Personal Ledger"\n').value,
      Option('title', "Ed’s Personal Ledger"),
    );
  });
}
