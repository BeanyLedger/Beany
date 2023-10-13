import 'package:beany_core/core/posting.dart';
import 'package:beany_core/core/transaction.dart';

extension TransactionPrettier on Transaction {
  TransactionSpec pretty() {
    var postingSpecs = postings.cast<PostingSpec>().toList();

    // Sort the Postings by Account
    postingSpecs.sort((a, b) => a.account.compareTo(b.account));

    if (postingSpecs.length == 2) {
      var haveCostSpecs = false;
      var havePriceSpecs = false;

      for (var postingSpec in postingSpecs) {
        if (postingSpec.costSpec != null) {
          haveCostSpecs = true;
        }
        if (postingSpec.priceSpec != null) {
          havePriceSpecs = true;
        }
      }

      if (!havePriceSpecs && !haveCostSpecs) {
        postingSpecs[1] = PostingSpec(postingSpecs[1].account, null);
      }
    }

    return TransactionSpec(
      date,
      flag,
      narration,
      payee: payee,
      tags: tags,
      postings: postingSpecs,
      meta: meta.unlockLazy,
      parsingInfo: parsingInfo,
    );
  }
}
