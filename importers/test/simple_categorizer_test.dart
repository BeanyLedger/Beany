import 'package:beany_core/core/account.dart';
import 'package:beany_core/parser/parser.dart';
import 'package:beany_importer/src/simple_categorizer.dart';
import 'package:test/test.dart';

var rules = """
{
    "Expenses:Personal:Groceries": [
        "getir"
    ],
    "Expenses:Gym": [
        "Entrevall"
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

  test("Test2", () {
    var input = """
2023-04-05 * "Paid to GIMNASIOS ENTREVALL SL"
  id: "DIRECT_DEBIT-6089318"
  Assets:Personal:Transferwise  9.00 EUR
""";
    var tr = parse(input).trStatement().val().resolve();

    var categorizer = SimpleCategorizer(rules);
    expect(categorizer.classify(tr), Account("Expenses:Gym"));
  });
}
