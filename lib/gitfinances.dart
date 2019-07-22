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
        ? "  " + account.toString() + "  " + amount.toString()
        : "  " + account.toString();
  }
}

class TransactionFlag {
  final String value;
  const TransactionFlag(this.value);

  static const TransactionFlag Okay = TransactionFlag('*');
  static const TransactionFlag Warning = TransactionFlag('!');

  bool isValid() => value == '*' || value == '!';
  String toString() => value;
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

    var output = header;
    if (comments.length != 0) {
      output += comments.map((c) => '  ; ' + c).join('\n');
      output += '\n';
    }

    if (postings.length != 0) {
      output += postings.map((p) => p.toString()).join('\n');
      output += '\n';
    }
    return output;
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
  flag() => (char('*') | char('!')).map((f) => TransactionFlag(f));
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

class TransactionCommentDefinition extends GrammarDefinition {
  start() => (indent() & char(';') & any().plus().flatten().trim())
      .end()
      .token()
      .map((t) => t.value[2]);
  indent() => char(' ').times(2).token();
}

class Parser {
  List<Transaction> parse(String data) {
    var transactions = <Transaction>[];

    var trHeader = TransactionHeaderGrammarDefinition().build();
    var posting = PostingGrammarDefinition().build();
    var postingAccountOnly = PostingAccountOnlyGrammarDefinition().build();
    var transactionComment = TransactionCommentDefinition().build();

    Transaction tr;
    print("Here we go");
    LineSplitter.split(data).forEach((line) {
      print("Trying to parse: " + line);
      Result<dynamic> result;

      result = trHeader.parse(line);
      if (result.isSuccess) {
        if (tr != null) {
          transactions.add(tr);
        }
        tr = Transaction();
        tr.date = result.value[0];
        tr.flag = result.value[2];
        tr.payee = result.value[4];
        return;
      }

      result = posting.parse(line);
      if (result.isSuccess) {
        var posting = result.value as Posting;
        tr.postings.add(posting);
        return;
      }

      result = postingAccountOnly.parse(line);
      if (result.isSuccess) {
        var posting = result.value as Posting;
        tr.postings.add(posting);
        return;
      }

      result = transactionComment.parse(line);
      if (result.isSuccess) {
        tr.comments.add(result.value as String);
        return;
      }
    });

    if (tr != null) {
      transactions.add(tr);
    }
    return transactions;
  }
}
