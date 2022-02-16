import 'package:decimal/decimal.dart';
import 'package:petitparser/petitparser.dart';
import 'package:meta/meta.dart';

import 'account.dart';
import 'common.dart';
import 'core.dart';

class Cost {
  final Decimal number;
  final String currency;
  final DateTime date;
  final String? label;

  Cost(this.number, this.currency, this.date, {this.label});

  Cost copyWith({
    Decimal? number,
    String? currency,
    DateTime? date,
    String? lable,
  }) {
    return Cost(
      number ?? this.number,
      currency ?? this.currency,
      date ?? this.date,
      label: label ?? this.label,
    );
  }

  bool operator ==(Object other) {
    if (other is! Cost) return false;

    // print('cost ...');
    // print('number ${number == other.number}');
    // print('currency ${currency == other.currency}');
    // print('date ${date == other.date}');
    // print('label ${label == other.label}');
    return other.number == number &&
        other.currency == currency &&
        date == other.date &&
        label == other.label;
  }
}

class Posting {
  late final Account account;
  late final Amount? amount;
  late final String? comment;
  late final Cost? cost;

  Posting(this.account, this.amount, {this.comment = null, this.cost = null});
  Posting.simple(
    String account,
    String? number,
    String? currency, {
    this.comment = null,
    this.cost = null,
  }) {
    this.account = Account(account);
    if (number != null && currency != null) {
      this.amount = Amount(Decimal.parse(number), currency);
    } else {
      this.amount = null;
    }
  }

  String toString() {
    var sb = StringBuffer();
    sb.write(amount != null
        ? "  " + account.toString() + "  " + amount.toString()
        : "  " + account.toString());
    if (cost != null) {
      sb.write(' @ ');
      sb.write(cost!.number.toStringAsFixed(2));
      sb.write(' ');
      sb.write(cost!.currency);
    }
    if (comment != null && comment!.isNotEmpty) {
      sb.write(' ; ');
      sb.write(comment);
    }
    return sb.toString();
  }

  Posting copyWith({
    Account? account,
    Amount? amount,
    String? comment,
    Cost? cost,
  }) {
    return Posting(account ?? this.account, amount ?? this.amount,
        comment: comment ?? this.comment, cost: cost ?? this.cost);
  }

  bool operator ==(Object other) {
    if (other is! Posting) return false;

    // print(toString());
    // print('account: ${account == other.account}');
    // print('amount: ${amount == other.amount}');
    // print('comment: ${comment == other.comment}');
    // print('cost: ${cost == other.cost}');
    return other.account == account &&
        other.amount == amount &&
        comment == other.comment &&
        cost == other.cost;
  }

  static Parser<Posting> get parser {
    return (postingAccountOnly |
            postingAccountWithAmmount |
            postingWithExplicitPrice)
        .cast();
  }
}

final _postingComment =
    (spaceParser.star().token() & char(';') & any().starLazy(eol).flatten())
        .map((value) {
  var c = value[2] as String;
  return c.trim();
});

final _postingAccountOnly =
    indent & Account.parser & _postingComment.optional() & eol;

@visibleForTesting
final postingAccountOnly = _postingAccountOnly.map((v) {
  return Posting(v[1], null, comment: v[2]);
});

final _postingAccountWithAmmount = indent &
    Account.parser &
    indent &
    whitespace().star().token() &
    Amount.parser &
    _postingComment.optional() &
    eol;

@visibleForTesting
final postingAccountWithAmmount = _postingAccountWithAmmount.map((v) {
  return Posting(v[1], v[4], comment: v[5]);
});

final _postingWithExplicitPrice = indent &
    Account.parser &
    indent &
    whitespace().star().token() &
    Amount.parser &
    whitespace().star().token() &
    char('@') &
    whitespace().star().token() &
    Amount.parser &
    _postingComment.optional() &
    eol;

@visibleForTesting
final postingWithExplicitPrice = _postingWithExplicitPrice.map((v) {
  var ca = v[8] as Amount;
  var cost = Cost(
    ca.number,
    ca.currency,
    DateTime.fromMillisecondsSinceEpoch(0),
  );
  return Posting(v[1], v[4], cost: cost, comment: v[9]);
});
