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
import 'package:equatable/equatable.dart';
import 'package:path/path.dart' as p;

import 'package:meta/meta.dart';
import 'package:quiver/collection.dart';
import 'package:collection/collection.dart';

import 'exceptions.dart';

class Engine {
  List<Statement> statements = [];

  Engine(this.statements) {
    statements.sort((a, b) {
      if (a is Directive && b is! Directive) {
        return -1;
      }
      if (a is! Directive && b is Directive) {
        return 1;
      }
      if (a is Directive && b is Directive) {
        return a.date.compareTo(b.date);
      }

      return 0;
    });
  }

  static Engine loadString(String fileContent) {
    var statements = parse(fileContent).all().val().toList();
    var engine = Engine(statements);
    return engine.compute();
  }

  static Future<Engine> loadRootFile(String filePath) async {
    var rootDir = p.dirname(filePath);

    var file = File(filePath);
    var text = await file.readAsString();
    var statements = parse(text).all().val().toList();
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
    var engine = Engine([...statementsWithoutIncludes, ...extraStatements]);
    return engine.compute();
  }

  final _accountInfo = <AccountInfo>[];
  List<AccountInfo> get accounts => _accountInfo;

  final _accountBalances = <Date, AccountBalances>{};
  Map<Date, AccountBalances> get accountBalances => _accountBalances;

  Engine compute() {
    for (var statement in statements) {
      if (statement is OpenStatement) {
        // Make sure the account is not already open
        var actInfo = _accountInfo
            .firstWhereOrNull((a) => a.account == statement.account);
        if (actInfo != null) {
          throw AccountAlreadyOpenException(actInfo.account, actInfo.openDate);
        }

        var open = statement;
        _accountInfo.add(AccountInfo(open.account, open.date, null));
      } else if (statement is CloseStatement) {
        var close = statement;
        var i = _accountInfo.indexWhere((a) => a.account == close.account);
        if (i == -1) {
          throw AccountNotOpenException(close.account);
        }

        _accountInfo[i] =
            AccountInfo(close.account, _accountInfo[i].openDate, close.date);
      } else if (statement is TransactionSpec) {
        var transaction = statement;
        var date = Date.from(transaction.date);
        var ab = _accountBalances[date] ?? AccountBalances(date);

        var resolvedPostings = transaction.resolve().postings;
        for (var posting in resolvedPostings) {
          var account = posting.account;
          var accountInfo = _accountInfo.firstWhereOrNull(
            (a) => a.account == account,
          );

          if (accountInfo == null) {
            throw AccountNotOpenException(account);
          }
          if (accountInfo.closeDate != null) {
            if (accountInfo.closeDate!.isBefore(transaction.date)) {
              throw AccountAlreadyClosed(accountInfo);
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
          throw AccountNotOpenException(account);
        }
        if (accountInfo.closeDate != null) {
          if (accountInfo.closeDate!.isBefore(balance.date)) {
            throw AccountAlreadyClosed(accountInfo);
          }
        }

        var prevDate = date.add(Duration(days: -1));
        var prevAb = _accountBalances[prevDate];
        if (prevAb == null) {
          throw BalanceFailure(account, date,
              expected: balance.amount, actual: null);
        }

        var prevAmount = prevAb.balances[account]
            .firstWhereOrNull((amt) => amt.currency == balance.amount.currency);
        if (prevAmount?.number != balance.amount.number) {
          throw BalanceFailure(account, date,
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

@immutable
class AccountBalances extends Equatable {
  final Date date;
  final Multimap<Account, Amount> balances = Multimap();

  AccountBalances(this.date);

  @override
  List<Object?> get props => [date, balances];
}
