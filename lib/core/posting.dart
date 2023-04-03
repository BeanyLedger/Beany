import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'account.dart';
import 'core.dart';

@immutable
class CostSpec extends Equatable {
  final Decimal number;
  final String currency;
  final DateTime? date;
  final String? label;

  CostSpec(this.number, this.currency, this.date, {this.label});

  CostSpec copyWith({
    Decimal? number,
    String? currency,
    DateTime? date,
    String? lable,
  }) {
    return CostSpec(
      number ?? this.number,
      currency ?? this.currency,
      date ?? this.date,
      label: label ?? this.label,
    );
  }

  @override
  List<Object?> get props => [number, currency, date, label];
}

// Rename to PostingSpec
@immutable
class Posting extends Equatable {
  late final Account account;
  late final Amount? amount;
  late final String? comment;

  late final CostSpec? price;
  late final CostSpec? totalPrice;

  late final CostSpec? cost;
  late final CostSpec? totalCost;

  late final IList<String> tags;

  Posting(
    this.account,
    this.amount, {
    this.comment = null,
    this.price = null,
    this.totalPrice = null,
    this.cost = null,
    this.totalCost = null,
    Iterable<String>? tags,
  }) : tags = IList(tags);
  Posting.simple(
    String account,
    String? number,
    String? currency, {
    this.comment = null,
    this.price = null,
    this.totalPrice = null,
    this.cost = null,
    this.totalCost = null,
    List<String>? tags,
  }) : tags = IList(tags) {
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
    if (price != null) {
      sb.write(' @ ');
      sb.write(price!.number.toStringAsFixed(2));
      sb.write(' ');
      sb.write(price!.currency);
    } else if (totalPrice != null) {
      sb.write(' @@ ');
      sb.write(totalPrice!.number.toStringAsFixed(2));
      sb.write(' ');
      sb.write(totalPrice!.currency);
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
    CostSpec? price,
    CostSpec? totalPrice,
    CostSpec? cost,
    CostSpec? totalCost,
  }) {
    return Posting(
      account ?? this.account,
      amount ?? this.amount,
      tags: tags ?? this.tags.toList(),
      comment: comment ?? this.comment,
      price: price ?? this.price,
      totalPrice: totalPrice ?? this.totalPrice,
      cost: cost ?? this.cost,
      totalCost: totalCost ?? this.totalCost,
    );
  }

  @override
  List<Object?> get props => [
        account,
        amount,
        comment,
        price,
        totalPrice,
        cost,
        totalCost,
        tags,
      ];
}
