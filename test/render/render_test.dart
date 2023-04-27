import 'package:beany/core/account.dart';
import 'package:beany/core/core.dart';
import 'package:beany/core/posting.dart';
import 'package:beany/core/price_spec.dart';
import 'package:beany/core/transaction.dart';
import 'package:beany/misc/date.dart';
import 'package:beany/render/render.dart';
import 'package:test/test.dart';

void main() {
  test("PriceSpec", () {
    var tr = Transaction(
      Date(2021, 01, 01),
      TransactionFlag.Okay,
      "Test",
      postings: [
        Posting(
          Account("Assets:A"),
          AMT("5 EUR"),
          priceSpec: Price(amountPer: AMT("5 USD")),
        ),
        Posting(Account("Assets:B"), AMT("-25 USD")),
      ],
    );

    var expectedOutput = """
2021-01-01 * "Test"
  Assets:A  5.00 EUR @ 5.00 USD
  Assets:B  -25.00 USD
""";
    expect(render(tr).trim(), expectedOutput.trim());
  });
}
