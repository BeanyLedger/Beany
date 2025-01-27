import 'package:beany_core/core/transaction.dart';
import 'package:beany_importer/src/transformers.dart';
import 'package:beany_importer/src/csv_utils.dart';
import 'package:beany_importer/src/decision_tree.dart';
import 'package:collection/collection.dart';

class CsvImporter {
  final DecisionNode decisionTree;
  final Map<String, TransactionTransformer> transformers;
  final List<String> csvTrainingDataHeaders;

  CsvImporter({
    required this.decisionTree,
    required this.transformers,
    required List<String> trainingDataHeaders,
  }) : csvTrainingDataHeaders =
            trainingDataHeaders.map((e) => e.trim()).toList();

  List<TransactionSpec> run(String csvInput) {
    final rows = parseCsvToMap(csvInput);
    if (rows.isEmpty) {
      throw Exception("There should be atleast be a row");
    }
    final inputHeaders = rows.first.keys.toList();

    Function deepEq = const DeepCollectionEquality().equals;
    if (!deepEq(inputHeaders, csvTrainingDataHeaders)) {
      throw CsvHeadersMismatchException(
        inputHeaders: inputHeaders,
        csvTrainingDataHeaders: csvTrainingDataHeaders,
      );
    }

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

class CsvHeadersMismatchException implements Exception {
  final List<String> inputHeaders;
  final List<String> csvTrainingDataHeaders;

  CsvHeadersMismatchException({
    required this.inputHeaders,
    required this.csvTrainingDataHeaders,
  });

  @override
  String toString() {
    return 'The csv input file headers do not match the training headers. '
        'Expected: $csvTrainingDataHeaders, got: $inputHeaders';
  }
}
