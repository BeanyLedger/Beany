import 'package:beany/core/core.dart';
import 'package:beany/core/posting.dart';
import 'package:beany/parser/parser.dart';
import 'package:test/test.dart';

void main() {
  test("Weights", () {
    String text;
    Posting p;

    text = "Assets:A  10.00 USD";
    p = parse(text).postingSpec().val().toPosting();
    expect(p.weight(), AMT("10 USD"));

    text = "Assets:A  -10.00 CAD @ 1.01 USD";
    p = parse(text).postingSpec().val().toPosting();
    expect(p.weight(), AMT("-10.10 USD"));

    text = "Assets:A  -10.00 CAD @@ 31.01 USD";
    p = parse(text).postingSpec().val().toPosting();
    expect(p.weight(), AMT("-31.01 USD"));

    text = "Assets:A  10 SOME {2.02 USD}";
    p = parse(text).postingSpec().val().toPosting();
    expect(p.weight(), AMT("20.20 USD"));

    /*
    text = "Assets:A  10 SOME {2.02 USD} @ 2.50 USD";
    p = parse(text).postingSpec().val().toPosting();
    expect(p.weight(), AMT("20.20 USD"));
    */
  });
}
