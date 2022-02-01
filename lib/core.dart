import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

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
  late final Account account;
  late final Amount? amount;

  Posting(this.account, this.amount);
  Posting.simple(
    String account,
    String? number,
    String? currency,
  ) {
    this.account = Account(account);
    if (number != null && currency != null) {
      this.amount = Amount(Decimal.parse(number), currency);
    } else {
      this.amount = null;
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
  final String narration;
  final String payee;
  final TransactionFlag flag;

  final IList<String> comments;
  final IList<Posting> postings;
  final IList<String> tags;

  Transaction(
    this.date,
    this.flag,
    this.narration, {
    this.payee = "",
    Iterable<String>? tags,
    Iterable<String>? comments,
    Iterable<Posting>? postings,
  })  : tags = IList(tags),
        comments = IList(comments),
        postings = IList(postings);

  Transaction copyWith({
    Iterable<String>? comments,
    Iterable<Posting>? postings,
    Iterable<String>? tags,
  }) {
    return Transaction(
      date,
      flag,
      narration,
      payee: payee,
      tags: IList.orNull(tags) ?? this.tags,
      comments: IList.orNull(comments) ?? this.comments,
      postings: IList.orNull(postings) ?? this.postings,
    );
  }

  String toString() {
    var sb = StringBuffer();
    sb.write(date.toIso8601String().substring(0, 10));
    sb.write(' $flag ');
    sb.write('"$narration"');
    if (payee.isNotEmpty) {
      sb.write(' "$payee"');
    }
    sb.writeln();

    if (comments.length != 0) {
      var s = comments.map((c) => '  ; ' + c).join('\n');
      sb.writeln(s);
    }

    if (postings.length != 0) {
      var s = postings.map((p) => p.toString()).join('\n');
      sb.writeln(s);
    }
    return sb.toString();
  }

  @override
  bool operator ==(Object t) {
    if (t is! Transaction) return false;
    return toString() == t.toString();
  }
}
