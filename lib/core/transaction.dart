import 'package:beany/core/amount.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

import 'posting.dart';
import 'core.dart';
import 'meta_value.dart';

enum TransactionFlag {
  Okay('*'),
  Warning('!');

  final String value;
  const TransactionFlag(this.value);

  bool isValid() => value == '*' || value == '!';
  String toString() => value;
}

@immutable
class Transaction extends Equatable implements Directive {
  final DateTime date;
  final IMap<String, MetaValue> meta;

  final String narration;
  final String? payee;
  final TransactionFlag flag;

  final IList<String> comments;
  final IList<PostingSpec> postings;
  final IList<String> tags;

  final ParsingInfo? parsingInfo;

  Transaction(
    this.date,
    this.flag,
    this.narration, {
    this.payee,
    Iterable<String>? tags,
    Iterable<String>? comments,
    Iterable<PostingSpec>? postings,
    Map<String, MetaValue>? meta,
    this.parsingInfo,
  })  : tags = IList(tags),
        comments = IList(comments),
        postings = IList(postings),
        meta = IMap(meta);

  Transaction copyWith({
    Iterable<String>? comments,
    Iterable<PostingSpec>? postings,
    Iterable<String>? tags,
    Map<String, MetaValue>? meta,
    ParsingInfo? parsingInfo,
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
      parsingInfo: parsingInfo ?? this.parsingInfo,
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
        sb.writeln('  ${m.key}: ${m.value}');
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

  IList<Posting> resolvedPostings() {
    var numUnresolved = postings.where((p) => !p.canResolve).length;
    if (numUnresolved > 1) {
      throw Exception('Cannot realize transaction with more than one '
          'unresolved posting');
    }
    if (numUnresolved == 0) {
      return postings.map((p) => p.toPosting()).toIList();
    }

    var currencies = postings.map((p) {
      var priceSpec = p.priceSpec;
      if (priceSpec?.amountTotal != null) {
        return priceSpec!.amountTotal!.currency;
      }
      if (priceSpec?.amountPer != null) {
        return priceSpec!.amountPer!.currency;
      }

      return p.amount?.currency;
    }).whereNotNull();

    if (currencies.toSet().length != 1) {
      throw Exception('Cannot realize transaction with multiple currencies');
    }
    var currency = currencies.first;

    var num = D("0");
    for (var p in postings) {
      if (!p.canResolve) continue;

      num += p.toPosting().weight().number;
    }

    var unresolvedIndex = postings.indexWhere((e) => !e.canResolve);
    var unresolved = postings[unresolvedIndex];
    if (unresolved.amount == null) {
      unresolved = unresolved.copyWith(amount: Amount(-num, currency));
    } else if (unresolved.priceSpec?.canResolve == false) {
      var priceSpec = unresolved.priceSpec!;
      if (priceSpec.amountTotal != null) {
        var pTotal = priceSpec.amountTotal!;
        if (pTotal.currency == null) {
          throw Exception(
              'PriceSpec is missing a currency. Should this be allowed?');
        }

        var currency = pTotal.currency!;
        pTotal = Amount(num.abs(), currency);
        priceSpec = priceSpec.copyWith(amountTotal: pTotal);
        unresolved = unresolved.copyWith(priceSpec: priceSpec);
      } else if (priceSpec.amountPer != null) {
        var pPer = priceSpec.amountPer!;
        if (pPer.currency == null) {
          throw Exception(
              'PriceSpec is missing a currency. Should this be allowed?');
        }

        var currency = pPer.currency!;
        var per = (num.abs() / unresolved.amount!.number).toDecimal(
            scaleOnInfinitePrecision: 10); // FIXME: What about the precision?
        pPer = Amount(per, currency);
        priceSpec = priceSpec.copyWith(amountPer: pPer);
        unresolved = unresolved.copyWith(priceSpec: priceSpec);
      }
    }

    return IList(postings
        .replace(unresolvedIndex, unresolved)
        .map((ps) => ps.toPosting()));
  }

  @override
  List<Object?> get props =>
      [date, meta, narration, payee, flag, comments, postings, tags];
}
