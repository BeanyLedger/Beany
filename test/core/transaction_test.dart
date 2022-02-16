import 'package:decimal/decimal.dart';
import 'package:gringotts/core/account.dart';
import 'package:gringotts/core/core.dart';
import 'package:gringotts/core/transaction.dart';
import 'package:gringotts/parser.dart';
import 'package:test/test.dart';

void main() {
  test('Transaction Header', () {
    expect(
      trHeaderParser.parse('2019-04-14 * "Cat Powder"\n').value,
      Transaction(DateTime(2019, 4, 14), TransactionFlag.Okay, 'Cat Powder'),
    );
    expect(
      trHeaderParser.parse('2019-04-14 * "Cat Powder"\n').value.toString(),
      '2019-04-14 * "Cat Powder"\n',
    );
    expect(
      trHeaderParser.parse('2019-04-14 ! "Cat Powder"\n').value,
      Transaction(DateTime(2019, 4, 14), TransactionFlag.Warning, 'Cat Powder'),
    );
    expect(
      trHeaderParser.parse('2019-04-14 ! "Cat Powder"\n').value.toString(),
      '2019-04-14 ! "Cat Powder"\n',
    );
    expect(
      trHeaderParser.parse('2019-04-14 ! "Cat" "Payee"\n').value,
      Transaction(
        DateTime(2019, 4, 14),
        TransactionFlag.Warning,
        'Cat',
        payee: "Payee",
      ),
    );
    expect(
      trHeaderParser.parse('2019-04-14 ! "Cat" "Payee"\n').value.toString(),
      '2019-04-14 ! "Cat" "Payee"\n',
    );
    expect(
      trHeaderParser.parse('2019-04-14 ! "Cat" #hello #berlin-2014\n').value,
      Transaction(DateTime(2019, 4, 14), TransactionFlag.Warning, 'Cat',
          tags: ["hello", "berlin-2014"]),
    );
    expect(
      trHeaderParser
          .parse('2019-04-14 ! "Cat" #hello #berlin-2014\n')
          .value
          .toString(),
      '2019-04-14 ! "Cat" #hello #berlin-2014\n',
    );
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

  test('Posting Comment Only Parser', () {
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

    expect(Transaction.parser.parse(input).value, tr);
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

    expect(Transaction.parser.parse(input).value, tr);
    expect(Transaction.parser.parse(input).value.toString(), tr.toString());
  });

  test('Multiple Transactions', () {
    var input = """
2019-04-14 * "Cat Powder"
  ; Help
  Expenses:Mystery:CatPowder  1.50 EUR
  Assets:Savings

2019-04-19 ! "Dog Powder"
  ; Helper
  Expenses:Mystery:DogPowder  -2.50 EUR
  Assets:Dogs

; Comment
""";

    var transactions = parser.parse(input).value;
    var actual = transactions.map((t) => t.toString()).join("\n") + "\n";
    expect(actual, input);
  });

  test('Posting with Explicit Price', () {
    var input = """2012-11-03 * "Transfer to account in Canada"
  Assets:MyBank:Checking  -400.00 USD @ 1.09 CAD
  Assets:FR:SocGen:Checking  436.01 CAD
""";

    var tr = Transaction.parser.parse(input).value;
    expect(tr.toString(), input);
    expect(
      tr,
      Transaction(
        DateTime(2012, 11, 3),
        TransactionFlag.Okay,
        "Transfer to account in Canada",
        postings: [
          Posting(
            Account('Assets:MyBank:Checking'),
            Amount(Decimal.fromJson("-400.00"), "USD"),
            cost: Cost(
              Decimal.fromJson("1.09"),
              "CAD",
              date: DateTime(2012, 11, 3),
            ),
          ),
          Posting(
            Account('Assets:FR:SocGen:Checking'),
            Amount(Decimal.fromJson("436.01"), "CAD"),
          )
        ],
      ),
    );
  });
}


// Query directive
// Custom


// Currency conversion, complex posting


/*
2012-11-03 * "Transfer to account in Canada"
  Assets:MyBank:Checking            -400.00 USD @@ 436.01 CAD
  Assets:FR:SocGen:Checking          436.01 CAD

- Posting with Price Total Cost

*/

/*
2014-02-11 * "Bought shares of S&P 500"
  Assets:ETrade:IVV                10 IVV {183.07 USD}
  Assets:ETrade:Cash         -1830.70 USD

- Posting At Cost
*/

/*
2014-07-11 * "Sold shares of S&P 500"
  Assets:ETrade:IVV               -10 IVV {183.07 USD} @ 197.90 USD
  Assets:ETrade:Cash          1979.90 USD
  Income:ETrade:CapitalGains

- Posting At Cost With Price
*/

/*
Links

2014-02-05 * "Invoice for January" ^invoice-pepe-studios-jan14
  Income:Clients:PepeStudios           -8450.00 USD
  Assets:AccountsReceivable

2014-02-20 * "Check deposit - payment from Pepe" ^invoice-pepe-studios-jan14
  Assets:BofA:Checking                  8450.00 USD
  Assets:AccountsReceivable

  */




/*
2013-03-14 open Assets:BTrade:HOOLI
  category: "taxable"

Metadata values -
    Strings
    Accounts
    Currency
    Dates (datetime.date)
    Tags
    Numbers (Decimal)
    Amount (beancount.core.amount.Amount)
*/


//
//
