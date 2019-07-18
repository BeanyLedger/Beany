import 'package:gitfinances/gitfinances.dart';
import 'package:test/test.dart';

void main() {
  test('No Transactions', () {
    final parser = Parser();
    expect(parser.parse(""), []);
  });

  test('Simple Transaction', () {
    var input = """2019-04-14 * Cat Powder
  Expenses:Mystery:CatPowder  1.5 EUR
  Assets:Savings
""";

    var tr = new Transaction();
    Posting.Simple(tr, "Expenses:Mystery:CatPowder", "1.5", "EUR");
    Posting.Simple(tr, "Assets:Savings", null, null);

    final parser = Parser();
    expect(parser.parse(input), [tr]);
  });
}
