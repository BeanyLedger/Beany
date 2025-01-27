import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/amount.dart';
import 'package:beany_core/core/balance_statement.dart';
import 'package:beany_core/core/close_statement.dart';
import 'package:beany_core/core/commodity_statement.dart';
import 'package:beany_core/core/core.dart';
import 'package:beany_core/core/custom_statement.dart';
import 'package:beany_core/core/document_statement.dart';
import 'package:beany_core/core/event_statement.dart';
import 'package:beany_core/core/meta_value.dart';
import 'package:beany_core/core/note_statement.dart';
import 'package:beany_core/core/open_statement.dart';
import 'package:beany_core/core/price_statement.dart';
import 'package:beany_core/core/query_statement.dart';
import 'package:beany_core/core/statements.dart';
import 'package:beany_core/misc/date.dart';
import 'package:beany_core/render/render.dart';
import 'package:test/test.dart';

import 'package:beany_core/parser/parser.dart';

void main() {
  group("Statements", () {
    test('Include Parser', () {
      var input = 'include "../path"';
      var include = parse(input).includeStatement().val();

      expect(render(include).trim(), input);
      expect(include, IncludeStatement('../path'));

      var statements = parse(input).all().val();
      var actual = statements.map((t) => render(t)).join();
      expect(actual.trim(), input);
    });

    test('Option Parser', () {
      var input = 'option "title" "Ed’s Personal Ledger"';
      var option = parse(input).optionStatement().val();

      expect(render(option).trim(), input);
      expect(option, OptionStatement('title', "Ed’s Personal Ledger"));

      var statements = parse(input).all().val();
      var actual = statements.map((t) => render(t)).join();
      expect(actual.trim(), input);
    });

    test('Comment Parser', () {
      var input = '; Hello\n';
      var comment = parse(input).commentStatement().val();

      expect(comment.value, 'Hello');

      var statements = parse(input).all().val();
      var actual = statements.map((t) => render(t)).join();
      expect(actual.trim(), '; Hello');
    });

    test('Plugin Parser - Without value', () {
      var input = 'plugin "title"';
      var plugin = parse(input).pluginStatement().val();

      expect(plugin.name, 'title');
      expect(plugin.value, null);

      var statements = parse(input).all().val();
      var actual = statements.map((t) => render(t)).join();
      expect(actual.trim(), 'plugin "title"');
    });

    test('Plugin Parser - With Value', () {
      var input = 'plugin "title" "val"';
      var plugin = parse(input).pluginStatement().val();

      expect(plugin.name, 'title');
      expect(plugin.value, 'val');

      var statements = parse(input).all().val();
      var actual = statements.map((t) => render(t)).join();
      expect(actual.trim(), 'plugin "title" "val"');
    });
  });

  test('Account Parser', () {
    var input = 'Hello:A:B';
    var account = parse(input).account().val();

    expect(account, Account('Hello:A:B'));
  });

  test('Balance Parser', () {
    var input =
        "2002-01-15 balance Assets:Personal:Transferwise  98.87 EUR ; ploop\n  key: \"food\"\n";
    var balance = parse(input).balanceStatement().val();

    expect(render(balance).trim(), input.trim());
    expect(
      balance,
      BalanceStatement(
        Date(2002, 01, 15),
        Account('Assets:Personal:Transferwise'),
        Amount(D("98.87"), CUR("EUR")),
        meta: {"key": MetaValue(stringValue: "food")},
      ),
    );

    var statements = parse(input).all().val();
    var actual = statements.map((t) => render(t)).join();
    expect(actual.trim(), input.trim());
  });

  test('Close Parser', () {
    var input = "2000-11-21 close Expenses:Personal\n";
    var close = parse(input).closeStatement().val();

    expect(render(close), input);
    expect(close,
        CloseStatement(Date(2000, 11, 21), Account('Expenses:Personal')));

    var statements = parse(input).all().val();
    var actual = statements.map((t) => render(t)).join();
    expect(actual, input);
  });

  test('Commodity Parser', () {
    var input = "2000-11-21 commodity INR\n";
    var c = parse(input).commodityStatement().val();

    expect(render(c), input);
    expect(c, CommodityStatement(Date(2000, 11, 21), CUR('INR')));

    var statements = parse(input).all().val();
    var actual = statements.map((t) => render(t)).join();
    expect(actual, input);
  });

  test('Document Parser', () {
    var input = '2013-11-03 document Assets:Card "/home/joe/apr-2014.pdf"\n';
    var doc = parse(input).documentStatement().val();

    expect(render(doc), input);
    expect(
      doc,
      DocumentStatement(
        Date(2013, 11, 03),
        Account('Assets:Card'),
        "/home/joe/apr-2014.pdf",
      ),
    );

    var statements = parse(input).all().val();
    var actual = statements.map((t) => render(t)).join();
    expect(actual, input);
  });

  test('Event Parser', () {
    var input = '2013-11-03 event "location" "Paris, France"\n';
    var event = parse(input).eventStatement().val();

    expect(render(event), input);
    expect(
        event, EventStatement(Date(2013, 11, 03), "location", "Paris, France"));

    var statements = parse(input).all().val();
    var actual = statements.map((t) => render(t)).join();
    expect(actual, input);
  });

  test('Note Parser', () {
    var input = '2013-11-03 note Assets:CreditCard "Called about fraud."\n';
    var note = parse(input).noteStatement().val();

    expect(render(note), input);
    expect(
      note,
      NoteStatement(
        Date(2013, 11, 03),
        Account('Assets:CreditCard'),
        "Called about fraud.",
      ),
    );

    var statements = parse(input).all().val();
    var actual = statements.map((t) => render(t)).join();
    expect(actual, input);
  });

  test('Open Parser', () {
    var input = "2000-11-21 open Expenses:Personal\n";
    var open = parse(input).openStatement().val();

    expect(render(open), input);
    expect(
        open, OpenStatement(Date(2000, 11, 21), Account('Expenses:Personal')));

    var statements = parse(input).all().val();
    var actual = statements.map((t) => render(t)).join();
    expect(actual, input);
  });

  test('Price Parser', () {
    var input = "2002-01-15 price INR  98.87 EUR\n";
    var price = parse(input).priceStatement().val();

    expect(render(price), input);
    expect(
      price,
      PriceStatement(
        Date(2002, 01, 15),
        CUR('INR'),
        Amount(D("98.87"), CUR("EUR")),
      ),
    );

    var statements = parse(input).all().val();
    var actual = statements.map((t) => render(t)).join();
    expect(actual, input);
  });

  test('Query Parser', () {
    var sql = "SELECT account, sum(position) WHERE ‘trip-france-2014’ in tags";
    var input = '2014-07-09 query "france-balances" "$sql"\n';
    var price = parse(input).queryStatement().val();

    expect(render(price), input);
    expect(
      price,
      QueryStatement(
        Date(2014, 07, 09),
        'france-balances',
        sql,
      ),
    );

    var statements = parse(input).all().val();
    var actual = statements.map((t) => render(t)).join();
    expect(actual, input);
  });

  test('String', () {
    String p(String str) => parse(str).string().val();

    expect(p('"Hello"'), "Hello");
    expect(p('"Hello/World"'), "Hello/World");
    expect(p('"foo"'), "foo");
    expect(p('""'), "");
    expect(p('"Róú\'s brithday"'), "Róú's brithday");

    // expect(p('"').isFailure, true);
    // expect(p('"dafsdf\nsafasdf"').isFailure, true);
  });

  test('Tags', () {
    List<String> t(String str) => parse(str).tags().val().toList();

    expect(t('#hello #berlin-2014'), ["hello", "berlin-2014"]);
    expect(t('#bérlin-2014'), ["bérlin-2014"]);
  });

  test("Amounts", () {
    Amount a(String str) => parse(str).amount().val();

    expect(a("1.23 EUR"), Amount(D("1.23"), CUR("EUR")));
    expect(a("-331.223 EUR"), Amount(D("-331.223"), CUR("EUR")));
    expect(a("155,225.77 INR"), Amount(D("155225.77"), CUR("INR")));
  });

  test("Custom Parser", () {
    var input = '2013-11-03 custom "location" "Paris, France"\n';
    var custom = parse(input).customStatement().val();

    expect(render(custom), input);
    expect(
      custom,
      CustomStatement(
        Date(2013, 11, 03),
        ["location", "Paris, France"],
      ),
    );

    var statements = parse(input).all().val();
    var actual = statements.map((t) => render(t)).join();
    expect(actual, input);
  });

  test("Statements without newlines", () {
    var input = """
2021-01-21 * "Converted 1.00 GBP to 1.12 EUR"
  id: "BALANCE-161399170"
  Expenses:Personal:BankCharges:Transferwise  0.00 EUR @@ 2.3841776 EUR
  Assets:Personal:Transferwise                1.12 EUR @ 1.12873 EUR
  Assets:Personal:Transferwise                1.12 EUR
2023-04-05 balance Assets:Personal:Transferwise  26879.19 EUR
2002-01-15 price INR  98.87 EUR
""";

    var statements = parse(input).all().val();
    var actual = statements.map((t) => render(t)).join() + "\n";
    expect(actual.trim(), input.trim());
  });
}
