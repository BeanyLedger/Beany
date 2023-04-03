import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'account.dart';

@immutable
class Amount extends Equatable {
  final Decimal number;
  final String currency;

  Amount(this.number, this.currency);

  String toString() {
    // FIXME: This depends on the precission of the currency!
    return number.toStringAsFixed(2) + ' ' + currency;
  }

  @override
  List<Object?> get props => [number, currency];
}

abstract class Statement {}

abstract class Directive extends Statement {
  IMap<String, dynamic> get meta;
  DateTime get date;
}

@immutable
class MetaValue extends Equatable {
  final String? stringValue;
  final Decimal? numberValue;
  final Amount? amountValue;
  final DateTime? dateValue;
  final String? tagValue;
  final String? currencyValue;
  final Account? accountValue;

  MetaValue({
    this.stringValue,
    this.numberValue,
    this.amountValue,
    this.dateValue,
    this.tagValue,
    this.currencyValue,
    this.accountValue,
  });

  String toString() {
    if (stringValue != null) return '"$stringValue"';
    // FIXME: This depends on the precission of the currency!
    if (numberValue != null) return numberValue!.toStringAsFixed(2);
    if (amountValue != null) return amountValue.toString();
    if (dateValue != null) return dateValue!.toIso8601String();
    if (tagValue != null) return '#$tagValue';
    if (currencyValue != null) return currencyValue!;
    if (accountValue != null) return accountValue!.toString();

    throw new Exception("Unknown MetaData Value");
  }

  @override
  List<Object?> get props => [
        stringValue,
        numberValue,
        amountValue,
        dateValue,
        tagValue,
        currencyValue,
        accountValue,
      ];
}
