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
}
