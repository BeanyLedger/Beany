import 'package:beany/core/account.dart';
import 'package:beany/core/transaction.dart';

class DuplicatorConfig {
  final String mainAccount;

  DuplicatorConfig(this.mainAccount);
}

bool transactionExists(DuplicatorConfig config,
    List<TransactionSpec> transactions, TransactionSpec tr) {
  return transactions.any((existingTrSpec) {
    var existingTr = existingTrSpec.resolve();

    var dt = existingTr.date;
    var dt1Before = dt.subtract(Duration(days: 1));
    var dt1After = dt.add(Duration(days: 1));
    if (dt != tr.date && dt1After != tr.date && dt1Before != tr.date) {
      return false;
    }

    // Filter by metadata match
    for (var key in tr.meta.keys) {
      if (existingTr.meta[key] != tr.meta[key]) return false;
    }

    if (existingTr.postings.length < tr.postings.length) return false;
    for (var posting in tr.resolve().postings) {
      var matches = existingTr.postings.any((p) {
        if (p == posting) return true;

        if (p.account.value != config.mainAccount) {
          p = p.copyWith(account: Account(config.mainAccount));
        }
        var postingWithoutAccount = posting.copyWith(
          account: Account(config.mainAccount),
        );
        return postingWithoutAccount == p;
      });
      if (!matches) {
        return false;
      }
    }

    return true;
  });
}
