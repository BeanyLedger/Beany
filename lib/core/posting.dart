import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'account.dart';
import 'core.dart';

@immutable
class CostSpec extends Equatable {
  final AmountSpec? amountPer;
  final AmountSpec? amountTotal;
  final DateTime? date;
  final String? label;

  CostSpec({
    this.amountPer,
    this.amountTotal,
    this.date,
    this.label,
  }) {
    if (amountPer != null && amountTotal != null) {
      throw ArgumentError('amountPer and amountTotal cannot both be defined');
    }
  }

  CostSpec copyWith({
    AmountSpec? amountPer,
    AmountSpec? amountTotal,
    String? currency,
    DateTime? date,
    String? lable,
  }) {
    return CostSpec(
      amountPer: amountPer ?? this.amountPer,
      amountTotal: amountTotal ?? this.amountTotal,
      date: date ?? this.date,
      label: label ?? this.label,
    );
  }

  @override
  List<Object?> get props => [amountPer, amountTotal, date, label];

  @override
  String toString() {
    var sb = StringBuffer();

    AmountSpec? amount;
    if (amountPer != null) {
      amount = amountPer!;
      sb.write(' @ ');
    }
    if (amountTotal != null) {
      amount = amountTotal!;
      sb.write(' @@ ');
    }
    if (amount != null) {
      if (amount.number != null) {
        sb.write(amount.number!.toStringAsFixed(2));
      }
      if (amount.currency != null) {
        if (amount.number != null) sb.write(' ');
        sb.write(amount.currency);
      }
    }
    /*
    if (date != null) {
      sb.write(' ');
      sb.write(date);
    }
    if (label != null) {
      sb.write(' ');
      sb.write(label);
    }
    */
    return sb.toString();
  }
}

// Rename to PostingSpec
@immutable
class Posting extends Equatable {
  late final Account account;
  late final Amount? amount;
  late final String? comment;
  late final CostSpec? costSpec;

  late final IList<String> tags;

  Posting(
    this.account,
    this.amount, {
    this.comment = null,
    this.costSpec = null,
    Iterable<String>? tags,
  }) : tags = IList(tags);

  Posting.simple(
    String account,
    String? number,
    String? currency, {
    this.comment = null,
    this.costSpec = null,
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
    CostSpec? costSpec,
  }) {
    return Posting(
      account ?? this.account,
      amount ?? this.amount,
      tags: tags ?? this.tags.toList(),
      comment: comment ?? this.comment,
      costSpec: costSpec ?? this.costSpec,
    );
  }

  @override
  List<Object?> get props => [
        account,
        amount,
        comment,
        costSpec,
        tags,
      ];
}
