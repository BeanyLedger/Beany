import 'package:gringotts/core/account.dart';
import 'package:gringotts/parser/parser.dart';
import 'package:test/test.dart';

void main() {
  test('Account Parser', () {
    var input = 'Hello:A:B';
    var account = parse(input).account().val();

    expect(account.toString(), input);
    expect(account, Account('Hello:A:B'));
  });
}
