import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'account.g.dart';

@immutable
@JsonSerializable(includeIfNull: false)
class Account extends Equatable implements Comparable<Account> {
  final String value;

  Account(this.value);
  Account.fromParts(Iterable<String> parts) : value = parts.join(':');

  @override
  List<Object?> get props => [value];

  @override
  bool get stringify => true;

  @override
  int compareTo(Account other) {
    var myType = value.split(':')[0];
    var otherType = other.value.split(':')[0];

    if (myType == otherType) {
      return value.compareTo(other.value);
    }

    return _getSortOrder(_getAccountType(myType))
        .compareTo(_getSortOrder(_getAccountType(otherType)));
  }

  List<String> parts() => value.split(':');

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

AccountType _getAccountType(String myType) {
  switch (myType) {
    case 'Assets':
      return AccountType.Assets;
    case 'Liabilities':
      return AccountType.Liabilities;
    case 'Equity':
      return AccountType.Equity;
    case 'Income':
      return AccountType.Income;
    case 'Expenses':
      return AccountType.Expenses;
  }

  throw ArgumentError('Unknown account type: $myType');
}

enum AccountType {
  Assets,
  Liabilities,
  Equity,
  Income,
  Expenses,
}

int _getSortOrder(AccountType actType) {
  switch (actType) {
    case AccountType.Expenses:
      return 1;
    case AccountType.Liabilities:
      return 2;
    case AccountType.Equity:
      return 3;
    case AccountType.Income:
      return 4;
    case AccountType.Assets:
      return 5;
  }
}
