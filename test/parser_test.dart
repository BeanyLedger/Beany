import 'package:decimal/decimal.dart';
import 'package:gringotts/core/balance.dart';
import 'package:gringotts/core/close.dart';
import 'package:gringotts/core/commodity.dart';
import 'package:gringotts/core/core.dart';
import 'package:gringotts/core/include.dart';
import 'package:gringotts/core/open.dart';
import 'package:gringotts/core/option.dart';
import 'package:gringotts/core/price.dart';
import 'package:gringotts/core/transactions.dart';
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
    expect(
      trHeaderParser.parse('2019-04-14 ! "Cat" #hello #berlin-2014\n').value,
      Transaction(DateTime(2019, 4, 14), TransactionFlag.Warning, 'Cat',
          tags: ["hello", "berlin-2014"]),
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

  test('Posting Account Comment', () {
    var p = Posting.simple('Assets:Savings', null, null, comment: "foo");
    expect(postingAccountOnly.parse("  Assets:Savings ; foo\n").value, p);

    expect(
      postingAccountWithAmmount.parse("  Expenses:M  1.5 EUR ; foo\n").value,
      Posting.simple("Expenses:M", "1.5", "EUR", comment: "foo"),
    );
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

  test('Transaction MetaData', () {
    var input = """2019-04-14 * "Cat Powder"
  id: "foo"
  power: "zoo"
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
      meta: {"id": "foo", "power": "zoo"},
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

; Comment
""";

    var transactions = parser.parse(input).value;
    var actual = transactions.map((t) => t.toString()).join("\n") + "\n";
    expect(actual, input);
  });

  test('Balance Parser', () {
    var input = "2002-01-15 balance Assets:Personal:Transferwise  98.87 EUR\n";

    expect(
      balanceParser.parse(input).value,
      Balance(
        DateTime(2002, 01, 15),
        Account('Assets:Personal:Transferwise'),
        Amount(Decimal.parse("98.87"), "EUR"),
      ),
    );

    var transactions = parser.parse(input).value;
    var actual = transactions.map((t) => t.toString()).join("\n") + "\n";
    expect(actual, input);
  });

  test('Price Parser', () {
    var input = "2002-01-15 price INR  98.87 EUR\n";

    expect(
      priceParser.parse(input).value,
      Price(
        DateTime(2002, 01, 15),
        'INR',
        Amount(Decimal.parse("98.87"), "EUR"),
      ),
    );

    var transactions = parser.parse(input).value;
    var actual = transactions.map((t) => t.toString()).join("\n") + "\n";
    expect(actual, input);
  });
  test('Open Parser', () {
    var input = "2000-11-21 open Expenses:Personal:Amazon\n";

    expect(
      openParser.parse(input).value,
      Open(DateTime(2000, 11, 21), Account('Expenses:Personal:Amazon')),
    );

    var transactions = parser.parse(input).value;
    var actual = transactions.map((t) => t.toString()).join("\n") + "\n";
    expect(actual, input);
  });

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

  test('Commodity Parser', () {
    var input = "2000-11-21 commodity INR\n";

    expect(
      commodityParser.parse(input).value,
      Commodity(DateTime(2000, 11, 21), 'INR'),
    );

    var transactions = parser.parse(input).value;
    var actual = transactions.map((t) => t.toString()).join("\n") + "\n";
    expect(actual, input);
  });

  test('Option Parser', () {
    expect(
      optionParser.parse('option "title" "Ed’s Personal Ledger"\n').value,
      Option('title', "Ed’s Personal Ledger"),
    );
  });

  test('Include Parser', () {
    expect(
      includeParser.parse('include "../path" \n').value,
      Include('../path'),
    );
  });
}


// Note directive
// Event directive
// Query directive
// Document
// Custom
