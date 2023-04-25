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
class TransactionSpec extends Equatable implements Directive {
  final DateTime date;
  final IMap<String, MetaValue> meta;

  final String narration;
  final String? payee;
  final TransactionFlag flag;

  final IList<String> comments;
  final IList<PostingSpec> postings;
  final IList<String> tags;

  final ParsingInfo? parsingInfo;

  TransactionSpec(
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

  TransactionSpec copyWith({
    Iterable<String>? comments,
    Iterable<PostingSpec>? postings,
    Iterable<String>? tags,
    Map<String, MetaValue>? meta,
    ParsingInfo? parsingInfo,
  }) {
    return TransactionSpec(
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
  List<Object?> get props => [
        date,
        meta,
        narration,
        payee,
        flag,
        comments,
        postings,
        tags,
      ];

  Transaction resolve() {
    return Transaction(
      date,
      flag,
      narration,
      payee: payee,
      tags: tags,
      comments: comments,
      postings: resolvedPostings(postings),
      meta: meta.unlockView,
      parsingInfo: parsingInfo,
    );
  }
}

class Transaction extends Equatable implements TransactionSpec {
  final DateTime date;
  final IMap<String, MetaValue> meta;

  final String narration;
  final String? payee;
  final TransactionFlag flag;

  final IList<String> comments;
  final IList<Posting> postings;
  final IList<String> tags;

  final ParsingInfo? parsingInfo;

  Transaction(
    this.date,
    this.flag,
    this.narration, {
    this.payee,
    Iterable<String>? tags,
    Iterable<String>? comments,
    Iterable<Posting>? postings,
    Map<String, MetaValue>? meta,
    this.parsingInfo,
  })  : tags = IList(tags),
        comments = IList(comments),
        postings = IList(postings),
        meta = IMap(meta);

  @override
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
      postings:
          IList.orNull(postings?.map((p) => p.toPosting())) ?? this.postings,
      meta: meta ?? this.meta.unlockView,
      parsingInfo: parsingInfo ?? this.parsingInfo,
    );
  }

  @override
  List<Object?> get props => [
        date,
        meta,
        narration,
        payee,
        flag,
        comments,
        postings,
        tags,
      ];

  @override
  Transaction resolve() => this;
}

IList<Posting> resolvedPostings(IList<PostingSpec> postings) {
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
        throw new Exception('Cannot resolve transaction with unspecified '
            'currency');
      }
      pTotal = Amount(num.abs(), pTotal.currency!);
      priceSpec = priceSpec.copyWith(amountTotal: pTotal);
      unresolved = unresolved.copyWith(priceSpec: priceSpec);
    } else if (priceSpec.amountPer != null) {
      var pPer = priceSpec.amountPer!;
      var per = (num.abs() / unresolved.amount!.number).toDecimal(
          scaleOnInfinitePrecision: 10); // FIXME: What about the precision?
      if (pPer.currency == null) {
        throw new Exception('Cannot resolve transaction with unspecified '
            'currency');
      }
      pPer = Amount(per, pPer.currency!);
      priceSpec = priceSpec.copyWith(amountPer: pPer);
      unresolved = unresolved.copyWith(priceSpec: priceSpec);
    }
  }

  return IList(postings
      .replace(unresolvedIndex, unresolved)
      .map((ps) => ps.toPosting()));
}
