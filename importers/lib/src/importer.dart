import 'package:beany_core/core/transaction.dart';
import 'package:beany_importer/src/csv_importer.dart';
import 'package:beany_importer/src/csv_utils.dart';
import 'package:beany_importer/src/decision_tree.dart';

class CsvImporter {
  final DecisionNode decisionTree;
  final Map<String, TransactionTransformer> transformers;

  CsvImporter({required this.decisionTree, required this.transformers});

  List<TransactionSpec> run(String csvInput) {
    final rows = parseCsvToMap(csvInput);

    var transactions = <TransactionSpec>[];
    for (var row in rows) {
      var transformerName = decisionTree.classify(row);
      if (transformerName == null) {
        continue;
      }

      var transformer = transformers[transformerName];
      if (transformer == null) {
        throw Exception('No transformer found for $transformerName');
      }
      var transaction = transformer.transform(row);
      transactions.add(transaction);
    }

    return transactions;
  }
}
