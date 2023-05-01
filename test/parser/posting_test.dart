import 'package:beany/core/account.dart';
import 'package:beany/core/amount.dart';
import 'package:beany/core/core.dart';
import 'package:beany/core/cost_spec.dart';
import 'package:beany/core/price_spec.dart';
import 'package:beany/render/render.dart';
import 'package:test/test.dart';

import 'package:beany/core/posting.dart';
import 'package:beany/parser/parser.dart';

typedef A = Account;

void main() {
  test('Posting Account Only Parser', () {
    var p = PostingSpec(A('Assets:Savings'), null);
    expect(parse("  Assets:Savings").postingSpec().val(), p);
  });

  test('Posting Full Parser', () {
    var p = PostingSpec(A("Expenses:Mystery:CatPowder"), AMT("1.5 EUR"));
    expect(
        parse("  Expenses:Mystery:CatPowder  1.5 EUR").postingSpec().val(), p);
  });

  test('Posting Full Parser Extra Spaces', () {
    var p = PostingSpec(A("Expenses:M"), AMT("1.5 EUR"));
    expect(parse("  Expenses:M     1.5 EUR").postingSpec().val(), p);
  });

  test('Posting Account Comment', () {
    var p = PostingSpec(A('Assets:Savings'), null, comment: "foo");
    expect(parse("  Assets:Savings ; foo").postingSpec().val(), p);

    expect(
      parse("  Expenses:M  1.5 EUR ; foo").postingSpec().val(),
      PostingSpec(A("Expenses:M"), AMT("1.5 EUR"), comment: "foo"),
    );
  });

  test('Posting Account Tags', () {
    var p = PostingSpec(A('Assets:Savings'), null, tags: ['fire', 'water']);
    expect(
      parse("  Assets:Savings #fire #water").postingSpec().val(),
      p,
    );

    expect(
      parse("  Expenses:M  1.5 EUR #ele-ment #gogo").postingSpec().val(),
      PostingSpec(A("Expenses:M"), AMT("1.5 EUR"), tags: ["ele-ment", "gogo"]),
    );
  });

  test('Posting with Per Price', () {
    var input = "Assets:MyBank:Checking  -400.00 USD @ 1.09 CAD";
    var p = parse(input).postingSpec().val();
    var actual = PostingSpec(
      Account('Assets:MyBank:Checking'),
      Amount(D("-400.00"), "USD"),
      priceSpec: PriceSpec(
        amountPer: AmountSpec(D("1.09"), "CAD"),
      ),
    );
    expect(p, actual);
    expect(renderPosting(p).trim(), input);
  });

  test('Posting with Total Price', () {
    var input = "Assets:MyBank:Checking  -400.00 USD @@ 436.01 CAD";
    var p = parse(input).postingSpec().val();
    var actual = PostingSpec(
      Account('Assets:MyBank:Checking'),
      Amount(D("-400.00"), "USD"),
      priceSpec: PriceSpec(
        amountTotal: AmountSpec(D("436.01"), "CAD"),
      ),
    );
    expect(p, actual);
    expect(renderPosting(p).trim(), input);
  });

  test('Posting with Price Spec', () {
    var input = "Expenses:B  89.33 USD @@ EUR";
    var p = parse(input).postingSpec().val();
    var actual = PostingSpec(
      Account('Expenses:B'),
      Amount(D("89.33"), "USD"),
      priceSpec: PriceSpec(
        amountTotal: AmountSpec(null, "EUR"),
      ),
    );
    expect(p, actual);
    expect(renderPosting(p).trim(), input);
  });

  test("Posting with Cost", () {
    var input = "Assets:A  10.00 SOME {2.02 USD}";
    var p = parse(input).postingSpec().val();
    var expected = PostingSpec(
      Account('Assets:A'),
      AMT("10 SOME"),
      costSpec: CostSpec(amountPer: AMT("2.02 USD")),
    );
    expect(p, expected);
    expect(renderPosting(p).trim(), input);
  });

  test("Posting with Total Cost", () {
    var input = "Assets:A  10.00 SOME {{2.02 USD}}";
    var p = parse(input).postingSpec().val();
    var expected = PostingSpec(
      Account('Assets:A'),
      AMT("10 SOME"),
      costSpec: CostSpec(amountTotal: AMT("2.02 USD")),
    );
    expect(p, expected);
    expect(renderPosting(p).trim(), input);
  });

  test("Posting with Cost and Price", () {
    var input = "Assets:A  10.00 SOME {2.02 USD} @ 1.00 USD";
    var p = parse(input).postingSpec().val();
    var expected = PostingSpec(
      Account('Assets:A'),
      AMT("10 SOME"),
      costSpec: CostSpec(amountPer: AMT("2.02 USD")),
      priceSpec: PriceSpec(amountPer: AmountSpec(D("1.00"), "USD")),
    );
    expect(p, expected);
    expect(renderPosting(p).trim(), input);
  });
}
