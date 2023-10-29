import 'dart:io';

import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/core.dart';
import 'package:beany_core/core/meta_value.dart';
import 'package:beany_core/core/posting.dart';
import 'package:beany_core/core/transaction.dart';
import 'package:beany_core/parser/parser.dart';
import 'package:beany_importer/src/deduplicator.dart';
import 'package:test/test.dart';

void main() {
  test("Simple Statement", () {
    var fileData =
        File('test/testdata/wise_output.beancount').readAsStringSync();
    var statements = parse(fileData).all().val().toList();
    var transactions = statements.whereType<TransactionSpec>().toList();

    var tr = TransactionSpec(
      DT("2023-03-26"),
      TransactionFlag.Okay,
      "Audible",
      postings: [Posting(Account("Assets:Wise"), AMT("-14.94 USD"))],
      meta: {"id": MetaValue(stringValue: "CARD-649346528")},
    );

    var config = DuplicatorConfig("Assets:Wise");
    expect(transactionExists(config, transactions, tr), true);
  });

  // Add a test for when the date is 1 day before or after
  // Add a test for a 3 posting transaction
  // Add for a 3 posting transaction where the account names don't match (say for BankCharges)
}
