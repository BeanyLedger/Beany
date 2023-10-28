import 'dart:io';

import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/balance_statement.dart';
import 'package:beany_core/core/close_statement.dart';
import 'package:beany_core/core/core.dart';
import 'package:beany_core/core/open_statement.dart';
import 'package:beany_core/core/statements.dart';
import 'package:beany_core/core/transaction.dart';
import 'package:beany_core/engine/account_inventory_map.dart';
import 'package:beany_core/engine/ledger_meta_data.dart';
import 'package:beany_core/misc/date.dart';
import 'package:beany_core/parser/parser.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:path/path.dart' as p;

import 'package:meta/meta.dart';

import 'exceptions.dart';

@immutable
class Ledger {
  final IList<Statement> statements;
  final LedgerMetaData metaData;

  final IMap<Date, AccountInventoryMap> _accountInvByDate;

  Ledger._({
    required this.statements,
    required this.metaData,
    required Map<Date, AccountInventoryMap> accountInvByDate,
  }) : _accountInvByDate = IMap(accountInvByDate);

  AccountInventoryMap? inventoryAtEndOfDate(Date d) {
    if (d.isBefore(_accountInvByDate.keys.first)) {
      print("Date $d is out of range");
      return null;
    }

    // FIXME: This definitely needs to be optimized!
    var ab = _accountInvByDate[d];
    while (ab == null && _accountInvByDate.isNotEmpty) {
      d = d.yesterday();
      ab = _accountInvByDate[d];
    }

    return ab;
  }

  AccountInventoryMap? inventoryAtStartOfDate(Date d) {
    return inventoryAtEndOfDate(d.yesterday());
  }

  static Ledger loadString(String fileContent) {
    var statements = parse(fileContent).all().val().toList();
    var engine = _LedgerBuilder._(statements: statements, files: []);
    return engine.compute();
  }

  static Future<Ledger> loadRootFile(String filePath) async {
    var rootDir = p.dirname(filePath);

    var filePaths = <String>[];
    filePaths.add(filePath);

    var file = File(filePath);
    var text = await file.readAsString();
    var statements = parse(text, filePath: filePath).all().val();
    var extraStatements = <Statement>[];
    for (var statement in statements) {
      if (statement is IncludeStatement) {
        var include = statement;
        var includeFile = File(p.join(rootDir, include.path));
        var includeText = await includeFile.readAsString();
        var includeStatements = parse(
          includeText,
          filePath: includeFile.path,
        ).all().val();
        extraStatements.addAll(includeStatements);

        filePaths.add(includeFile.path);
      }
    }

    var statementsWithoutIncludes =
        statements.where((s) => s is! IncludeStatement);
    var engine = _LedgerBuilder._(
      statements: [...statementsWithoutIncludes, ...extraStatements],
      files: filePaths,
    );
    return engine.compute();
  }
}

class _LedgerBuilder {
  List<Statement> statements = [];
  LedgerMetaData? metaData;
  List<String> files;

  _LedgerBuilder._({required this.statements, required this.files}) {
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

  final _accountInfo = Map<Account, AccountInfo>();
  Iterable<AccountInfo> get accounts => _accountInfo.values;

  /// Stores the account balance at the end of the day
  final _accountInvByDate = <Date, AccountInventoryMap>{};

  AccountInventoryMap? inventoryAtEndOfDate(Date d) {
    if (d.isBefore(_accountInvByDate.keys.first)) {
      print("Date $d is out of range");
      return null;
    }

    // This may seem inefficient, but it's actually awesome as we're processing the statements
    // in order, so at most we'll have to go back 1 day
    var ab = _accountInvByDate[d];
    while (ab == null && _accountInvByDate.isNotEmpty) {
      d = d.yesterday();
      ab = _accountInvByDate[d];
    }

    return ab;
  }

  AccountInventoryMap? inventoryAtStartOfDate(Date d) {
    return inventoryAtEndOfDate(d.yesterday());
  }

  Ledger compute() {
    Date? earliestDate;
    Date? latestDate;

    for (var statement in statements) {
      if (statement is TransactionSpec) {
        var date = Date.from(statement.date);
        if (earliestDate == null || date.isBefore(earliestDate)) {
          earliestDate = date;
        }
        if (latestDate == null || date.isAfter(latestDate)) {
          latestDate = date;
        }
      }

      if (statement is OpenStatement) {
        // Make sure the account is not already open
        var actInfo = _accountInfo[statement.account];
        if (actInfo != null) {
          throw AccountAlreadyOpenException(
              actInfo.account, actInfo.openDate, statement);
        }

        var open = statement;
        _accountInfo[open.account] = AccountInfo(open.account, open.date, null);
      } else if (statement is CloseStatement) {
        var close = statement;
        var ac = close.account;
        var ai = _accountInfo[ac];
        if (ai == null) {
          throw AccountNotOpenException(ac, statement);
        }

        _accountInfo[ac] = AccountInfo(ac, ai.openDate, close.date);
      } else if (statement is TransactionSpec) {
        var transaction = statement;
        var date = Date.from(transaction.date);
        var ab = _accountInvByDate[date];
        if (ab == null) {
          if (_accountInvByDate.isEmpty) {
            ab = AccountInventoryMap();
          } else {
            // This only works if the ledger is sorted by date (ascending), which it is
            var lastDate = _accountInvByDate.keys.last;
            ab = _accountInvByDate[lastDate]!;
          }
        }

        var resolvedPostings = transaction.resolve().postings;
        for (var posting in resolvedPostings) {
          var account = posting.account;
          var accountInfo = _accountInfo[account];
          if (accountInfo == null) {
            throw AccountNotOpenException(account, statement);
          }
          if (accountInfo.closeDate != null) {
            if (accountInfo.closeDate!.isBefore(transaction.date)) {
              throw AccountAlreadyClosed(accountInfo, statement);
            }
          }
          var amount = posting.amount;
          ab = ab!.add(account, amount);
        }

        _accountInvByDate[date] = ab!;
      } else if (statement is BalanceStatement) {
        var balance = statement;
        var date = Date.from(balance.date);

        var account = balance.account;
        var accountInfo = _accountInfo[account];
        if (accountInfo == null) {
          throw AccountNotOpenException(account, statement);
        }
        if (accountInfo.closeDate != null) {
          if (accountInfo.closeDate!.isBefore(balance.date)) {
            throw AccountAlreadyClosed(accountInfo, statement);
          }
        }

        var prevAb = inventoryAtStartOfDate(date);
        if (prevAb == null) {
          if (balance.amount.number == Decimal.zero) continue;

          throw BalanceFailure(account, statement, date,
              expected: balance.amount, actual: null);
        }

        var prevAmount = prevAb.amountBy(account, balance.amount.currency);
        if ((prevAmount?.number ?? Decimal.zero) != balance.amount.number) {
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

    metaData = LedgerMetaData(
      earliestDate: earliestDate,
      latestDate: latestDate,
      files: IList(files),
      accounts: IList(_accountInfo.keys),
    );

    return Ledger._(
      statements: IList(statements),
      metaData: metaData!,
      accountInvByDate: _accountInvByDate,
    );
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
