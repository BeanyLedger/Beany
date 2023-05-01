import 'package:beany/core/account.dart';
import 'package:beany/core/open_statement.dart';
import 'package:beany/core/statements.dart';
import 'package:beany/engine/ledger.dart';
import 'package:beany/misc/date.dart';
import 'package:test/test.dart';

void main() {
  test('Include Files', () async {
    var filePath = 'test/testdata/root.beancount';
    var engine = await Ledger.loadRootFile(filePath);

    var accountOpen =
        OpenStatement(Date(2013, 01, 01), Account('Assets:Work:N26'));
    expect(engine.statements, contains(accountOpen));

    for (var statement in engine.statements) {
      expect(statement is IncludeStatement, false);
    }
  });

  test("Accounts", () async {
    var filePath = 'test/testdata/root.beancount';
    var engine = await Ledger.loadRootFile(filePath);
    var accounts = engine.accounts;

    var info1 = AccountInfo(
      Account('Assets:Personal:Coinbase'),
      Date(2013, 01, 01),
      Date(2023, 01, 01),
    );
    expect(accounts, contains(info1));

    var info2 = AccountInfo(
      Account('Assets:Work:N26'),
      Date(2013, 01, 01),
      null,
    );
    expect(accounts, contains(info2));
  });
}
