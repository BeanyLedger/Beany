import 'package:decimal/decimal.dart';
import 'package:gringotts/core/common.dart';
import 'package:gringotts/core/core.dart';
import 'package:gringotts/parser.dart';
import 'package:test/test.dart';

void main() {
  test('Date Parser', () {
    expect(dateParser.parse("2020-02-03").value, DateTime(2020, 02, 03));
    expect(dateParser.parse("2020-02!03").isFailure, true);
    // expect(dateParser.parse("2020-02-33").isFailure, true);
  });

  test('Quoted String', () {
    expect(quotedStringParser.parse('"foo"').value, "foo");
    expect(quotedStringParser.parse('""').value, "");
    expect(quotedStringParser.parse('"').isFailure, true);
    expect(quotedStringParser.parse('"dafsdf\nsafasdf"').isFailure, true);
  });

  test('Number Parser', () {
    expect(numberParser.parse('1.22').value, Decimal.fromJson("1.22"));
    expect(numberParser.parse('-11.22').value, Decimal.fromJson("-11.22"));
    // expect(numberParser.parse('-11.22.2').isFailure, true);
  });
  test('No Transactions', () {
    expect(parser.parse("").value, []);
  });
}
