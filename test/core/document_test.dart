import 'package:test/test.dart';

import 'package:beany/core/account.dart';
import 'package:beany/core/document.dart';
import 'package:beany/parser/parser.dart';

void main() {
  test('Document Parser', () {
    var input = '2013-11-03 document Assets:Card "/home/joe/apr-2014.pdf"';
    var doc = parse(input).documentStatement().val();

    expect(doc.toString(), input);
    expect(
      doc,
      Document(
        DateTime(2013, 11, 03),
        Account('Assets:Card'),
        "/home/joe/apr-2014.pdf",
      ),
    );

    var transactions = parse(input).all().val();
    var actual = transactions.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });
}
