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
  final String label;

  Cost(this.number, this.currency, this.date, this.label);
}

class Posting {
  late final Account account;
  late final Amount? amount;
  late final String? comment;

  Posting(this.account, this.amount, {this.comment = null});
  Posting.simple(
    String account,
    String? number,
    String? currency, {
    this.comment = null,
  }) {
    this.account = Account(account);
    if (number != null && currency != null) {
      this.amount = Amount(Decimal.parse(number), currency);
    } else {
      this.amount = null;
    }
  }

  String toString() {
    var p = amount != null
        ? "  " + account.toString() + "  " + amount.toString()
        : "  " + account.toString();
    if (comment != null && comment!.isNotEmpty) {
      return '$p; $comment';
    }
    return p;
  }

  bool operator ==(Object other) =>
      other is Posting &&
      other.account == account &&
      other.amount == amount &&
      comment == other.comment;
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
      return tr.copyWith(
        meta: v[1],
        comments: (v[2] as Token).value,
        postings: (v[3] as Token<List<dynamic>>).value.cast<Posting>(),
      );
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

@visibleForTesting
final postingAccountWithAmmount = (indent &
        Account.parser &
        indent &
        whitespace().star().token() &
        Amount.parser &
        _postingComment.optional() &
        eol)
    .token()
    .map((t) {
  return Posting(t.value[1], t.value[4], comment: t.value[5]);
});

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

@visibleForTesting
final posting = postingAccountOnly | postingAccountWithAmmount;
