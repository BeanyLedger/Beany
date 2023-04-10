import 'dart:io';

import 'package:beany/core/account.dart';
import 'package:beany/core/close_statement.dart';
import 'package:beany/core/core.dart';
import 'package:beany/core/open_statement.dart';
import 'package:beany/core/statements.dart';
import 'package:beany/parser/parser.dart';
import 'package:equatable/equatable.dart';
import 'package:path/path.dart' as p;

import 'package:meta/meta.dart';

class Engine {
  List<Statement> statements = [];

  Engine(this.statements);

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
    return Engine([...statementsWithoutIncludes, ...extraStatements]);
  }

  List<AccountInfo> get accounts {
    var accountInfos = <AccountInfo>[];
    for (var statement in statements) {
      if (statement is OpenStatement) {
        var open = statement;
        accountInfos.add(AccountInfo(open.account, open.date, null));
      } else if (statement is CloseStatement) {
        var close = statement;
        var i = accountInfos.indexWhere((a) => a.account == close.account);
        if (i == -1) {
          throw Exception(
              'Account "${close.account}" was closed before it was opened');
        }

        accountInfos[i] =
            AccountInfo(close.account, accountInfos[i].openDate, close.date);
      }
    }

    return accountInfos;
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

// Compute the balance per account, per day?
// That way, I'll be easily able to verify any account balance statements

// Maybe there should be 1 function to open a file, parse all the statements are return them?
