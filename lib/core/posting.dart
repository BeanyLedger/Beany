import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'account.dart';
import 'core.dart';

@immutable
class CostSpec extends Equatable {
  final Decimal? numberPer;
  final Decimal? numberTotal;
  final String? currency;
  final DateTime? date;
  final String? label;

  CostSpec({
    this.numberPer,
    this.numberTotal,
    this.currency,
    this.date,
    this.label,
  }) {
    if (numberPer != null && numberTotal != null) {
      throw ArgumentError('numberPer and numberTotal cannot both be defined');
    }
  }

  CostSpec copyWith({
    Decimal? numberPer,
    Decimal? numberTotal,
    String? currency,
    DateTime? date,
    String? lable,
  }) {
    return CostSpec(
      numberPer: numberPer ?? this.numberPer,
      numberTotal: numberTotal ?? this.numberTotal,
      currency: currency ?? this.currency,
      date: date ?? this.date,
      label: label ?? this.label,
    );
  }

  @override
  List<Object?> get props => [numberPer, numberTotal, currency, date, label];

  @override
  String toString() {
    var sb = StringBuffer();
    if (numberPer != null) {
      sb.write(' @ ');
      sb.write(numberPer!.toStringAsFixed(2));
    }
    if (numberTotal != null) {
      sb.write(' @@ ');
      sb.write(numberTotal!.toStringAsFixed(2));
    }
    if (currency != null) {
      sb.write(' ');
      sb.write(currency);
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
