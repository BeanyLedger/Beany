import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/amount.dart';
import 'package:beany_core/engine/multi_amount.dart';
import 'package:beany_core/misc/date.dart';
import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

/**
 * Stores the account balances at the end of the day
 */
@immutable
class AccountBalances extends Equatable {
  final Date date;
  final Map<Account, MultiAmount> balances = {};

  AccountBalances(this.date);

  @override
  List<Object?> get props => [date, balances];

  Amount? amountBy(Account account, String currency) {
    return balances[account]?.amountBy(currency);
  }

  AccountBalances clone(Date date) {
    var ab = AccountBalances(date);
    ab.balances.addAll(balances);
    return ab;
  }

  Map<Account, MultiAmount> diff(AccountBalances other) {
    var diff = Map<Account, MultiAmount>();
    for (var account in balances.keys) {
      var amounts = balances[account]!.toAmountList();
      for (var amount in amounts) {
        var otherAmounts = other.balances[account];
        if (otherAmounts == null) continue;

        var otherAmount = otherAmounts.amountBy(amount.currency);

        // Not changed
        if (otherAmount == null) continue;
        if (otherAmount == amount) continue;

        var ma = diff[account] ?? MultiAmount();
        ma.addAmount(otherAmount - amount);
        diff[account] = ma;
      }
    }

    return diff;
  }

  void add(Account account, Amount amount) {
    var ma = balances[account] ?? MultiAmount();
    ma.addAmount(amount);
    balances[account] = ma;
  }
}
