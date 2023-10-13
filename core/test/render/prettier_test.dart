import 'package:beany_core/parser/parser.dart';
import 'package:beany_core/render/prettier.dart';
import 'package:beany_core/render/render.dart';
import 'package:test/test.dart';

void main() {
  test("Simple 2 Postings", () {
    var input = """
2022-11-03 * "Sushi"
  Assets:MyBank  -400.00 USD
  Expenses:Restaurant 400 USD
""";

    var tr = parse(input).trStatement().val().resolve();
    var output = render(tr.pretty());

    var expectedOutput = """
2022-11-03 * "Sushi"
  Expenses:Restaurant  400.00 USD
  Assets:MyBank
""";
    expect(output, expectedOutput);
  });
}
