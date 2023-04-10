import 'package:beany/core/account.dart';
import 'package:beany/core/core.dart';
import 'package:beany/core/posting.dart';
import 'package:beany/core/transaction.dart';
import 'package:test/test.dart';

void main() {
  test("Calculates the Postings properly", () {
    var tr = Transaction(
      DT("2014-05-05"),
      TransactionFlag.Okay,
      "Cofee",
      postings: [
        Posting(Account("Liabilities:CreditCard"), AMT("-37.45 EUR")),
        Posting(Account("Expenses:Restaurant"), null),
      ],
    );

    var postings = tr.resolvedPostings();
    expect(postings.length, 2);
    expect(postings[1].amount, AMT("37.45 EUR"));
  });
}
