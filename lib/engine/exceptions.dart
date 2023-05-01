import 'package:beany/core/account.dart';
import 'package:beany/core/amount.dart';
import 'package:beany/core/transaction.dart';
import 'package:beany/engine/ledger.dart';
import 'package:beany/render/render.dart';

class AccountAlreadyOpenException implements Exception {
  final Account account;
  final DateTime openDate;

  AccountAlreadyOpenException(this.account, this.openDate);
}

class AccountNotOpenException implements Exception {
  final Account account;

  AccountNotOpenException(this.account);
}

class AccountAlreadyClosed implements Exception {
  final Account account;
  final DateTime openDate;
  final DateTime closeDate;

  AccountAlreadyClosed(AccountInfo ai)
      : this.account = ai.account,
        this.openDate = ai.openDate,
        this.closeDate = ai.closeDate!;
}

class BalanceFailure implements Exception {
  final Account account;
  final DateTime date;
  final Amount expected;
  final Amount? actual;

  BalanceFailure(
    this.account,
    this.date, {
    required this.expected,
    required this.actual,
  });
}

class PostingResolutinFailure implements Exception {
  final TransactionSpec transaction;
  final String message;

  PostingResolutinFailure(this.transaction, this.message);

  @override
  String toString() {
    return 'PostingResolutinFailure{transaction: ${render(transaction)}, message: $message}';
  }
}
