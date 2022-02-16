import 'package:gringotts/core/core.dart';
import 'package:gringotts/core/document.dart';
import 'package:gringotts/parser.dart';
import 'package:test/test.dart';

void main() {
  test('Document Parser', () {
    expect(
      documentParser
          .parse('2013-11-03 document Assets:Card "/home/joe/apr-2014.pdf"\n')
          .value,
      Document(
        DateTime(2013, 11, 03),
        Account('Assets:Card'),
        "/home/joe/apr-2014.pdf",
      ),
    );
  });
}
