import 'package:beany_core/core/price_spec.dart';
import 'package:beany_core/misc/date.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:equatable/src/equatable_utils.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'account.dart';
import 'amount.dart';
import 'cost_spec.dart';

part 'posting.g.dart';

@immutable
@JsonSerializable(includeIfNull: false)
class PostingSpec extends Equatable {
  final Account account;
  final Amount? amount;
  final String? comment;
  final IList<String> preComments;
  final PriceSpec? priceSpec;
  final CostSpec? costSpec;

  final IList<String> tags;

  PostingSpec(
    this.account,
    this.amount, {
    this.comment = null,
    this.priceSpec = null,
    this.costSpec = null,
    Iterable<String>? tags,
    Iterable<String>? preComments,
  })  : tags = IList(tags),
        preComments = IList(preComments);

  bool get canResolve {
    var can = amount != null;
    if (priceSpec != null) {
      can = can && priceSpec!.canResolve;
    }
    if (costSpec != null) {
      can = can && costSpec!.canResolve;
    }
    return can;
  }

  Posting resolve({DateTime? costSpecDate}) {
    var costSpec = this.costSpec;
    if (!canResolve) {
      if (costSpec == null) {
        throw ArgumentError('PostingSpec: cannot resolve');
      }

      costSpec = this.costSpec!.copyWith(date: costSpecDate);
      if (!this.copyWith(costSpec: costSpec).canResolve) {
        throw ArgumentError('PostingSpec: cannot resolve');
      }
    }

    Price? price;
    if (priceSpec != null) {
      price = Price(
        amountPer: priceSpec?.amountPer?.toAmount(),
        amountTotal: priceSpec?.amountTotal?.toAmount(),
      );
    }

    return Posting(
      account,
      amount ?? this.amount!,
      comment: comment,
      preComments: preComments,
      priceSpec: price,
      costSpec: costSpec,
      tags: tags,
      spec: this,
    );
  }

  PostingSpec copyWith({
    Account? account,
    Amount? amount,
    List<String>? tags,
    String? comment,
    Iterable<String>? preComments,
    covariant PriceSpec? priceSpec,
    CostSpec? costSpec,
  }) {
    return PostingSpec(
      account ?? this.account,
      amount ?? this.amount,
      tags: tags ?? this.tags,
      comment: comment ?? this.comment,
      preComments: preComments ?? this.preComments,
      priceSpec: priceSpec ?? this.priceSpec,
      costSpec: costSpec ?? this.costSpec,
    );
  }

  @override
  List<Object?> get props => [
        account,
        amount,
        comment,
        preComments,
        priceSpec,
        costSpec,
        tags,
      ];

  @override
  bool get stringify => true;

  @override
  bool operator ==(Object other) {
    if (other is! Posting && other is! PostingSpec) return false;

    return identical(this, other) ||
        other is Equatable && equals(props, other.props);
  }

  PostingSpec toSpec() => this;

  factory PostingSpec.fromJson(Map<String, dynamic> json) =>
      _$PostingSpecFromJson(json);
  Map<String, dynamic> toJson() => _$PostingSpecToJson(this);
}

@immutable
@JsonSerializable(includeIfNull: false)
class Posting extends Equatable implements PostingSpec {
  final Account account;
  final Amount amount;
  final String? comment;
  final IList<String> preComments;
  final Price? priceSpec;
  final CostSpec? costSpec;

  final IList<String> tags;

  final PostingSpec? spec;

  Posting(
    this.account,
    this.amount, {
    this.comment = null,
    this.priceSpec = null,
    this.costSpec = null,
    Iterable<String>? tags,
    Iterable<String>? preComments,
    this.spec,
  })  : tags = IList(tags),
        preComments = IList(preComments);

  @override
  Posting copyWith({
    Account? account,
    Amount? amount,
    List<String>? tags,
    String? comment,
    Iterable<String>? preComments,
    Price? priceSpec,
    CostSpec? costSpec,
  }) {
    return Posting(
      account ?? this.account,
      amount ?? this.amount,
      tags: tags ?? this.tags,
      comment: comment ?? this.comment,
      preComments: preComments ?? this.preComments,
      priceSpec: priceSpec ?? this.priceSpec,
      costSpec: costSpec ?? this.costSpec,
    );
  }

  @override
  List<Object?> get props => [
        account,
        amount,
        comment,
        preComments,
        priceSpec,
        costSpec,
        tags,
      ];

  @override
  bool get stringify => true;

  @override
  Posting resolve({DateTime? costSpecDate}) => this;

  CostBasis? get costBasis {
    var cs = costSpec;
    if (cs == null) return null;

    var units = cs.amountPer?.number;
    if (units == null) {
      var total = cs.amountTotal!.number;
      units = (total / amount.number).toDecimal();
    }
    return CostBasis(units, cs.currency, Date.truncate(cs.date!));
  }

  Amount weight() {
    var baseAmount = amount.number;
    var baseAmountSign = Decimal.fromInt(baseAmount.signum);

    var costSpec = this.costSpec;
    if (costSpec != null) {
      var per = costSpec.amountPer;
      if (per != null) {
        return Amount(per.number * baseAmount, per.currency);
      }

      var total = costSpec.amountTotal;
      if (total != null) {
        return total;
      }

      throw new Exception("Posting Weight: costSpec is invalid");
    }

    var priceSpec = this.priceSpec;
    if (priceSpec != null) {
      var amountTotal = priceSpec.amountTotal;
      if (amountTotal != null) {
        var n = amountTotal.number * baseAmountSign;
        return Amount(n, amountTotal.currency);
      }

      var amountPer = priceSpec.amountPer;
      if (amountPer != null) {
        var n = amountPer.number * baseAmount;
        return Amount(n, amountPer.currency);
      }

      throw ArgumentError('Posting Weight: priceSpec is invalid');
    }

    return amount;
  }

  @override
  bool get canResolve => true;

  @override
  bool operator ==(Object other) {
    if (other is! Posting && other is! PostingSpec) return false;

    return identical(this, other) ||
        other is Equatable && equals(props, other.props);
  }

  @override
  PostingSpec toSpec() {
    return PostingSpec(
      account,
      amount,
      comment: comment,
      priceSpec: priceSpec,
      costSpec: costSpec,
      tags: tags,
      preComments: preComments,
    );
  }

  factory Posting.fromJson(Map<String, dynamic> json) =>
      _$PostingFromJson(json);
  Map<String, dynamic> toJson() => _$PostingToJson(this);
}
