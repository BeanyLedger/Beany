library ledger;

class Account {
  String value;
}

class Amount {
  double number; // FIXME: Use something with proper precission
  String currency;
}

class Posting {
  Account account;
  Amount amount;
}

class Transaction {
  DateTime date;
  String payee;
  List<String> comments;
  List<Posting> postings;
}

class Parser {
  List<Transaction> parse(String data) {
    var transactions = <Transaction>[];
    return transactions;
  }
}
