import 'dart:io';

import 'package:beany_core/core/amount.dart';
import 'package:beany_core/engine/ledger.dart';
import 'package:beany_core/misc/date.dart';
import 'package:beany_core/render/render.dart';

Future<void> main(List<String> args) async {
  if (args.length != 1) {
    print('usage: file');
    exit(1);
  }

  var ledger = await Ledger.loadRootFile(args.first);

  var startDate = Date(2023, 07, 01);
  var endDate = Date(2023, 08, 01);

  var startBalances = ledger.inventoryAtStartOfDate(startDate);
  var endBalances = ledger.inventoryAtEndOfDate(endDate);

  if (startBalances == null || endBalances == null) {
    print("No balances found for $startDate or $endDate");
    exit(1);
  }

  var diff = endBalances - startBalances;
  var totalExpenses = Amount.zero('EUR');
  var accounts = diff.accounts.toList();
  accounts.sort();
  for (var account in accounts) {
    var r = BeancountRenderer();

    var sb = StringBuffer();
    r.renderAccount(sb, account);
    sb.write(' ');
    for (var pos in diff.val(account)!.positions) {
      r.renderAmountSpec(sb, pos.units);
      sb.write(' ');
    }
    print(sb.toString());

    if (account.value.startsWith('Expenses:')) {
      var positions = diff.val(account)!.positions;
      for (var pos in positions) {
        var amt = pos.units;
        if (amt.currency == totalExpenses.currency) {
          totalExpenses += amt;
        }
      }
    }
  }

  print("");
  print("Total Expenses: $totalExpenses");
}
