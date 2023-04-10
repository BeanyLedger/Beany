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
import 'package:test/test.dart';

import 'package:beany/parser/parser.dart';

void main() {
  group("Statements", () {
    test('Include Parser', () {
      var input = 'include "../path"';
      var include = parse(input).includeStatement().val();

      expect(include.toString(), input);
      expect(include, IncludeStatement('../path'));

      var statements = parse(input).all().val();
      var actual = statements.map((t) => t.toString()).join("\n");
      expect(actual, input);
    });

    test('Option Parser', () {
      var input = 'option "title" "Ed’s Personal Ledger"';
      var option = parse(input).optionStatement().val();

      expect(option.toString(), input);
      expect(option, OptionStatement('title', "Ed’s Personal Ledger"));

      var statements = parse(input).all().val();
      var actual = statements.map((t) => t.toString()).join("\n");
      expect(actual, input);
    });

    test('Comment Parser', () {
      var input = '; Hello\n';
      var comment = parse(input).commentStatement().val();

      expect(comment.value, 'Hello');

      var statements = parse(input).all().val();
      var actual = statements.map((t) => t.toString()).join("\n");
      expect(actual, '; Hello');
    }, skip: true);
  });

  test('Account Parser', () {
    var input = 'Hello:A:B';
    var account = parse(input).account().val();

    expect(account.toString(), input);
    expect(account, Account('Hello:A:B'));
  });

  test('Balance Parser', () {
    var input = "2002-01-15 balance Assets:Personal:Transferwise  98.87 EUR";
    var balance = parse(input).balanceStatement().val();

    expect(balance.toString(), input);
    expect(
      balance,
      BalanceStatement(
        DateTime(2002, 01, 15),
        Account('Assets:Personal:Transferwise'),
        Amount(D("98.87"), "EUR"),
      ),
    );

    var statements = parse(input).all().val();
    var actual = statements.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });

  test('Close Parser', () {
    var input = "2000-11-21 close Expenses:Personal";
    var close = parse(input).closeStatement().val();

    expect(close.toString(), input);
    expect(close,
        CloseStatement(DateTime(2000, 11, 21), Account('Expenses:Personal')));

    var statements = parse(input).all().val();
    var actual = statements.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });

  test('Commodity Parser', () {
    var input = "2000-11-21 commodity INR";
    var c = parse(input).commodityStatement().val();

    expect(c.toString(), input);
    expect(c, CommodityStatement(DateTime(2000, 11, 21), 'INR'));

    var statements = parse(input).all().val();
    var actual = statements.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });

  test('Document Parser', () {
    var input = '2013-11-03 document Assets:Card "/home/joe/apr-2014.pdf"';
    var doc = parse(input).documentStatement().val();

    expect(doc.toString(), input);
    expect(
      doc,
      DocumentStatement(
        DateTime(2013, 11, 03),
        Account('Assets:Card'),
        "/home/joe/apr-2014.pdf",
      ),
    );

    var statements = parse(input).all().val();
    var actual = statements.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });

  test('Event Parser', () {
    var input = '2013-11-03 event "location" "Paris, France"';
    var event = parse(input).eventStatement().val();

    expect(event.toString(), input);
    expect(event,
        EventStatement(DateTime(2013, 11, 03), "location", "Paris, France"));

    var statements = parse(input).all().val();
    var actual = statements.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });

  test('Note Parser', () {
    var input = '2013-11-03 note Assets:CreditCard "Called about fraud."';
    var note = parse(input).noteStatement().val();

    expect(note.toString(), input);
    expect(
      note,
      NoteStatement(
        DateTime(2013, 11, 03),
        Account('Assets:CreditCard'),
        "Called about fraud.",
      ),
    );

    var statements = parse(input).all().val();
    var actual = statements.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });

  test('Open Parser', () {
    var input = "2000-11-21 open Expenses:Personal";
    var open = parse(input).openStatement().val();

    expect(open.toString(), input);
    expect(open,
        OpenStatement(DateTime(2000, 11, 21), Account('Expenses:Personal')));

    var statements = parse(input).all().val();
    var actual = statements.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });

  test('Price Parser', () {
    var input = "2002-01-15 price INR  98.87 EUR";
    var price = parse(input).priceStatement().val();

    expect(price.toString(), input);
    expect(
      price,
      PriceStatement(
        DateTime(2002, 01, 15),
        'INR',
        Amount(D("98.87"), "EUR"),
      ),
    );

    var statements = parse(input).all().val();
    var actual = statements.map((t) => t.toString()).join("\n");
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

    expect(custom.toString(), input);
    expect(
      custom,
      CustomStatement(
        DateTime(2013, 11, 03),
        ["location", "Paris, France"],
      ),
    );

    var statements = parse(input).all().val();
    var actual = statements.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });
}
