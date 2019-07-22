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
