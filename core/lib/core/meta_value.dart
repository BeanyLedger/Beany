import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'account.dart';
import 'amount.dart';

part 'meta_value.g.dart';

@immutable
@JsonSerializable(includeIfNull: false)
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
    if (numberValue != null) return numberValue!.toString();
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

  @override
  bool get stringify => true;

  factory MetaValue.fromJson(Map<String, dynamic> json) =>
      _$MetaValueFromJson(json);
  Map<String, dynamic> toJson() => _$MetaValueToJson(this);
}
