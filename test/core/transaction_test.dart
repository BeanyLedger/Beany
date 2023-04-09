import 'package:beany/core/amount.dart';
import 'package:beany/core/cost_spec.dart';
import 'package:beany/core/meta_value.dart';
import 'package:decimal/decimal.dart';
import 'package:test/test.dart';

import 'package:beany/core/account.dart';
import 'package:beany/core/posting.dart';
import 'package:beany/core/transaction.dart';
import 'package:beany/parser/parser.dart';

void main() {
  test('Transaction Header', () {
    expect(
      parse('2019-04-14 * "Cat Powder"\n').trHeader().val(),
      Transaction(DateTime(2019, 4, 14), TransactionFlag.Okay, 'Cat Powder'),
    );
    expect(
      parse('2019-04-14 * "Cat Powder"\n').trHeader().val().toString(),
      '2019-04-14 * "Cat Powder"\n',
    );
    expect(
      parse('2019-04-14 ! "Cat Powder"\n').trHeader().val(),
      Transaction(DateTime(2019, 4, 14), TransactionFlag.Warning, 'Cat Powder'),
    );
    expect(
      parse('2019-04-14 ! "Cat Powder"\n').trHeader().val().toString(),
      '2019-04-14 ! "Cat Powder"\n',
    );
    expect(
      parse('2019-04-14 txn "Cat Powder"\n').trHeader().val().toString(),
      '2019-04-14 * "Cat Powder"\n',
    );
    expect(
      parse('2019-04-14 ! "Cat" "Payee"\n').trHeader().val(),
      Transaction(
        DateTime(2019, 4, 14),
        TransactionFlag.Warning,
        'Cat',
        payee: "Payee",
      ),
    );
    expect(
      parse('2019-04-14 ! "Cat" "Payee"\n').trHeader().val().toString(),
      '2019-04-14 ! "Cat" "Payee"\n',
    );
    expect(
      parse('2019-04-14 ! "Cat" #hello #berlin-2014\n').trHeader().val(),
      Transaction(DateTime(2019, 4, 14), TransactionFlag.Warning, 'Cat',
          tags: ["hello", "berlin-2014"]),
    );
    expect(
      parse('2019-04-14 ! "Cat" #hello #berlin-2014\n')
          .trHeader()
          .val()
          .toString(),
      '2019-04-14 ! "Cat" #hello #berlin-2014\n',
    );
  });

  test('Comment Parser', () {
    expect(parse("  ;Hello").tr_comment().val(), "Hello");
    expect(parse("  ;Hello\n").tr_comment().val(), "Hello");
    expect(parse("  ; Hello\n").tr_comment().val(), "Hello");
    expect(parse("  ; Hello \n").tr_comment().val(), "Hello");
    expect(parse("  ; Hello\nHi").tr_comment().val(), "Hello");
  });

  test('Comment Parser Special String', () {
    expect(parse("  ; Róú's brithday\n").tr_comment().val(), "Róú's brithday");
  }, skip: true);

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

    expect(parse(input).trStatement().val(), tr);
  });

  test('Transaction MetaData', () {
    var input = """2019-04-14 * "Cat Powder"
  stringValue: "foo"
  numberValue: 1.5
  amountValue: 4.4 EUR
  tagValue: #berlin-wall
  accountValue: Assets:Fire
  Expenses:Mystery:CatPowder  1.5 EUR
  Assets:Savings
""";

/*

  datesVal1: 2022-12-09
  datesVal2: 2022-12-09T14:05:00
  datesVal3: 2022-12-09 14:05:00
  currencyValue: EUR
  */

    var tr = Transaction(
      DateTime(2019, 4, 14),
      TransactionFlag.Okay,
      'Cat Powder',
      postings: [
        Posting.simple("Expenses:Mystery:CatPowder", "1.5", "EUR"),
        Posting.simple("Assets:Savings", null, null),
      ],
      meta: {
        "stringValue": MetaValue(stringValue: "foo"),
        "numberValue": MetaValue(numberValue: Decimal.parse("1.5")),
        "amountValue": MetaValue(
          amountValue: Amount(Decimal.parse("4.4"), "EUR"),
        ),
        // "datesVal1": MetaDataValue(dateValue: "2022-12-09"),
        // "datesVal2": "2022-12-09T14:05:00",
        // "datesVal3": "2022-12-09 14:05:00",
        "tagValue": MetaValue(tagValue: 'berlin-wall'),
        // "currencyValue": MetaDataValue(currencyValue: "EUR"),
        "accountValue": MetaValue(accountValue: Account("Assets:Fire")),
      },
    );

    expect(parse(input).trStatement().val(), tr);
    expect(parse(input).trStatement().val().toString(), tr.toString());
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

    var transactions = parse(input).all().val();
    var actual = transactions.map((t) => t.toString()).join("\n") + "\n";
    expect(actual.trim(), input.trim());
  });

  test('Posting with Explicit Price', () {
    var input = """2012-11-03 * "Transfer to account in Canada"
  Assets:MyBank:Checking  -400.00 USD @ 1.09 CAD
  Assets:FR:SocGen:Checking  436.01 CAD
""";

    var tr = parse(input).trStatement().val();
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
            costSpec: CostSpec(
              amountPer: AmountSpec(Decimal.fromJson("1.09"), "CAD"),
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

  test('Posting with Total Price', () {
    var input = """2012-11-03 * "Transfer to account in Canada"
  Assets:MyBank:Checking  -400.00 USD @@ 436.01 CAD
  Assets:FR:SocGen:Checking  436.01 CAD
""";

    var tr = parse(input).trStatement().val();
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
            costSpec: CostSpec(
              amountTotal: AmountSpec(Decimal.fromJson("436.01"), "CAD"),
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

  test('Posting with Cost Spec', () {
    var input = """2023-03-15 * "Blimey"
  Assets:A  -19095.86 USD @ 0.93205
  Expenses:B  89.33 USD @@ EUR
  Assets:A  17715.04 EUR
""";

    var tr = parse(input).trStatement().val();
    expect(tr.toString(), input);
    expect(
      tr,
      Transaction(
        DateTime(2023, 3, 15),
        TransactionFlag.Okay,
        "Blimey",
        postings: [
          Posting(
            Account('Assets:A'),
            Amount(Decimal.fromJson("-19095.86"), "USD"),
            costSpec: CostSpec(
              amountPer: AmountSpec(Decimal.parse("0.93205"), null),
            ),
          ),
          Posting(
            Account('Expenses:B'),
            Amount(Decimal.fromJson("89.33"), "USD"),
            costSpec: CostSpec(
              amountTotal: AmountSpec(null, "EUR"),
            ),
          ),
          Posting(
            Account('Assets:A'),
            Amount(Decimal.fromJson("17715.04"), "EUR"),
          )
        ],
      ),
    );
  });
}


// Query directive
// Custom

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
