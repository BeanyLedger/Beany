import 'package:beany/core/transaction.dart';

bool transactionExists(List<TransactionSpec> transactions, TransactionSpec tr) {
  return transactions.any((existingTr) {
    if (existingTr.date != tr.date) return false;

    // Filter by metadata match
    for (var key in tr.meta.keys) {
      if (existingTr.meta[key] != tr.meta[key]) return false;
    }

    if (existingTr.postings.length < tr.postings.length) return false;
    for (var posting in tr.postings) {
      if (!existingTr.postings.contains(posting)) {
        return false;
      }
    }

    return true;
  });
}
