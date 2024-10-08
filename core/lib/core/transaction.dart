import 'package:beany_core/core/amount.dart';
import 'package:beany_core/engine/exceptions.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'posting.dart';
import 'core.dart';
import 'meta_value.dart';

part 'transaction.g.dart';

enum TransactionFlag {
  Okay('*'),
  Warning('!');

  final String value;
  const TransactionFlag(this.value);

  bool isValid() => value == '*' || value == '!';
  String toString() => value;
}

@immutable
@JsonSerializable(includeIfNull: false)
class TransactionSpec extends Equatable implements Directive, Comparable {
  final DateTime date;
  final IMap<String, MetaValue> meta;

  final String narration;
  final String? payee;
  final TransactionFlag flag;

  final IList<PostingSpec> postings;
  final IList<String> tags;
  final IList<String> comments;

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
        postings = IList(postings),
        meta = IMap(meta),
        comments = IList(comments);

  TransactionSpec copyWith({
    covariant Iterable<PostingSpec>? postings,
    Iterable<String>? tags,
    Iterable<String>? comments,
    Map<String, MetaValue>? meta,
    ParsingInfo? parsingInfo,
  }) {
    return TransactionSpec(
      date,
      flag,
      narration,
      payee: payee,
      tags: tags ?? this.tags,
      comments: comments ?? this.comments,
      postings: postings ?? this.postings,
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
        postings,
        tags,
      ];

  @override
  bool get stringify => true;

  Transaction resolve() {
    return Transaction(
      date,
      flag,
      narration,
      payee: payee,
      tags: tags,
      postings: resolvedPostings(this),
      meta: meta.unlockView,
      parsingInfo: parsingInfo,
    );
  }

  bool get canResolve {
    try {
      resolve();
    } on PostingResolutinFailure {
      return false;
    }
    return true;
  }

  TransactionSpec toSpec() => this;

  @override
  int compareTo(other) {
    return date.compareTo(other.date);
  }

  factory TransactionSpec.fromJson(Map<String, dynamic> json) =>
      _$TransactionSpecFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionSpecToJson(this);
}

@immutable
@JsonSerializable(includeIfNull: false)
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
    Iterable<Posting>? postings,
    Iterable<String>? tags,
    Map<String, MetaValue>? meta,
    ParsingInfo? parsingInfo,
  }) {
    return Transaction(
      date,
      flag,
      narration,
      payee: payee,
      tags: tags ?? this.tags,
      comments: comments ?? this.comments,
      postings: postings ?? this.postings,
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
  bool get stringify => true;

  @override
  Transaction resolve() => this;

  @override
  bool get canResolve => true;

  @override
  TransactionSpec toSpec() {
    return TransactionSpec(
      date,
      flag,
      narration,
      payee: payee,
      tags: tags,
      postings: postings.map((p) => p.toSpec()),
      meta: meta.unlockView,
      parsingInfo: parsingInfo,
    );
  }

  @override
  int compareTo(other) {
    return date.compareTo(other.date);
  }

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

IList<Posting> resolvedPostings(TransactionSpec trSpec) {
  var postings = trSpec.postings.map((p) {
    var costSpec = p.costSpec;
    if (costSpec != null) {
      p = p.copyWith(costSpec: costSpec.copyWith(date: trSpec.date));
    }
    return p;
  }).toIList();

  var numUnresolved = postings.where((p) => !p.canResolve).length;
  if (numUnresolved > 1) {
    throw PostingResolutinFailure(trSpec,
        'Cannot realize transaction with more than one unresolved posting');
  }
  if (numUnresolved == 0) {
    return postings.map((p) => p.resolve()).toIList();
  }

  var currencies = postings.map((p) {
    var priceSpec = p.priceSpec;
    if (priceSpec?.amountTotal != null) {
      return priceSpec!.amountTotal!.currency;
    }
    if (priceSpec?.amountPer != null) {
      return priceSpec!.amountPer!.currency;
    }

    var costSpec = p.costSpec;
    if (costSpec?.amountPer != null) {
      return costSpec!.amountPer!.currency;
    }
    if (costSpec?.amountTotal != null) {
      return costSpec!.amountTotal!.currency;
    }

    return p.amount?.currency;
  }).nonNulls;

  if (currencies.toSet().length != 1) {
    throw PostingResolutinFailure(
        trSpec, 'Cannot realize transaction with multiple currencies');
  }
  var currency = currencies.first;

  var num = Decimal.zero;
  for (var p in postings) {
    if (!p.canResolve) continue;

    num += p.resolve().weight().number;
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
        throw new PostingResolutinFailure(
          trSpec,
          'Cannot resolve transaction with unspecified currency',
        );
      }
      pTotal = Amount(num.abs(), pTotal.currency!);
      priceSpec = priceSpec.copyWith(amountTotal: pTotal);
      unresolved = unresolved.copyWith(priceSpec: priceSpec);
    } else if (priceSpec.amountPer != null) {
      var pPer = priceSpec.amountPer!;
      var per = (num.abs() / unresolved.amount!.number).toDecimal(
          scaleOnInfinitePrecision: 10); // FIXME: What about the precision?
      if (pPer.currency == null) {
        throw new PostingResolutinFailure(
          trSpec,
          'Cannot resolve transaction with unspecified currency',
        );
      }
      pPer = Amount(per, pPer.currency!);
      priceSpec = priceSpec.copyWith(amountPer: pPer);
      unresolved = unresolved.copyWith(priceSpec: priceSpec);
    }
  }

  return IList(
      postings.replace(unresolvedIndex, unresolved).map((ps) => ps.resolve()));
}
