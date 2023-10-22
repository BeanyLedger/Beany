import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/amount.dart';
import 'package:beany_core/misc/date.dart';
import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';
import 'package:quiver/collection.dart';
import 'package:collection/collection.dart';

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

  Amount? amountBy(Account account, String currency) {
    var amounts = balances[account];
    return amounts.firstWhereOrNull((a) => a.currency == currency);
  }

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
