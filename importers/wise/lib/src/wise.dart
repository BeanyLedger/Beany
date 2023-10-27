import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/amount.dart';
import 'package:beany_core/core/balance_statement.dart';
import 'package:beany_core/core/core.dart';
import 'package:beany_core/core/meta_value.dart';
import 'package:beany_core/core/posting.dart';
import 'package:beany_core/core/price_spec.dart';
import 'package:beany_core/core/transaction.dart';
import 'package:beany_core/misc/date.dart';
import 'package:beany_importer_wise/src/deduplicator.dart';

import 'wise_json.dart';

bool wiseFileAlreadyProcessed(
  String jsonInput,
  List<TransactionSpec> transactions,
  DuplicatorConfig duplicatorConfig,
  WiseConverterConfig config,
) {
  var w = Welcome.fromRawJson(jsonInput);
  if (w.transactions.isEmpty) return true;

  var latest = w.transactions.first;
  return transactionExists(
    duplicatorConfig,
    transactions,
    convertWiseTransaction(config, latest),
  );
}

Iterable<Statement> convertWise(
  WiseConverterConfig config,
  String jsonInput,
) {
  var w = Welcome.fromRawJson(jsonInput);
  if (w.transactions.isEmpty) return [];

  return [
    convertWiseTransactionToBalanceStatement(config, w.transactions.first),
    ...w.transactions.map((tr) => convertWiseTransaction(config, tr)),
  ];
}

WiseTransaction parseWiseTransaction(String jsonInput) {
  return WiseTransaction.fromRawJson(jsonInput);
}

class WiseConverterConfig {
  final String baseAccount;
  final String bankChargesAccount;

  WiseConverterConfig(this.baseAccount, this.bankChargesAccount);
}

BalanceStatement convertWiseTransactionToBalanceStatement(
  WiseConverterConfig config,
  WiseTransaction t,
) {
  var date = Date.truncate(
    t.date.toLocal().add(Duration(days: 1)),
  );

  return BalanceStatement(
    date,
    Account(config.baseAccount),
    Amount(D(t.runningBalance.value.toString()), t.runningBalance.currency),
  );
}

TransactionSpec convertWiseTransaction(
  WiseConverterConfig config,
  WiseTransaction t,
) {
  if (t.details.description == "Balance cashback") {
    return _cashBack(config, t);
  }
  if (t.details.rate != null) {
    return _conversion(config, t);
  }
  if (t.type == Type.CREDIT) {
    return _receivedMoney(config, t);
  }
  if (t.type == Type.DEBIT) {
    return _purchase(config, t);
  }

  throw Exception("Unknown Wise Transaction: ${t.toJson()}");
}

Transaction _cashBack(WiseConverterConfig config, WiseTransaction t) {
  return Transaction(
    Date.truncate(t.date.toLocal()),
    TransactionFlag.Okay,
    t.details.description.trim(),
    meta: {
      'id': MetaValue(stringValue: t.referenceNumber),
    },
    postings: [
      Posting(
        Account(config.baseAccount),
        Amount(D(t.amount.value.toString()), t.amount.currency),
      ),
    ],
  );
}

Transaction _purchase(WiseConverterConfig config, WiseTransaction t) {
  var narration =
      t.details.merchant?.name ?? t.details.originator ?? t.details.description;

  return Transaction(
    Date.truncate(t.date.toLocal()),
    TransactionFlag.Okay,
    narration,
    meta: {
      'id': MetaValue(stringValue: t.referenceNumber),
    },
    postings: [
      Posting(
        Account(config.baseAccount),
        Amount(D(t.amount.value.toString()), t.amount.currency),
      ),
    ],
  );
}

TransactionSpec _conversion(WiseConverterConfig config, WiseTransaction t) {
  var source = t.details.sourceAmount!;
  var target = t.details.targetAmount!;

  return TransactionSpec(
    Date.truncate(t.date.toLocal()),
    TransactionFlag.Okay,
    t.details.description,
    // narration: t.details.description,
    meta: {
      'id': MetaValue(stringValue: t.referenceNumber),
    },
    postings: [
      Posting(
        Account(config.baseAccount),
        Amount(D(source.value.toString()).abs() * D("-1"), source.currency),
        priceSpec: Price(
          amountPer: Amount(
            D(t.details.rate.toString()),
            target.currency,
          ),
        ),
      ),
      PostingSpec(
        Account(config.bankChargesAccount),
        Amount(D(t.totalFees.value.toString()), t.totalFees.currency),
        priceSpec: PriceSpec(
          amountTotal: AmountSpec(null, target.currency),
        ),
      ),
      Posting(
        Account(config.baseAccount),
        Amount(
          D(target.value.toString()),
          target.currency,
        ),
      ),
    ],
  );
}

Transaction _receivedMoney(WiseConverterConfig config, WiseTransaction t) {
  return Transaction(
    Date.truncate(t.date.toLocal()),
    TransactionFlag.Okay,
    t.details.description,
    meta: {
      'id': MetaValue(stringValue: t.referenceNumber),
    },
    postings: [
      Posting(
        Account(config.baseAccount),
        Amount(D(t.amount.value.toString()), t.amount.currency),
      ),
    ],
  );
}
