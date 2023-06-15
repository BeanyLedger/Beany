import 'dart:io';

import 'package:beany/core/posting.dart';
import 'package:beany/core/transaction.dart';
import 'package:beany/importer/deduplicator.dart';
import 'package:beany/importer/simple_categorizer.dart';
import 'package:beany/importer/wise.dart';
import 'package:beany/misc/date.dart';

import 'package:beany/parser/parser.dart';
import 'package:beany/render/render.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:yaml/yaml.dart';

class WiseConfig {
  final String dataFolder;
  final String token;
  final String certificatePEM;
  final String rulesFile;

  final String outputFile;
  final String baseAccount;
  final String bankChargesAccount;

  // final String timezone;

  WiseConfig({
    required this.dataFolder,
    required this.token,
    required this.certificatePEM,
    required this.rulesFile,
    required this.outputFile,
    required this.baseAccount,
    required this.bankChargesAccount,
  });
}

Date fetchLatestDate(String outputFile) {
  return Date.today();
}

List<String> inputFiles(String dataFolder) {
  var dir = Directory(dataFolder);
  if (dir.existsSync()) {
    return dir.listSync().map((e) => e.path).toList();
  }

  return [];
}

Future<void> process(WiseConfig config) async {
  var transactionsToAdd = <TransactionSpec>[];
  var outputFileContents = File(config.outputFile).readAsStringSync();
  var existingTransactions = parse(outputFileContents)
      .all()
      .val()
      .whereType<TransactionSpec>()
      .toList();

  var duplicatorConfig = DuplicatorConfig(config.baseAccount);

  for (var inputFile in inputFiles(config.dataFolder)) {
    if (!inputFile.endsWith(".json")) continue;
    var file = File(inputFile);
    var content = await file.readAsString();

    var transactions = convertWise(
      WiseConverterConfig(config.baseAccount, config.bankChargesAccount),
      content,
    );
    var count = 0;
    for (var t in transactions) {
      if (t is! TransactionSpec) continue;
      if (!transactionExists(duplicatorConfig, existingTransactions, t)) {
        transactionsToAdd.add(t);
        count++;
      }
    }

    if (count != 0) {
      print("$inputFile -");
      print("\t Found: $count transactions");
    }
  }

  print("A total of ${transactionsToAdd.length}");

  // Add missing Posting if required
  var rulesContent = File(config.rulesFile).readAsStringSync();
  var classifier = SimpleCategorizer(rulesContent);

  for (var i = 0; i < transactionsToAdd.length; i++) {
    var t = transactionsToAdd[i];
    if (!t.canResolve) continue;
    var act = classifier.classify(t.resolve());
    if (act == null) continue;

    var postings = t.postings.cast<PostingSpec>().toIList();
    t = t.toSpec().copyWith(postings: postings.add(PostingSpec(act, null)));
    transactionsToAdd[i] = t;
  }

  // Make sure all of them are balanced!!

  // Add them to the output file!
  transactionsToAdd.sort();
  var toAdd = transactionsToAdd.reversed;
  var output = renderPretty(toAdd.map((tr) => tr.resolve()));
  print("Extra output $output");
  await File(config.outputFile).writeAsString(output + outputFileContents);
}

void main() async {
  var yamlConfig = File("beany.yaml").readAsStringSync();
  var config = loadYaml(yamlConfig);
  if (config is! Map) {
    throw Exception("Invalid config file");
  }

  var wiseConfigMap = config["importers"]["wise"];
  if (wiseConfigMap is! Map) {
    throw Exception("Invalid config file - wise importer missing");
  }

  var wiseConfig = WiseConfig(
    dataFolder: wiseConfigMap["dataFolder"],
    token: wiseConfigMap["token"],
    certificatePEM: wiseConfigMap["certificatePem"],
    rulesFile: wiseConfigMap["rulesFile"],
    outputFile: wiseConfigMap["outputFile"],
    bankChargesAccount: wiseConfigMap["bankChargesAccount"],
    baseAccount: wiseConfigMap["baseAccount"],
  );

  process(wiseConfig);
}

/*
* Read each file and give all the transactions
  -> Convert each into a Transaction
  -> Remove the ones that are already present in the ledger
  -> The ones that are left
     -> Categorize them
     -> Add them

  -> Prepend them to the output

* Get latest transactions
  -> Get last date_time for each account
*/

