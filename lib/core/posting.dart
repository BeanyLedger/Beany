import 'package:beany/core/price_spec.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'account.dart';
import 'amount.dart';
import 'cost_spec.dart';

// Rename to PostingSpec
@immutable
class Posting extends Equatable {
  late final Account account;
  late final Amount? amount;
  late final String? comment;
  late final PriceSpec? priceSpec;
  late final CostSpec? costSpec;

  late final IList<String> tags;

  Posting(
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

  Posting copyWith({
    Account? account,
    Amount? amount,
    List<String>? tags,
    String? comment,
    PriceSpec? priceSpec,
    CostSpec? costSpec,
  }) {
    return Posting(
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
