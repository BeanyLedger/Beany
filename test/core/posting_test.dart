import 'package:gringotts/core/posting.dart';
import 'package:gringotts/parser/parser.dart';
import 'package:test/test.dart';

void main() {
  test('Posting Account Only Parser', () {
    var p = Posting.simple('Assets:Savings', null, null);
    expect(parse("  Assets:Savings").posting_spec_account_only().val(), p);
  });

  test('Posting Full Parser', () {
    var p = Posting.simple("Expenses:Mystery:CatPowder", "1.5", "EUR");
    expect(
        parse("  Expenses:Mystery:CatPowder  1.5 EUR")
            .posting_spec_account_amount()
            .val(),
        p);
  });

  test('Posting Full Parser Extra Spaces', () {
    var p = Posting.simple("Expenses:M", "1.5", "EUR");
    expect(
        parse("  Expenses:M     1.5 EUR").posting_spec_account_amount().val(),
        p);
  });

  test('Posting Account Comment', () {
    var p = Posting.simple('Assets:Savings', null, null, comment: "foo");
    expect(
        parse("  Assets:Savings ; foo").posting_spec_account_only().val(), p);

    expect(
      parse("  Expenses:M  1.5 EUR ; foo").posting_spec_account_amount().val(),
      Posting.simple("Expenses:M", "1.5", "EUR", comment: "foo"),
    );
  });

  // Posting with a cost spec per unit
  //                cost spec total
  //                price per unit
  //                price total
  //                price with number optional
}
