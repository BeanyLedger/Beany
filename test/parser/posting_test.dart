import 'package:test/test.dart';

import 'package:beany/core/posting.dart';
import 'package:beany/parser/parser.dart';

void main() {
  test('Posting Account Only Parser', () {
    var p = Posting.simple('Assets:Savings', null, null);
    expect(parse("  Assets:Savings").postingSpecAccountOnly().val(), p);
  });

  test('Posting Full Parser', () {
    var p = Posting.simple("Expenses:Mystery:CatPowder", "1.5", "EUR");
    expect(
        parse("  Expenses:Mystery:CatPowder  1.5 EUR")
            .postingSpecAccountAmount()
            .val(),
        p);
  });

  test('Posting Full Parser Extra Spaces', () {
    var p = Posting.simple("Expenses:M", "1.5", "EUR");
    expect(
        parse("  Expenses:M     1.5 EUR").postingSpecAccountAmount().val(), p);
  });

  test('Posting Account Comment', () {
    var p = Posting.simple('Assets:Savings', null, null, comment: "foo");
    expect(parse("  Assets:Savings ; foo").postingSpecAccountOnly().val(), p);

    expect(
      parse("  Expenses:M  1.5 EUR ; foo").postingSpecAccountAmount().val(),
      Posting.simple("Expenses:M", "1.5", "EUR", comment: "foo"),
    );
  });

  test('Posting Account Tags', () {
    var p = Posting.simple(
      'Assets:Savings',
      null,
      null,
      tags: ['fire', 'water'],
    );
    expect(
      parse("  Assets:Savings #fire #water").postingSpecAccountOnly().val(),
      p,
    );

    expect(
      parse("  Expenses:M  1.5 EUR #ele-ment #gogo")
          .postingSpecAccountAmount()
          .val(),
      Posting.simple("Expenses:M", "1.5", "EUR", tags: ["ele-ment", "gogo"]),
    );
  });

  // Posting with a cost spec per unit
  //                cost spec total
  //                price per unit
  //                price total
  //                price with number optional
}
