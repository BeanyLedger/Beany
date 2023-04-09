import 'package:beany/core/account.dart';
import 'package:beany/core/open.dart';
import 'package:beany/engine/engine.dart';
import 'package:test/test.dart';

void main() {
  test('Include Files', () async {
    var filePath = 'test/testdata/root.beancount';
    var engine = await Engine.loadRootFile(filePath);

    var accountOpen = Open(DateTime(2013, 01, 01), Account('Assets:Work:N26'));
    expect(engine.statements, contains(accountOpen));

    /*
    for (var statement in engine.statements) {
      print(statement);
    }
    */
  });

  test("Accounts", () async {
    var filePath = 'test/testdata/root.beancount';
    var engine = await Engine.loadRootFile(filePath);
    var accounts = engine.accounts;

    var info1 = AccountInfo(
      Account('Assets:Personal:Coinbase'),
      DateTime(2013, 01, 01),
      DateTime(2023, 01, 01),
    );
    expect(accounts, contains(info1));

    var info2 = AccountInfo(
      Account('Assets:Work:N26'),
      DateTime(2013, 01, 01),
      null,
    );
    expect(accounts, contains(info2));
  });
}
