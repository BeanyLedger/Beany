import 'package:decimal/decimal.dart';

class Account {
  final String value;
  Account(this.value);

  String toString() {
    return value;
  }

  @override
  bool operator ==(Object t) => t is Account && t.value == value;
}

class Amount {
  final Decimal number;
  final String currency;

  Amount(this.number, this.currency);

  String toString() {
    return number.toString() + ' ' + currency;
  }

  bool operator ==(Object other) =>
      other is Amount && other.number == number && other.currency == currency;
}

class Cost {
  final Decimal number;
  final String currency;
  final DateTime date;
  final String label;

  Cost(this.number, this.currency, this.date, this.label);
}

class Posting {
  late Account account;
  Amount? amount;

  Posting(this.account, this.amount);
  Posting.simple(
    Transaction? tr,
    String account,
    String? number,
    String? currency,
  ) {
    this.account = Account(account);
    if (number != null && currency != null) {
      this.amount = Amount(Decimal.parse(number), currency);
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

  bool operator ==(Object other) =>
      other is Posting && other.account == account && other.amount == amount;
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
  final DateTime date;
  final String payee;
  final TransactionFlag flag;

  List<String> comments = [];
  List<Posting> postings = [];
  List<String> tags = [];

  Transaction(this.date, this.flag, this.payee);

  String toString() {
    var d = date.toIso8601String().substring(0, 10);
    var header = d + ' ' + flag.toString() + ' "' + payee + '"\n';

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

  @override
  bool operator ==(Object t) {
    if (t is! Transaction) return false;
    return toString() == t.toString();
  }
}
