import 'package:gringotts/core/account.dart';
import 'package:test/test.dart';

void main() {
  test('Account Parser', () {
    var input = 'Hello:A:B';
    var account = Account.parser.parse(input).value;

    expect(account.toString(), input);
    expect(account, Account('Hello:A:B'));
  });
}
