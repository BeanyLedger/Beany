import 'package:gringotts/core/posting.dart';
import 'package:test/test.dart';

void main() {
  test('Posting Account Only Parser', () {
    var p = Posting.simple('Assets:Savings', null, null);
    expect(postingAccountOnly.parse("  Assets:Savings\n").value, p);
  });

  test('Posting Full Parser', () {
    var p = Posting.simple("Expenses:Mystery:CatPowder", "1.5", "EUR");
    expect(
        Posting.parser.parse("  Expenses:Mystery:CatPowder  1.5 EUR\n").value,
        p);
  });

  test('Posting Full Parser Extra Spaces', () {
    var p = Posting.simple("Expenses:M", "1.5", "EUR");
    expect(Posting.parser.parse("  Expenses:M     1.5 EUR\n").value, p);
  });

  test('Posting Account Comment', () {
    var p = Posting.simple('Assets:Savings', null, null, comment: "foo");
    expect(postingAccountOnly.parse("  Assets:Savings ; foo\n").value, p);

    expect(
      postingAccountWithAmmount.parse("  Expenses:M  1.5 EUR ; foo\n").value,
      Posting.simple("Expenses:M", "1.5", "EUR", comment: "foo"),
    );
  });
}
