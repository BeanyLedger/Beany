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
    tr.flag = TransactionFlag.OKAY;
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

    var tr1 = new Transaction();
    tr1.date = DateTime(2019, 4, 14);
    tr1.flag = TransactionFlag.OKAY;
    tr1.payee = 'Cat Powder';
    Posting.simple(tr1, "Expenses:Mystery:CatPowder", "1.5", "EUR");
    Posting.simple(tr1, "Assets:Savings", null, null);
    tr1.comments.add("Help");

    var tr2 = new Transaction();
    tr2.date = DateTime(2019, 4, 19);
    tr2.flag = TransactionFlag.WARNING;
    tr2.payee = 'Dog Powder';
    Posting.simple(tr2, "Expenses:Mystery:DogPowder", "2.5", "EUR");
    Posting.simple(tr2, "Assets:Dogs", null, null);
    tr2.comments.add("Helper");

    final parser = Parser();
    var actual = parser.parse(input);
    expect(actual.length, 2);
    expect(actual.toString(), [tr1, tr2].toString());
  });
}
