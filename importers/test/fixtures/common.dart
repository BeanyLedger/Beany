import 'package:beany_core/core/transaction.dart';
import 'package:beany_core/parser/parser.dart';
import 'package:beany_importer/src/transformers.dart';
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

  TransactionSpec get transactionSpec {
    var statements = parse(output).all().val().toList();
    if (statements.length != 1) {
      throw Exception('Expected 1 statement, got ${statements.length}');
    }
    var st = statements[0];
    if (st is! TransactionSpec) {
      throw Exception('Expected TransactionSpec, got ${st.runtimeType}');
    }
    return st;
  }
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
    if (trData[transformerName] == null) {
      throw Exception('Transformer $transformerName not found in fixture');
    }
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
