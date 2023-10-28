import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/open_statement.dart';
import 'package:beany_core/core/statements.dart';
import 'package:beany_core/core/transaction.dart';
import 'package:beany_core/engine/ledger.dart';
import 'package:beany_core/misc/date.dart';
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
    var accounts = engine.metaData.accounts;

    expect(accounts, contains(Account('Assets:Personal:Coinbase')));
    expect(accounts, contains(Account('Assets:Work:N26')));
  });

  test("Account statements before Transactions", () {
    var input = """
2013-01-01 * "Coinbase" "Coinbase"
  Assets:Personal:Coinbase  1.00 BTC
  Income:Personal:Coinbase

2013-01-01 open Assets:Personal:Coinbase
2013-01-01 open Income:Personal:Coinbase
""";
    var engine = Ledger.loadString(input);
    var statements = engine.statements;
    expect(statements[0], isA<OpenStatement>());
    expect(statements[1], isA<OpenStatement>());
    expect(statements[2], isA<TransactionSpec>());
  });
}
