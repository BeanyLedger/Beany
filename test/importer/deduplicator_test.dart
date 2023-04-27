import 'dart:io';

import 'package:beany/core/account.dart';
import 'package:beany/core/core.dart';
import 'package:beany/core/meta_value.dart';
import 'package:beany/core/posting.dart';
import 'package:beany/core/transaction.dart';
import 'package:beany/importer/deduplicator.dart';
import 'package:beany/parser/parser.dart';
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
      postings: [PostingSpec(Account("Assets:Wise"), AMT("-14.94 USD"))],
      meta: {"id": MetaValue(stringValue: "CARD-649346528")},
    );

    expect(transactionExists(transactions, tr), true);
  });
}
