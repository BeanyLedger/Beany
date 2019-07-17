import 'package:gitfinances/gitfinances.dart';
import 'package:test/test.dart';

void main() {
  test('No Transactions', () {
    final parser = Parser();
    expect(parser.parse(""), []);
  });
}
