import 'package:beany/core/account.dart';

class AccountAlreadyOpenException implements Exception {
  final Account account;
  final DateTime openDate;

  AccountAlreadyOpenException(this.account, this.openDate);
}

class AccountNotOpenException implements Exception {
  final Account account;

  AccountNotOpenException(this.account);
}
