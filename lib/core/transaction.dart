import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:gringotts/core/posting.dart';
import 'core.dart';

class TransactionFlag {
  final String value;
  const TransactionFlag(this.value);

  static const TransactionFlag Okay = TransactionFlag('*');
  static const TransactionFlag Warning = TransactionFlag('!');

  bool isValid() => value == '*' || value == '!';
  String toString() => value;

  bool operator ==(Object other) =>
      other is TransactionFlag && other.value == value;
}

class Transaction implements Directive {
  final DateTime date;
  final IMap<String, dynamic> meta;

  final String narration;
  final String? payee;
  final TransactionFlag flag;

  final IList<String> comments;
  final IList<Posting> postings;
  final IList<String> tags;

  Transaction(
    this.date,
    this.flag,
    this.narration, {
    this.payee,
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
    if (payee != null) {
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
}

// FIXME: Transaction MetaData
