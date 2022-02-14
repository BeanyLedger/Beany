import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class Account {
  final String value;
  Account(this.value);

  String toString() {
    return value;
  }

  @override
  bool operator ==(Object t) => t is Account && t.value == value;
}

class Amount {
  final Decimal number;
  final String currency;

  Amount(this.number, this.currency);

  String toString() {
    return number.toString() + ' ' + currency;
  }

  bool operator ==(Object other) =>
      other is Amount && other.number == number && other.currency == currency;
}

abstract class Directive {
  IMap<String, dynamic> get meta;
  DateTime get date;
}
