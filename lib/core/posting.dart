import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'account.dart';
import 'core.dart';

@immutable
class CostSpec {
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

  bool operator ==(Object other) {
    if (other is! CostSpec) return false;

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

// Rename to PostingSpec
@immutable
class Posting {
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

  bool operator ==(Object other) {
    if (other is! Posting) return false;

    // print('this ${toString()}');
    // print('other ${other.toString()}');
    // print('account: ${account == other.account}');
    // print('amount: ${amount == other.amount}');
    // print('comment: ${comment == other.comment}');
    // print('cost: ${cost == other.cost}');
    return other.account == account &&
        other.amount == amount &&
        other.tags == tags &&
        comment == other.comment &&
        price == other.price &&
        totalPrice == other.totalPrice &&
        cost == other.cost &&
        totalCost == other.totalCost;
  }
}
