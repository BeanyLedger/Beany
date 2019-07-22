library ledger;

import 'dart:convert';

import 'package:petitparser/petitparser.dart';

class Account {
  String value;
  Account(this.value);

  String toString() {
    return value;
  }
}

class Amount {
  double number; // FIXME: Use something with proper precission
  String currency;

  Amount(this.number, this.currency);

  String toString() {
    return number.toString() + ' ' + currency;
  }
}

class Posting {
  Account account;
  Amount amount;

  Posting(this.account, this.amount);
  Posting.simple(
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

  String toString() {
    return amount != null
        ? account.toString() + ' ' + amount.toString()
        : account.toString();
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

  String toString() {
    var d = date.toIso8601String().substring(0, 10);
    var header = d + ' ' + flag.toString() + ' ' + payee + '\n';
    return header + postings.map((p) => p.toString()).join('\n');
  }
}

class DateGrammarDefinition extends GrammarDefinition {
  const DateGrammarDefinition();

  start() => date().token().map((t) {
        var val = t.value as List<dynamic>;
        return DateTime(val[0], val[2], val[4]);
      });

  date() =>
      digit().times(4).flatten().map(int.parse) &
      char('-').map((t) => ' ').trim() &
      digit().times(2).flatten().map(int.parse) &
      char('-').map((t) => ' ').trim() &
      digit().times(2).flatten().map(int.parse);
}

class DateParser extends GrammarParser {
  DateParser() : super(const DateGrammarDefinition());
}

class TransactionHeaderGrammarDefinition extends GrammarDefinition {
  start() => (DateParser() & space() & flag() & space() & payee()).end();
  flag() => char('*') | char('!');
  payee() => any().plus().flatten();
  space() => char(' ');
}

class AccountGrammarDefinition extends GrammarDefinition {
  const AccountGrammarDefinition();

  start() => (component().separatedBy(sep())).flatten().map((a) => Account(a));
  component() => word().plus();
  sep() => char(':');
}

class AccountParser extends GrammarParser {
  AccountParser() : super(const AccountGrammarDefinition());
}

class PostingAccountOnlyGrammarDefinition extends GrammarDefinition {
  start() => ((indent() & AccountParser()).end())
      .token()
      .map((t) => Posting(t.value[1] as Account, null));
  indent() => char(' ').times(2).token();
}

class PostingGrammarDefinition extends GrammarDefinition {
  start() => (indent() & AccountParser() & indent() & amount())
      .end()
      .token()
      .map((t) => Posting(t.value[1], t.value[3]));
  amount() => (number() & char(' ') & currency())
      .token()
      .map((t) => Amount(double.parse(t.value[0]), t.value[2] as String));
  number() => digit().separatedBy(decimal()).flatten();
  currency() => word().plus().flatten();
  decimal() => char('.');
  indent() => char(' ').times(2).token();
}

/*
class TransactionGrammarDefinition extends GrammarDefinition {
  newline() => char('\n') | (char('\r') & char('\r\n'));
  header() => TransactionHeaderGrammarDefinition().build();
  comment() => (indent() & char(';') & any().plus().flatten().trim())
      .token()
      .map((t) => t.value[2] as String);
  indent() => char(' ').times(2).token();

  start() => header() & newline() &
}
*/

class Parser {
  List<Transaction> parse(String data) {
    var transactions = <Transaction>[];

    var tr_header = TransactionHeaderGrammarDefinition().build();
    var posting = PostingGrammarDefinition().build();
    var posting_account_only = PostingAccountOnlyGrammarDefinition().build();

    Transaction tr;
    print("Here we go");
    LineSplitter.split(data).forEach((line) {
      print("Trying to parse: " + line);
      Result<dynamic> result;

      result = tr_header.parse(line);
      if (result.isSuccess) {
        print("tr_header: " + result.value.toString());

        if (tr != null) {
          transactions.add(tr);
        }
        tr = Transaction();
        tr.date = result.value[0];

        var state = result.value[2];
        switch (state) {
          case "*":
            tr.flag = TransactionFlag.OKAY;
            break;
          case "!":
            tr.flag = TransactionFlag.WARNING;
            break;
        }

        tr.payee = result.value[4];
        return;
      }

      result = posting.parse(line);
      if (result.isSuccess) {
        print("posting: " + result.value.toString());

        var posting = result.value as Posting;
        tr.postings.add(posting);
        return;
      }

      result = posting_account_only.parse(line);
      if (result.isSuccess) {
        print("posting_account_only: " + result.value.toString());

        var posting = result.value as Posting;
        tr.postings.add(posting);
        return;
      }

      /*

      match = PAT_COMMENT.firstMatch(line);
      if (match != null) {
        tr.comments.add(match.group(1));
        return;
      }
      */
    });

    if (tr != null) {
      transactions.add(tr);
    }
    return transactions;
  }
}
