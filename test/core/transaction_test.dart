import 'package:beany/core/account.dart';
import 'package:beany/core/core.dart';
import 'package:beany/core/posting.dart';
import 'package:beany/core/transaction.dart';
import 'package:beany/parser/parser.dart';
import 'package:test/test.dart';

void main() {
  test("Calculates the Postings properly", () {
    var tr = Transaction(
      DT("2014-05-05"),
      TransactionFlag.Okay,
      "Cofee",
      postings: [
        PostingSpec(Account("Liabilities:CreditCard"), AMT("-37.45 EUR")),
        PostingSpec(Account("Expenses:Restaurant"), null),
      ],
    );

    var postings = tr.resolvedPostings();
    expect(postings.length, 2);
    expect(postings[1].amount, AMT("37.45 EUR"));
  });

  test("Calculates Posting with total price", () {
    var input = """2012-11-03 * "Transfer to account in Canada"
  Assets:MyBank:Checking  -400.00 USD @@ 436.01 CAD
  Assets:FR:SocGen:Checking
""";

    var tr = parse(input).trStatement().val();
    var postings = tr.resolvedPostings();
    expect(postings.length, 2);
    expect(postings[1].amount, AMT("436.01 CAD"));
  });

  test("Calculates the total price", () {
    var input = """
2023-03-15 * "Converted 10195.00 USD to 9457.80 EUR"
  id: "BALANCE-908717197"
  Assets:Personal:Transferwise  -10195.00 USD @ 0.932050 EUR
  Expenses:Work:BankCharges:Transferwise  47.69 USD @@ EUR
  Assets:Personal:Transferwise   9457.80 EUR
""";

    var tr = parse(input).trStatement().val();
    var postings = tr.resolvedPostings();
    expect(postings.length, 3);
    expect(postings[0].weight(), AMT("-9502.24975 EUR"));
    expect(postings[1].weight(), AMT("44.44975 EUR"));
    expect(postings[2].weight(), AMT("9457.80 EUR"));
  });

  test("Calculates the per price", () {
    var input = """
2015-02-05 * "Transfer"
  id: "44985043"
  Assets:Personal:Transferwise  -100 EUR
  Assets:Personal:India:YesBank:NRE  6,988.97 INR @ EUR
  Expenses:Personal:BankCharges:Transferwise  1 EUR
""";

    var tr = parse(input).trStatement().val();
    var postings = tr.resolvedPostings();
    expect(postings.length, 3);
    expect(postings[0].weight(), AMT("-100 EUR"));
    expect(postings[1].weight(), AMT("98.999999893278 EUR"));
    expect(postings[2].weight(), AMT("1 EUR"));
  });
}
