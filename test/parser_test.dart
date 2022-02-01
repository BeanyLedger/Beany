import 'package:decimal/decimal.dart';
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
    expect(quotedStringParser.parse('"dafsdf\nsafasdf"').isFailure, true);
  });

  test('Number Parser', () {
    expect(numberParser.parse('1.22').value, Decimal.fromJson("1.22"));
    expect(numberParser.parse('-11.22').value, Decimal.fromJson("-11.22"));
    // expect(numberParser.parse('-11.22.2').isFailure, true);
  });

  test('Transaction Header', () {
    expect(
      trHeaderParser.parse('2019-04-14 * "Cat Powder"\n').value,
      Transaction(DateTime(2019, 4, 14), TransactionFlag.Okay, 'Cat Powder'),
    );
    expect(
      trHeaderParser.parse('2019-04-14 ! "Cat Powder"\n').value,
      Transaction(DateTime(2019, 4, 14), TransactionFlag.Warning, 'Cat Powder'),
    );
    expect(
      trHeaderParser.parse('2019-04-14 ! "Cat Powder" "Payee"\n').value,
      Transaction(
        DateTime(2019, 4, 14),
        TransactionFlag.Warning,
        'Cat Powder',
        payee: "Payee",
      ),
    );
  });

  test('Account', () {
    expect(accountParser.parse('Hello:A:B').value, Account('Hello:A:B'));
  });

  test('No Transactions', () {
    expect(parser.parse("").value, []);
  });

  test('Comment Parser', () {
    expect(trComment.parse("  ;Hello\n").value, "Hello");
    expect(trComment.parse("  ; Hello\n").value, "Hello");
    expect(trComment.parse("  ; Hello \n").value, "Hello");
    expect(trComment.parse("  ; Hello\nHi").value, "Hello");
  });

  test('Comment Parser Special String', () {
    expect(trComment.parse("  ; Róú's brithday\n").value, "Róú's brithday");
  });

  test('Comment Only Parser', () {
    var input = """  ; Hello
  Expenses:Mystery:CatPowder  1.5 EUR
""";
    expect(trComment.parse(input).value, "Hello");
  });

  test('Posting Account Only Parser', () {
    var p = Posting.simple('Assets:Savings', null, null);
    expect(postingAccountOnly.parse("  Assets:Savings\n").value, p);
  });

  test('Posting Full Parser', () {
    var p = Posting.simple("Expenses:Mystery:CatPowder", "1.5", "EUR");
    expect(posting.parse("  Expenses:Mystery:CatPowder  1.5 EUR\n").value, p);
  });

  test('Posting Full Parser Extra Spaces', () {
    var p = Posting.simple("Expenses:M", "1.5", "EUR");
    expect(posting.parse("  Expenses:M     1.5 EUR\n").value, p);
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
      postings: [
        Posting.simple("Expenses:Mystery:CatPowder", "1.5", "EUR"),
        Posting.simple("Assets:Savings", null, null),
      ],
      comments: ["Help"],
    );

    expect(trParser.parse(input).value, tr);
  });

  test('Multiple Transactions', () {
    var input = """
2019-04-14 * "Cat Powder"
  ; Help
  Expenses:Mystery:CatPowder  1.5 EUR
  Assets:Savings

2019-04-19 ! "Dog Powder"
  ; Helper
  Expenses:Mystery:DogPowder  -2.5 EUR
  Assets:Dogs

""";

    var transactions = parser.parse(input).value;
    var actual = transactions.map((t) => t.toString()).join("\n") + "\n";
    expect(actual, input);
  });
}
