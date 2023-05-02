import 'package:beany/core/account.dart';
import 'package:beany/core/amount.dart';
import 'package:beany/core/core.dart';
import 'package:beany/core/transaction.dart';
import 'package:beany/engine/ledger.dart';
import 'package:beany/render/render.dart';

class AccountAlreadyOpenException implements Exception {
  final Account account;
  final DateTime openDate;
  final Statement statement;

  AccountAlreadyOpenException(this.account, this.openDate, this.statement);
}

class AccountNotOpenException implements Exception {
  final Account account;
  final Statement statement;

  AccountNotOpenException(this.account, this.statement);

  @override
  String toString() {
    return 'AccountNotOpenException{account: ${account.value}, statement: ${render(statement)}}}';
  }
}

class AccountAlreadyClosed implements Exception {
  final Account account;
  final DateTime openDate;
  final DateTime closeDate;
  final Statement statement;

  AccountAlreadyClosed(AccountInfo ai, this.statement)
      : this.account = ai.account,
        this.openDate = ai.openDate,
        this.closeDate = ai.closeDate!;
}

class BalanceFailure implements Exception {
  final Account account;
  final DateTime date;
  final Amount expected;
  final Amount? actual;
  final Statement statement;

  BalanceFailure(
    this.account,
    this.statement,
    this.date, {
    required this.expected,
    required this.actual,
  });

  @override
  String toString() {
    return 'BalanceFailure{account: ${account.value}, date: $date, expected: $expected, actual: $actual}';
  }
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
