import 'package:gitfinances/gitfinances.dart';
import 'package:test/test.dart';

void main() {
  test('No Transactions', () {
    final parser = Parser();
    expect(parser.parse(""), []);
  });

  test('Simple Transaction', () {
    var input = """2019-04-14 * Cat Powder
  ; Help
  Expenses:Mystery:CatPowder  1.5 EUR
  Assets:Savings
""";

    var tr = new Transaction();
    tr.date = DateTime(2019, 4, 14);
    tr.flag = TransactionFlag.Okay;
    tr.payee = 'Cat Powder';
    Posting.simple(tr, "Expenses:Mystery:CatPowder", "1.5", "EUR");
    Posting.simple(tr, "Assets:Savings", null, null);
    tr.comments.add("Help");

    final parser = Parser();
    var actual = parser.parse(input);
    expect(actual.length, 1);
    expect(actual[0].toString(), tr.toString());
  });

  test('Multiple Transactions', () {
    var input = """2019-04-14 * Cat Powder
  ; Help
  Expenses:Mystery:CatPowder  1.5 EUR
  Assets:Savings

2019-04-19 ! Dog Powder
  ; Helper
  Expenses:Mystery:DogPowder  2.5 EUR
  Assets:Dogs

""";

    final parser = Parser();
    var transactions = parser.parse(input);
    var actual = transactions.map((t) => t.toString()).join("\n") + "\n";
    expect(actual, input);
  });
}
