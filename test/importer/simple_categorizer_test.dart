import 'package:beany/core/account.dart';
import 'package:beany/importer/simple_categorizer.dart';
import 'package:beany/parser/parser.dart';
import 'package:test/test.dart';

var rules = """
{
    "Expenses:Personal:Groceries": [
        "getir"
    ]
}
""";

void main() {
  test("Simple Test", () {
    var input = """
2022-12-06 * "Getir Es"
  id: "CARD-515591502"
  Assets:Personal:Transferwise    -20.58 EUR
""";
    var tr = parse(input).trStatement().val().resolve();

    var categorizer = SimpleCategorizer(rules);
    expect(categorizer.classify(tr), Account("Expenses:Personal:Groceries"));
  });
}
