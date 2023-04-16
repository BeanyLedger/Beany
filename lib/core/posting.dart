import 'package:beany/core/price_spec.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'account.dart';
import 'amount.dart';
import 'cost_spec.dart';

@immutable
class PostingSpec extends Equatable {
  final Account account;
  final Amount? amount;
  final String? comment;
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
  }) : tags = IList(tags);

  String toString() {
    var sb = StringBuffer();
    sb.write(amount != null
        ? "  " + account.toString() + "  " + amount.toString()
        : "  " + account.toString());
    if (priceSpec != null) {
      sb.write(priceSpec.toString());
    }
    if (costSpec != null) {
      sb.write(costSpec.toString());
    }
    if (tags.isNotEmpty) {
      for (var tag in tags) {
        sb.write(' #');
        sb.write(tag);
      }
    }
    if (comment != null && comment!.isNotEmpty) {
      sb.write(' ; ');
      sb.write(comment);
    }
    return sb.toString();
  }

  Posting toPosting({Amount? amount}) {
    if (amount == null && this.amount == null) {
      throw ArgumentError('PostingSpec: amount must be defined');
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
    PriceSpec? priceSpec,
    CostSpec? costSpec,
  }) {
    return PostingSpec(
      account ?? this.account,
      amount ?? this.amount,
      tags: tags ?? this.tags.toList(),
      comment: comment ?? this.comment,
      priceSpec: priceSpec ?? this.priceSpec,
      costSpec: costSpec ?? this.costSpec,
    );
  }

  @override
  List<Object?> get props => [
        account,
        amount,
        comment,
        priceSpec,
        costSpec,
        tags,
      ];
}

@immutable
class Posting extends Equatable implements PostingSpec {
  final Account account;
  final Amount amount;
  final String? comment;
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
    this.spec,
  }) : tags = IList(tags);

  String toString() {
    var sb = StringBuffer();
    sb.write("$account $amount");
    if (priceSpec != null) {
      sb.write(priceSpec.toString());
    }
    if (costSpec != null) {
      sb.write(costSpec.toString());
    }
    if (tags.isNotEmpty) {
      for (var tag in tags) {
        sb.write(' #');
        sb.write(tag);
      }
    }
    if (comment != null && comment!.isNotEmpty) {
      sb.write(' ; ');
      sb.write(comment);
    }
    return sb.toString();
  }

  PostingSpec copyWith({
    Account? account,
    Amount? amount,
    List<String>? tags,
    String? comment,
    PriceSpec? priceSpec,
    CostSpec? costSpec,
  }) {
    return PostingSpec(
      account ?? this.account,
      amount ?? this.amount,
      tags: tags ?? this.tags.toList(),
      comment: comment ?? this.comment,
      priceSpec: priceSpec ?? this.priceSpec,
      costSpec: costSpec ?? this.costSpec,
    );
  }

  @override
  List<Object?> get props => [
        account,
        amount,
        comment,
        priceSpec,
        costSpec,
        tags,
      ];

  @override
  Posting toPosting({Amount? amount}) => this;
}
