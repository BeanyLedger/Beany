import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
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
}

class TransactionFlag {
  final String value;
  const TransactionFlag(this.value);

  static const TransactionFlag Okay = TransactionFlag('*');
  static const TransactionFlag Warning = TransactionFlag('!');

  bool isValid() => value == '*' || value == '!';
  String toString() => value;

  bool operator ==(Object other) =>
      other is TransactionFlag && other.value == value;

  static Parser<TransactionFlag> get parser {
    return (char('*') | char('!'))
        .map((f) => TransactionFlag(f))
        .labeled('Flag');
  }
}

class Transaction implements Directive {
  final DateTime date;
  final IMap<String, dynamic> meta;

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
    Map<String, dynamic>? meta,
  })  : tags = IList(tags),
        comments = IList(comments),
        postings = IList(postings),
        meta = IMap(meta);

  Transaction copyWith({
    Iterable<String>? comments,
    Iterable<Posting>? postings,
    Iterable<String>? tags,
    Map<String, dynamic>? meta,
  }) {
    return Transaction(
      date,
      flag,
      narration,
      payee: payee,
      tags: IList.orNull(tags) ?? this.tags,
      comments: IList.orNull(comments) ?? this.comments,
      postings: IList.orNull(postings) ?? this.postings,
      meta: meta ?? this.meta.unlockView,
    );
  }

  @override
  String toString() {
    var sb = StringBuffer();
    sb.write(date.toIso8601String().substring(0, 10));
    sb.write(' $flag ');
    sb.write('"$narration"');
    if (payee.isNotEmpty) {
      sb.write(' "$payee"');
    }
    if (tags.isNotEmpty) {
      sb.write(' ');
      sb.write(tags.map((t) => '#$t').join(' '));
    }
    sb.writeln();

    if (meta.isNotEmpty) {
      for (var m in meta.entries) {
        sb.writeln('  ${m.key}: "${m.value}"');
      }
    }

    if (comments.isNotEmpty) {
      var s = comments.map((c) => '  ; ' + c).join('\n');
      sb.writeln(s);
    }

    if (postings.isNotEmpty) {
      var s = postings.map((p) => p.toString()).join('\n');
      sb.writeln(s);
    }
    return sb.toString();
  }

  @override
  bool operator ==(Object t) {
    if (t is! Transaction) return false;
    // print('date: ${date == t.date}');
    // print('meta: ${meta == t.meta}');
    // print('narration: ${narration == t.narration}');
    // print('payee: ${payee == t.payee}');
    // print('flag: ${flag == t.flag}');
    // print('comments: ${comments == t.comments}');
    // print('postings: ${postings == t.postings}');
    // print('tags: ${tags == t.tags}');
    return date == t.date &&
        meta == t.meta &&
        narration == t.narration &&
        payee == t.payee &&
        flag == t.flag &&
        comments == t.comments &&
        postings == t.postings &&
        tags == t.tags;
  }

  static Parser<Transaction> get parser {
    var p = trHeaderParser &
        trMetaData &
        trComment.star().token() &
        posting.plus().token();

    return p.token().map((t) {
      var v = t.value;
      var tr = v[0] as Transaction;
      tr = tr.copyWith(
        meta: v[1],
        comments: (v[2] as Token).value,
        postings: (v[3] as Token<List<dynamic>>).value.cast<Posting>(),
      );

      return tr.copyWith(postings: tr.postings.map((p) {
        if (p.cost == null) return p;
        if (p.cost!.date.millisecondsSinceEpoch == 0) {
          p = p.copyWith(cost: p.cost!.copyWith(date: tr.date));
        }
        return p;
      }));
    });
  }
}

final _tag = (char('#') & (word() | char('-')).star().flatten())
    .map((v) => v[1] as String);

final _trHeader = (dateParser &
    spaceParser &
    TransactionFlag.parser &
    spaceParser &
    quotedStringParser &
    (spaceParser & quotedStringParser).optional().map((v) => v?[1] ?? "") &
    (spaceParser.star() & _tag & spaceParser.star()).star().token() &
    eol);

final trHeaderParser = _trHeader.token().map((token) {
  var v = token.value;
  var tagsToken = v[6] as Token<List<List<dynamic>>>;
  var tags = <String>{};
  for (var tagGroup in tagsToken.value) {
    var t = tagGroup[1] as String;
    tags.add(t);
  }
  return Transaction(v[0], v[2], v[4], payee: v[5], tags: tags);
});

@visibleForTesting
final postingAccountOnly =
    (indent & Account.parser & _postingComment.optional() & eol)
        .token()
        .map((t) {
  return Posting(t.value[1], null, comment: t.value[2]);
});

final _postingComment =
    (spaceParser.star().token() & char(';') & any().starLazy(eol).flatten())
        .map((value) {
  var c = value[2] as String;
  return c.trim();
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

@visibleForTesting
final posting =
    postingAccountOnly | postingAccountWithAmmount | postingWithExplicitPrice;

@visibleForTesting
final trComment = (indent & char(';') & any().starLazy(eol).flatten() & eol)
    .token()
    .map((t) => (t.value[2] as String).trim())
    .cast<String>()
    .labeled('Comment');

final _trMetaDataLine = indent &
    word().star().flatten() &
    char(':') &
    spaceParser.star() &
    quotedStringParser &
    eol;

final trMetaDataLine = _trMetaDataLine.map((v) => <String>[v[1], v[4]]);
final trMetaData = trMetaDataLine.star().map((v) {
  var map = <String, dynamic>{};
  for (var m in v) {
    map[m[0]] = m[1];
  }
  return map;
});
