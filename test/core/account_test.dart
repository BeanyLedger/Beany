import 'package:test/test.dart';

import 'package:gringotts/core/account.dart';
import 'package:gringotts/parser/parser.dart';

void main() {
  test('Account Parser', () {
    var input = 'Hello:A:B';
    var account = parse(input).account().val();

    expect(account.toString(), input);
    expect(account, Account('Hello:A:B'));
  });
}
