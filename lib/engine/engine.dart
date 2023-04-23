import 'dart:io';

import 'package:beany/core/account.dart';
import 'package:beany/core/amount.dart';
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

class Engine {
  List<Statement> statements = [];

  Engine(this.statements);

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
        var open = statement;
        _accountInfo.add(AccountInfo(open.account, open.date, null));
      } else if (statement is CloseStatement) {
        var close = statement;
        var i = _accountInfo.indexWhere((a) => a.account == close.account);
        if (i == -1) {
          throw Exception(
              'Account "${close.account}" was closed before it was opened');
        }

        _accountInfo[i] =
            AccountInfo(close.account, _accountInfo[i].openDate, close.date);
      } else if (statement is Transaction) {
        var transaction = statement;
        var date = Date.from(transaction.date);
        var ab = _accountBalances[date] ?? AccountBalances(date);

        var resolvedPostings = transaction.resolvedPostings();
        for (var posting in resolvedPostings) {
          var account = posting.account;
          var accountInfo = _accountInfo.firstWhereOrNull(
            (a) => a.account == account,
          );

          if (accountInfo == null) {
            throw Exception('Account "$account" was not opened');
          }
          if (accountInfo.closeDate != null) {
            if (accountInfo.closeDate!.isBefore(transaction.date)) {
              throw Exception(
                  'Account "$account" was closed before transaction "${transaction.date}"');
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
