import 'package:beany/core/account.dart';
import 'package:beany/core/amount.dart';
import 'package:beany/core/balance_statement.dart';
import 'package:beany/core/close_statement.dart';
import 'package:beany/core/commodity_statement.dart';
import 'package:beany/core/core.dart';
import 'package:beany/core/custom_statement.dart';
import 'package:beany/core/document_statement.dart';
import 'package:beany/core/event_statement.dart';
import 'package:beany/core/note_statement.dart';
import 'package:beany/core/open_statement.dart';
import 'package:beany/core/price_statement.dart';
import 'package:beany/core/statements.dart';
import 'package:beany/misc/date.dart';
import 'package:beany/render/render.dart';
import 'package:test/test.dart';

import 'package:beany/parser/parser.dart';

void main() {
  group("Statements", () {
    test('Include Parser', () {
      var input = 'include "../path"';
      var include = parse(input).includeStatement().val();

      expect(render(include), input);
      expect(include, IncludeStatement('../path'));

      var statements = parse(input).all().val();
      var actual = statements.map((t) => render(t)).join("\n");
      expect(actual, input);
    });

    test('Option Parser', () {
      var input = 'option "title" "Ed’s Personal Ledger"';
      var option = parse(input).optionStatement().val();

      expect(render(option), input);
      expect(option, OptionStatement('title', "Ed’s Personal Ledger"));

      var statements = parse(input).all().val();
      var actual = statements.map((t) => render(t)).join("\n");
      expect(actual, input);
    });

    test('Comment Parser', () {
      var input = '; Hello\n';
      var comment = parse(input).commentStatement().val();

      expect(comment.value, 'Hello');

      var statements = parse(input).all().val();
      var actual = statements.map((t) => render(t)).join("\n");
      expect(actual, '; Hello');
    });
  });

  test('Account Parser', () {
    var input = 'Hello:A:B';
    var account = parse(input).account().val();

    expect(account, Account('Hello:A:B'));
  });

  test('Balance Parser', () {
    var input = "2002-01-15 balance Assets:Personal:Transferwise  98.87 EUR";
    var balance = parse(input).balanceStatement().val();

    expect(render(balance), input);
    expect(
      balance,
      BalanceStatement(
        Date(2002, 01, 15),
        Account('Assets:Personal:Transferwise'),
        Amount(D("98.87"), "EUR"),
      ),
    );

    var statements = parse(input).all().val();
    var actual = statements.map((t) => render(t)).join("\n");
    expect(actual, input);
  });

  test('Close Parser', () {
    var input = "2000-11-21 close Expenses:Personal";
    var close = parse(input).closeStatement().val();

    expect(render(close), input);
    expect(close,
        CloseStatement(Date(2000, 11, 21), Account('Expenses:Personal')));

    var statements = parse(input).all().val();
    var actual = statements.map((t) => render(t)).join("\n");
    expect(actual, input);
  });

  test('Commodity Parser', () {
    var input = "2000-11-21 commodity INR";
    var c = parse(input).commodityStatement().val();

    expect(render(c), input);
    expect(c, CommodityStatement(Date(2000, 11, 21), 'INR'));

    var statements = parse(input).all().val();
    var actual = statements.map((t) => render(t)).join("\n");
    expect(actual, input);
  });

  test('Document Parser', () {
    var input = '2013-11-03 document Assets:Card "/home/joe/apr-2014.pdf"';
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
    var actual = statements.map((t) => render(t)).join("\n");
    expect(actual, input);
  });

  test('Event Parser', () {
    var input = '2013-11-03 event "location" "Paris, France"';
    var event = parse(input).eventStatement().val();

    expect(render(event), input);
    expect(
        event, EventStatement(Date(2013, 11, 03), "location", "Paris, France"));

    var statements = parse(input).all().val();
    var actual = statements.map((t) => render(t)).join("\n");
    expect(actual, input);
  });

  test('Note Parser', () {
    var input = '2013-11-03 note Assets:CreditCard "Called about fraud."';
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
    var actual = statements.map((t) => render(t)).join("\n");
    expect(actual, input);
  });

  test('Open Parser', () {
    var input = "2000-11-21 open Expenses:Personal";
    var open = parse(input).openStatement().val();

    expect(render(open), input);
    expect(
        open, OpenStatement(Date(2000, 11, 21), Account('Expenses:Personal')));

    var statements = parse(input).all().val();
    var actual = statements.map((t) => render(t)).join("\n");
    expect(actual, input);
  });

  test('Price Parser', () {
    var input = "2002-01-15 price INR  98.87 EUR";
    var price = parse(input).priceStatement().val();

    expect(render(price), input);
    expect(
      price,
      PriceStatement(
        Date(2002, 01, 15),
        'INR',
        Amount(D("98.87"), "EUR"),
      ),
    );

    var statements = parse(input).all().val();
    var actual = statements.map((t) => render(t)).join("\n");
    expect(actual, input);
  });

  test('Quoted String', () {
    String p(String str) => parse(str).quoted_string().val();

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

    expect(a("1.23 EUR"), Amount(D("1.23"), "EUR"));
    expect(a("-331.223 EUR"), Amount(D("-331.223"), "EUR"));
    expect(a("155,225.77 INR"), Amount(D("155225.77"), "INR"));
  });

  test("Custom Parser", () {
    var input = '2013-11-03 custom "location" "Paris, France"';
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
    var actual = statements.map((t) => render(t)).join("\n");
    expect(actual, input);
  });
}
