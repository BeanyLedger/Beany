import 'dart:io';

import 'package:beany/core/account.dart';
import 'package:beany/core/amount.dart';
import 'package:beany/core/balance_statement.dart';
import 'package:beany/core/close_statement.dart';
import 'package:beany/core/core.dart';
import 'package:beany/core/open_statement.dart';
import 'package:beany/core/statements.dart';
import 'package:beany/core/transaction.dart';
import 'package:beany/misc/date.dart';
import 'package:beany/parser/parser.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:path/path.dart' as p;

import 'package:meta/meta.dart';
import 'package:quiver/collection.dart';
import 'package:collection/collection.dart';

import 'exceptions.dart';

class Ledger {
  List<Statement> statements = [];

  Ledger(this.statements) {
    statements.sort((a, b) {
      if (a is Directive && b is! Directive) {
        return -1;
      }
      if (a is! Directive && b is Directive) {
        return 1;
      }
      if (a is Directive && b is Directive) {
        var ct = a.date.compareTo(b.date);
        if (ct != 0) return ct;

        if (a is Transaction || a is TransactionSpec) {
          return 1;
        }
        if (b is Transaction || b is TransactionSpec) {
          return -1;
        }
      }

      return 0;
    });
  }

  static Ledger loadString(String fileContent) {
    var statements = parse(fileContent).all().val().toList();
    var engine = Ledger(statements);
    return engine.compute();
  }

  static Future<Ledger> loadRootFile(String filePath) async {
    var rootDir = p.dirname(filePath);

    var file = File(filePath);
    var text = await file.readAsString();
    var statements = parse(text).all().val();
    var extraStatements = <Statement>[];
    for (var statement in statements) {
      if (statement is IncludeStatement) {
        var include = statement;
        var includeFile = File(p.join(rootDir, include.path));
        var includeText = await includeFile.readAsString();
        var includeStatements = parse(includeText).all().val();
        extraStatements.addAll(includeStatements);
      }
    }

    var statementsWithoutIncludes =
        statements.where((s) => s is! IncludeStatement);
    var engine = Ledger([...statementsWithoutIncludes, ...extraStatements]);
    return engine.compute();
  }

  final _accountInfo = <AccountInfo>[];
  List<AccountInfo> get accounts => _accountInfo;

  /// Stores the account balance at the end of the day
  final _accountBalances = <Date, AccountBalances>{};
  Map<Date, AccountBalances> get accountBalances => _accountBalances;

  AccountBalances? balanceAtEndofDate(Date d) {
    var ab = _accountBalances[d];
    while (ab == null && _accountBalances.isNotEmpty) {
      d = Date.from(d.add(Duration(days: -1)));
      ab = _accountBalances[d];
    }

    return ab;
  }

  Ledger compute() {
    for (var statement in statements) {
      if (statement is OpenStatement) {
        // Make sure the account is not already open
        var actInfo = _accountInfo
            .firstWhereOrNull((a) => a.account == statement.account);
        if (actInfo != null) {
          throw AccountAlreadyOpenException(
              actInfo.account, actInfo.openDate, statement);
        }

        var open = statement;
        _accountInfo.add(AccountInfo(open.account, open.date, null));
      } else if (statement is CloseStatement) {
        var close = statement;
        var i = _accountInfo.indexWhere((a) => a.account == close.account);
        if (i == -1) {
          throw AccountNotOpenException(close.account, statement);
        }

        _accountInfo[i] =
            AccountInfo(close.account, _accountInfo[i].openDate, close.date);
      } else if (statement is TransactionSpec) {
        var transaction = statement;
        var date = Date.from(transaction.date);
        var ab = _accountBalances[date];
        if (ab == null) {
          if (_accountBalances.isEmpty) {
            ab = AccountBalances(date);
          } else {
            var lastDate =
                _accountBalances.keys.reduce((a, b) => a > b ? a : b);
            ab = _accountBalances[lastDate]!.clone(date);
          }
        }

        var resolvedPostings = transaction.resolve().postings;
        for (var posting in resolvedPostings) {
          var account = posting.account;
          var accountInfo = _accountInfo.firstWhereOrNull(
            (a) => a.account == account,
          );

          if (accountInfo == null) {
            throw AccountNotOpenException(account, statement);
          }
          if (accountInfo.closeDate != null) {
            if (accountInfo.closeDate!.isBefore(transaction.date)) {
              throw AccountAlreadyClosed(accountInfo, statement);
            }
          }
          var amount = posting.amount;

          var val = ab.balances[account]
              .firstWhereOrNull((a) => a.currency == amount.currency);
          if (val == null) {
            ab.balances.add(account, amount);
            continue;
          }

          var sum = val + amount;
          ab.balances.remove(account, val);
          ab.balances.add(account, sum);
        }

        _accountBalances[date] = ab;
      } else if (statement is BalanceStatement) {
        var balance = statement;
        var date = Date.from(balance.date);

        var account = balance.account;
        var accountInfo = _accountInfo.firstWhereOrNull(
          (a) => a.account == account,
        );

        if (accountInfo == null) {
          throw AccountNotOpenException(account, statement);
        }
        if (accountInfo.closeDate != null) {
          if (accountInfo.closeDate!.isBefore(balance.date)) {
            throw AccountAlreadyClosed(accountInfo, statement);
          }
        }

        var prevAb =
            balanceAtEndofDate(Date.from(date.add(Duration(days: -1))));
        if (prevAb == null) {
          if (balance.amount.number == Decimal.zero) continue;

          throw BalanceFailure(account, statement, date,
              expected: balance.amount, actual: null);
        }

        var prevAmount = prevAb.balances[account]
            .firstWhereOrNull((amt) => amt.currency == balance.amount.currency);
        if (prevAmount?.number != balance.amount.number) {
          /*
          for (var date in _accountBalances.keys) {
            print("$date ->");
            var balances = _accountBalances[date]!.balances;
            for (var account in balances.keys) {
              var values = balances[account];
              for (var value in values) {
                print("  $account -> $value");
              }
            }
          }
          */
          throw BalanceFailure(account, statement, date,
              expected: balance.amount, actual: prevAmount);
        }
      }
    }

    return this;
  }
}

@immutable
class AccountInfo extends Equatable {
  final Account account;
  final DateTime openDate;
  final DateTime? closeDate;

  AccountInfo(this.account, this.openDate, this.closeDate);

  @override
  List<Object?> get props => [account, openDate, closeDate];
}

/**
 * Stores the account balances at the end of the day
 */
@immutable
class AccountBalances extends Equatable {
  final Date date;
  final Multimap<Account, Amount> balances = Multimap();

  AccountBalances(this.date);

  @override
  List<Object?> get props => [date, balances];

  AccountBalances clone(Date date) {
    var ab = AccountBalances(date);
    ab.balances.addAll(balances);
    return ab;
  }

  Multimap<Account, Amount> diff(AccountBalances other) {
    var diff = Multimap<Account, Amount>();
    for (var account in balances.keys) {
      var amounts = balances[account];
      for (var amount in amounts) {
        var otherAmounts = other.balances[account];
        var otherAmount = otherAmounts.firstWhereOrNull(
          (a) => a.currency == amount.currency,
        );
        // Not changed
        if (otherAmount == null) continue;
        if (otherAmount == amount) continue;

        diff.add(account, otherAmount - amount);
      }
    }

    return diff;
  }
}
