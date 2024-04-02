import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/amount.dart';
import 'package:beany_core/core/core.dart';
import 'package:beany_core/core/meta_value.dart';
import 'package:beany_core/core/posting.dart';
import 'package:beany_core/core/price_spec.dart';
import 'package:beany_core/core/transaction.dart';
import 'package:beany_core/misc/date.dart';
import 'package:beany_importer/src/deduplicator.dart';

import 'package:csv/csv.dart';
import 'package:intl/intl.dart';

class WiseTransaction {
  String id;
  String status;
  String direction;
  DateTime createdOn;
  DateTime finishedOn;
  String? sourceFeeAmount;
  String? sourceFeeCurrency;
  String? targetFeeAmount;
  String? targetFeeCurrency;
  String? sourceName;
  String? sourceAmountAfterFees;
  String? sourceCurrency;
  String? targetName;
  String? targetAmountAfterFees;
  String? targetCurrency;
  String? exchangeRate;
  String? reference;
  String? batch;

  WiseTransaction({
    required this.id,
    required this.status,
    required this.direction,
    required this.createdOn,
    required this.finishedOn,
    required this.sourceFeeAmount,
    required this.sourceFeeCurrency,
    required this.targetFeeAmount,
    required this.targetFeeCurrency,
    required this.sourceName,
    required this.sourceAmountAfterFees,
    required this.sourceCurrency,
    required this.targetName,
    required this.targetAmountAfterFees,
    required this.targetCurrency,
    required this.exchangeRate,
    required this.reference,
    required this.batch,
  });

  // Parsing a single CSV row
  factory WiseTransaction.fromCsvRow(List<dynamic> row) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    return WiseTransaction(
      id: row[0],
      status: row[1],
      direction: row[2],
      createdOn: dateFormat.parse(row[3]),
      finishedOn: dateFormat.parse(row[4]),
      sourceFeeAmount: row[5],
      sourceFeeCurrency: row[6],
      targetFeeAmount: row[7],
      targetFeeCurrency: row[8],
      sourceName: row[9],
      sourceAmountAfterFees: row[10],
      sourceCurrency: row[11],
      targetName: row[12],
      targetAmountAfterFees: row[13],
      targetCurrency: row[14],
      exchangeRate: row[15],
      reference: row[16],
      batch: row[17],
    );
  }

  @override
  String toString() {
    return 'WiseTransaction{id: $id, status: $status, direction: $direction, createdOn: $createdOn, finishedOn: $finishedOn, sourceFeeAmount: $sourceFeeAmount, sourceFeeCurrency: $sourceFeeCurrency, targetFeeAmount: $targetFeeAmount, targetFeeCurrency: $targetFeeCurrency, sourceName: $sourceName, sourceAmountAfterFees: $sourceAmountAfterFees, sourceCurrency: $sourceCurrency, targetName: $targetName, targetAmountAfterFees: $targetAmountAfterFees, targetCurrency: $targetCurrency, exchangeRate: $exchangeRate, reference: $reference, batch: $batch}';
  }
}

List<WiseTransaction> parseWiseTransactions(String csvInput) {
  final rows = const CsvToListConverter().convert(
    csvInput,
    eol: '\n',
    fieldDelimiter: ',',
    shouldParseNumbers: false,
  );
  if (rows.isEmpty) return [];

  List<WiseTransaction> wiseTransactions = [];
  for (int i = 1; i < rows.length; i++) {
    final tr = WiseTransaction.fromCsvRow(rows[i]);
    wiseTransactions.add(tr);
  }
  return wiseTransactions;
}

bool wiseFileAlreadyProcessed(
  String csvInput,
  List<TransactionSpec> transactions,
  DuplicatorConfig duplicatorConfig,
  WiseConverterConfig config,
) {
  final wiseTransactions = parseWiseTransactions(csvInput);
  if (wiseTransactions.isEmpty) return true;

  var latest = wiseTransactions.first;
  return transactionExists(
    duplicatorConfig,
    transactions,
    convertWiseTransaction(config, latest),
  );
}

Iterable<Statement> convertWise(
  WiseConverterConfig config,
  String csvInput,
) {
  final wiseTransactions = parseWiseTransactions(csvInput);
  return [
    // convertWiseTransactionToBalanceStatement(config, w.transactions.first),
    ...wiseTransactions.map((tr) => convertWiseTransaction(config, tr)),
  ];
}

class WiseConverterConfig {
  final String baseAccount;
  final String bankChargesAccount;

  WiseConverterConfig(this.baseAccount, this.bankChargesAccount);
}

/*
BalanceStatement convertWiseTransactionToBalanceStatement(
  WiseConverterConfig config,
  WiseTransaction t,
) {
  var date = Date.truncate(
    t.createdOn.toLocal().add(Duration(days: 1)),
  );

  return BalanceStatement(
    date,
    Account(config.baseAccount),
    Amount(D(t..value.toString()), t.runningBalance.currency),
  );
}
*/

TransactionSpec convertWiseTransaction(
  WiseConverterConfig config,
  WiseTransaction t,
) {
  if (t.reference == "BALANCE CASHBACK") {
    return _cashBack(config, t);
  }

  if (t.direction == "IN") {
    return _receivedMoney(config, t);
  }
  if (t.direction == "OUT") {
    return _purchase(config, t);
  }
  if (t.direction == "NEUTRAL") {
    return _conversion(config, t);
  }

  throw Exception("Unknown Wise Transaction: $t");
}

Transaction _cashBack(WiseConverterConfig config, WiseTransaction t) {
  return Transaction(
    Date.truncate(t.createdOn.toLocal()),
    TransactionFlag.Okay,
    t.reference!,
    meta: {
      'id': MetaValue(stringValue: t.id),
    },
    postings: [
      Posting(
        Account(config.baseAccount),
        Amount(D(t.targetAmountAfterFees!), t.targetCurrency!),
      ),
    ],
  );
}

Transaction _purchase(WiseConverterConfig config, WiseTransaction t) {
  var narration = t.targetName!;

  return Transaction(
    Date.truncate(t.createdOn.toLocal()),
    TransactionFlag.Okay,
    narration,
    meta: {
      'id': MetaValue(stringValue: t.id),
    },
    postings: [
      Posting(
        Account(config.baseAccount),
        Amount(-D(t.sourceAmountAfterFees!), t.sourceCurrency!),
      ),
      if (t.sourceFeeAmount != null &&
          t.sourceFeeAmount != "" &&
          t.sourceFeeAmount != "0.00")
        Posting(
          Account(config.bankChargesAccount),
          Amount(D(t.sourceFeeAmount!), t.sourceFeeCurrency!),
        ),
    ],
  );
}

TransactionSpec _conversion(WiseConverterConfig config, WiseTransaction t) {
  return TransactionSpec(
    Date.truncate(t.createdOn.toLocal()),
    TransactionFlag.Okay,
    "Currency Conversion",
    // narration: t.details.description,
    meta: {
      'id': MetaValue(stringValue: t.id),
    },
    postings: [
      Posting(
        Account(config.baseAccount),
        Amount(D(t.sourceAmountAfterFees!).abs() * D("-1"), t.sourceCurrency!),
        priceSpec: Price(
          amountPer: Amount(
            D(t.exchangeRate!),
            t.targetCurrency!,
          ),
        ),
      ),
      PostingSpec(
        Account(config.bankChargesAccount),
        Amount(D(t.sourceFeeAmount!), t.sourceFeeCurrency!),
        // priceSpec: PriceSpec(
        // amountTotal: AmountSpec(null, t.targetCurrency!),
        // ),
      ),
      Posting(
        Account(config.baseAccount),
        Amount(
          D(t.targetAmountAfterFees!),
          t.targetCurrency!,
        ),
      ),
    ],
  );
}

Transaction _receivedMoney(WiseConverterConfig config, WiseTransaction t) {
  return Transaction(
    Date.truncate(t.createdOn.toLocal()),
    TransactionFlag.Okay,
    t.reference!,
    payee: t.sourceName,
    meta: {
      'id': MetaValue(stringValue: t.id),
    },
    postings: [
      Posting(
        Account(config.baseAccount),
        Amount(D(t.targetAmountAfterFees!), t.targetCurrency!),
      ),
    ],
  );
}
