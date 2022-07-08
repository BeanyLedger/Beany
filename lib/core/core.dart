import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import 'account.dart';

@immutable
class Amount {
  final Decimal number;
  final String currency;

  Amount(this.number, this.currency);

  String toString() {
    // FIXME: This depends on the precission of the currency!
    return number.toStringAsFixed(2) + ' ' + currency;
  }

  bool operator ==(Object other) =>
      other is Amount && other.number == number && other.currency == currency;
}

abstract class Statement {}

abstract class Directive extends Statement {
  IMap<String, dynamic> get meta;
  DateTime get date;
}

@immutable
class MetaDataValue {
  String? stringValue;
  Decimal? numberValue;
  Amount? amountValue;
  DateTime? dateValue;
  String? tagValue;
  String? currencyValue;
  Account? accountValue;

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
}
