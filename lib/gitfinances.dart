library ledger;

import 'dart:convert';

class Account {
  String value;
  Account(this.value);
}

class Amount {
  double number; // FIXME: Use something with proper precission
  String currency;

  Amount(this.number, this.currency);
}

class Posting {
  Account account;
  Amount amount;

  Posting.Simple(
    Transaction tr,
    String account,
    String number,
    String currency,
  ) {
    this.account = Account(account);
    if (number != null) {
      this.amount = Amount(double.parse(number), currency);
    }
    if (tr != null) {
      tr.postings.add(this);
    }
  }
}

enum TransactionFlag {
  OKAY,
  WARNING,
}

class Transaction {
  DateTime date;
  String payee;
  TransactionFlag flag;
  List<String> comments = [];
  List<Posting> postings = [];
}

class Parser {
  List<Transaction> parse(String data) {
    var transactions = <Transaction>[];

    var PAT_TRANSACTION = RegExp(r'(\d{4,}.+(?:\n[^\S\n\r]{1,}.+)+)');
    var PAT_TRANSACTION_DATA = RegExp(
        r'(?P<year>\d{4})[/|-](?P<month>\d{2})[/|-](?P<day>\d{2})(?:=(?P<year_aux>\d{4})[/|-](?P<month_aux>\d{2})[/|-](?P<day_aux>\d{2}))? (?P<state>[\*|!])?[ ]?(\((?P<code>[^\)].+)\) )?(?P<payee>.+)');
    var PAT_COMMENT = RegExp(r'[^\S\n\r]{1,};(.+)');

    var PAT_POSTING = RegExp(
        r'\s{2}(?P<account>[\w:]+)\s{2,}(?P<units>[+-]?[\d.]+)\s(?P<commodity>[\w\"]+)$');
    var PAT_ACCOUNT_TOTAL_COST = RegExp(
        r'\s{2}(?P<account>[\w:]+)\s{2,}(?P<units>[+-]?[\d.]+)\s(?P<commodity>[\w\"]+)\s@@\s(?P<cost_total_units>[+-]?[\d.]+)\s(?P<cost_commodity>[\w\"]+)$');
    var PAT_ACCOUNT_PER_COST = RegExp(
        r'\s{2}(?P<account>[\w:]+)\s{2,}(?P<units>[+-]?[\d.]+)\s(?P<commodity>[\w\"]+)\s@\s(?P<cost_units>[+-]?[\d.]+)\s(?P<cost_commodity>[\w\"]+)$');
    var PAT_ACCOUNT_ONLY = RegExp(r'[\s]{2}(?P<account>[\w:]+)$');

    Transaction tr;
    LineSplitter.split(data).forEach((line) {
      var match = PAT_TRANSACTION_DATA.firstMatch(line);
      if (match != null) {
        tr = Transaction();
        tr.date = DateTime(
          int.parse(match.namedGroup("year")),
          int.parse(match.namedGroup("month")),
          int.parse(match.namedGroup("day")),
        );

        var state = match.namedGroup("state");
        switch (state) {
          case "*":
            tr.flag = TransactionFlag.OKAY;
            break;
          case "!":
            tr.flag = TransactionFlag.WARNING;
            break;
        }

        tr.payee = match.namedGroup("payee");
        return;
      }

      match = PAT_COMMENT.firstMatch(line);
      if (match != null) {
        tr.comments.add(match.group(1));
        return;
      }

      match = PAT_POSTING.firstMatch(line);
      if (match != null) {
        Posting.Simple(
          tr,
          match.namedGroup('account'),
          match.namedGroup('units'),
          match.namedGroup('commodity'),
        );
        return;
      }

      match = PAT_ACCOUNT_ONLY.firstMatch(line);
      if (match != null) {
        Posting.Simple(tr, match.namedGroup('account'), null, null);
        return;
      }
    });
    return transactions;
  }
}
