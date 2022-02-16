import 'package:gringotts/core/account.dart';
import 'package:gringotts/core/document.dart';
import 'package:gringotts/parser.dart';
import 'package:test/test.dart';

void main() {
  test('Document Parser', () {
    var input = '2013-11-03 document Assets:Card "/home/joe/apr-2014.pdf"';
    var doc = Document.parser.parse(input).value;

    expect(doc.toString(), input);
    expect(
      doc,
      Document(
        DateTime(2013, 11, 03),
        Account('Assets:Card'),
        "/home/joe/apr-2014.pdf",
      ),
    );

    var transactions = parser.parse(input).value;
    var actual = transactions.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });
}
