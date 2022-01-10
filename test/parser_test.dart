import 'package:gringotts/core.dart';
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
  });

  test('Transaction Header', () {
    expect(
      trHeaderParser.parse('2019-04-14 * "Cat Powder"').value,
      Transaction(DateTime(2019, 4, 14), TransactionFlag.Okay, 'Cat Powder'),
    );
  });

  test('Account', () {
    expect(accountParser.parse('Hello:A:B').value, Account('Hello:A:B'));
  });

  test('No Transactions', () {
    final parser = Parser();
    expect(parser.parse(""), []);
  });

  test('Simple Transaction', () {
    var input = """2019-04-14 * "Cat Powder"
  ; Help
  Expenses:Mystery:CatPowder  1.5 EUR
  Assets:Savings
""";

    var tr = Transaction(
      DateTime(2019, 4, 14),
      TransactionFlag.Okay,
      'Cat Powder',
    );
    Posting.simple(tr, "Expenses:Mystery:CatPowder", "1.5", "EUR");
    Posting.simple(tr, "Assets:Savings", null, null);
    tr.comments.add("Help");

    final parser = Parser();
    var actual = parser.parse(input);
    expect(actual.length, 1);
    expect(actual[0].toString(), tr.toString());
  });

  test('Multiple Transactions', () {
    var input = """2019-04-14 * "Cat Powder"
  ; Help
  Expenses:Mystery:CatPowder  1.5 EUR
  Assets:Savings

2019-04-19 ! Dog Powder
  ; Helper
  Expenses:Mystery:DogPowder  2.5 EUR
  Assets:Dogs

""";

    final parser = Parser();
    var transactions = parser.parse(input);
    var actual = transactions.map((t) => t.toString()).join("\n") + "\n";
    expect(actual, input);
  });
}

// metadata such as
// id: "dafsdaf"
// Currency conversion, complex posting
