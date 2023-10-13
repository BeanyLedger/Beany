import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/core.dart';
import 'package:beany_core/core/posting.dart';
import 'package:beany_core/core/price_spec.dart';
import 'package:beany_core/core/transaction.dart';
import 'package:beany_core/misc/date.dart';
import 'package:beany_core/parser/parser.dart';
import 'package:beany_core/render/render.dart';
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
  Assets:A    5.00 EUR @ 5.00 USD
  Assets:B  -25.00 USD
""";
    expect(render(tr).trim(), expectedOutput.trim());
  });

  test("Complex Formatting", () {
    var input = """
2023-03-15 * "Converted 35000.00 USD to 33106.65 EUR"
  id: "CONVERSION_ORDER-494475"
  Assets:Wise           -35000.00 USD @ 0.95035 EUR
  Expenses:BankCharges     163.73 USD @@ EUR
  Assets:Wise            33106.65 EUR
""";

    var tr = parse(input).all().val().first as TransactionSpec;
    expect(render(tr).trim(), input.trim());
  });
}
