import 'package:beany_importer/src/csv_importer.dart';
import 'package:beany_importer/src/decision_tree.dart';

class SingleTransformerTestData {
  final String name;
  final String csvInput;
  final String output;
  final TransactionTransformer transformer;

  SingleTransformerTestData({
    required this.name,
    required this.csvInput,
    required this.output,
    required this.transformer,
  });
}

class ImporterTestData {
  final String name;

  /// Maps the transformer name to the test data
  final Map<String, SingleTransformerTestData> trData;
  final String csvHeaders;
  final DecisionNode decisionTree;

  ImporterTestData({
    required this.name,
    required this.trData,
    required this.csvHeaders,
    required this.decisionTree,
  });

  String get csvInput {
    var input = csvHeaders;
    if (!input.endsWith('\n')) {
      input += '\n';
    }

    var lines = trData.values.map((e) => e.csvInput.trim()).join('\n');
    return input + lines;
  }

  String csvInputForTransformer(String transformerName) {
    var input = csvHeaders;
    if (!input.endsWith('\n')) {
      input += '\n';
    }

    var lines = trData[transformerName]!.csvInput.trim();
    return input + lines;
  }

  String get expectedOutput {
    return trData.values.map((e) => e.output).join('\n');
  }
}
