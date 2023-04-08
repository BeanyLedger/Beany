import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'account.dart';
import 'amount.dart';

@immutable
class MetaValue extends Equatable {
  final String? stringValue;
  final Decimal? numberValue;
  final Amount? amountValue;
  final DateTime? dateValue;
  final String? tagValue;
  final String? currencyValue;
  final Account? accountValue;
  final bool? boolValue;

  MetaValue({
    this.stringValue,
    this.numberValue,
    this.amountValue,
    this.dateValue,
    this.tagValue,
    this.currencyValue,
    this.accountValue,
    this.boolValue,
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
    if (boolValue != null) return boolValue.toString();

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
        boolValue,
      ];
}
