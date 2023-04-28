import 'package:beany/core/amount.dart';
import 'package:beany/core/core.dart';
import 'package:beany/core/meta_value.dart';
import 'package:beany/misc/date.dart';
import 'package:beany/render/render.dart';
import 'package:test/test.dart';

import 'package:beany/core/account.dart';
import 'package:beany/core/posting.dart';
import 'package:beany/core/transaction.dart';
import 'package:beany/parser/parser.dart';

typedef A = Account;

void main() {
  test('Transaction Header', () {
    expect(
      parse('2019-04-14 * "Cat Powder"\n').trHeader().val(),
      TransactionSpec(Date(2019, 4, 14), TransactionFlag.Okay, 'Cat Powder'),
    );
    expect(
      render(parse('2019-04-14 * "Cat Powder"\n').trHeader().val()),
      '2019-04-14 * "Cat Powder"\n',
    );
    expect(
      parse('2019-04-14 ! "Cat Powder"\n').trHeader().val(),
      TransactionSpec(Date(2019, 4, 14), TransactionFlag.Warning, 'Cat Powder'),
    );
    expect(
      render(parse('2019-04-14 ! "Cat Powder"\n').trHeader().val()),
      '2019-04-14 ! "Cat Powder"\n',
    );
    expect(
      render(parse('2019-04-14 txn "Cat Powder"\n').trHeader().val()),
      '2019-04-14 * "Cat Powder"\n',
    );
    expect(
      parse('2019-04-14 ! "Cat" "Payee"\n').trHeader().val(),
      TransactionSpec(
        Date(2019, 4, 14),
        TransactionFlag.Warning,
        'Cat',
        payee: "Payee",
      ),
    );
    expect(
      render(parse('2019-04-14 ! "Cat" "Payee"\n').trHeader().val()),
      '2019-04-14 ! "Cat" "Payee"\n',
    );
    expect(
      parse('2019-04-14 ! "Cat" #hello #berlin-2014\n').trHeader().val(),
      TransactionSpec(Date(2019, 4, 14), TransactionFlag.Warning, 'Cat',
          tags: ["hello", "berlin-2014"]),
    );
    expect(
      render(
        parse('2019-04-14 ! "Cat" #hello #berlin-2014\n').trHeader().val(),
      ),
      '2019-04-14 ! "Cat" #hello #berlin-2014\n',
    );
  });

  test('Comment Parser', () {
    expect(parse("  ;Hello").comment().val(), "Hello");
    expect(parse("  ;Hello\n").comment().val(), "Hello");
    expect(parse("  ; Hello\n").comment().val(), "Hello");
    expect(parse("  ; Hello \n").comment().val(), "Hello");
    expect(parse("  ; Hello\nHi").comment().val(), "Hello");
  });

  test('Comment Parser Special String', () {
    expect(parse("  ; Róú's brithday\n").comment().val(), "Róú's brithday");
  });

  test('Simple Transaction', () {
    var input = """2019-04-14 * "Cat Powder"
  ; Help
  Expenses:Mystery:CatPowder  1.5 EUR
  Assets:Savings
""";

    var tr = TransactionSpec(
      Date(2019, 4, 14),
      TransactionFlag.Okay,
      'Cat Powder',
      postings: [
        PostingSpec(
          A("Expenses:Mystery:CatPowder"),
          AMT("1.5 EUR"),
          preComments: ["Help"],
        ),
        PostingSpec(A("Assets:Savings"), null),
      ],
    );

    expect(parse(input).trStatement().val(), tr);
  });

  test('Transaction MetaData', () {
    var input = """2019-04-14 * "Cat Powder"
  stringValue: "foo"
  numberValue: 1.5
  amountValue: 4.4 EUR
  datesVal1: 2022-12-09
  tagValue: #berlin-wall
  accountValue: Assets:Fire
  Expenses:Mystery:CatPowder  1.5 EUR
  Assets:Savings
""";

/*

  datesVal2: 2022-12-09T14:05:00
  datesVal3: 2022-12-09 14:05:00
  currencyValue: EUR
  */

    var tr = TransactionSpec(
      Date(2019, 4, 14),
      TransactionFlag.Okay,
      'Cat Powder',
      postings: [
        PostingSpec(A("Expenses:Mystery:CatPowder"), AMT("1.5 EUR")),
        PostingSpec(A("Assets:Savings"), null),
      ],
      meta: {
        "stringValue": MetaValue(stringValue: "foo"),
        "numberValue": MetaValue(numberValue: D("1.5")),
        "amountValue": MetaValue(
          amountValue: Amount(D("4.4"), "EUR"),
        ),
        "datesVal1": MetaValue(dateValue: DT("2022-12-09")),
        // "datesVal2": "2022-12-09T14:05:00",
        // "datesVal3": "2022-12-09 14:05:00",
        "tagValue": MetaValue(tagValue: 'berlin-wall'),
        // "currencyValue": MetaDataValue(currencyValue: "EUR"),
        "accountValue": MetaValue(accountValue: Account("Assets:Fire")),
      },
    );

    var actual = parse(input).trStatement().val();
    expect(actual, tr);
    expect(render(actual), render(tr));
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

""";
// ; Comment

    var transactions = parse(input).all().val();
    var actual = transactions.map((t) => render(t)).join("\n") + "\n";
    expect(actual.trim(), input.trim());
  });

  test('Transaction with Posting Comments', () {
    var input = """2019-04-14 * "Cat Powder"
  ; Help
  Expenses:Mystery:CatPowder  1.50 EUR
  ; Booty
  Assets:Savings
""";

    var tr = TransactionSpec(
      Date(2019, 4, 14),
      TransactionFlag.Okay,
      'Cat Powder',
      postings: [
        PostingSpec(A("Expenses:Mystery:CatPowder"), AMT("1.5 EUR"),
            preComments: ["Help"]),
        PostingSpec(A("Assets:Savings"), null, preComments: ["Booty"]),
      ],
    );

    expect(parse(input).trStatement().val(), tr);
    expect(render(tr), input);
  });
}
