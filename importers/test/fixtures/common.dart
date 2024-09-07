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
  final List<SingleTransformerTestData> trData;
  final String csvHeaders;
  final DecisionNode decisionTree;

  ImporterTestData({
    required this.name,
    required this.trData,
    required this.csvHeaders,
    required this.decisionTree,
  }) {
    assert(!csvHeaders.contains('\n'));
  }

  Map<String, TransactionTransformer> toTransformerByNameMap() {
    // e.name is not unique
    return {for (var e in trData) e.name: e.transformer};
  }

  String get csvInput {
    var lines = trData.map((e) => e.csvInput.trim()).join('\n');
    return '$csvHeaders\n$lines';
  }

  String get expectedOutput {
    return trData.map((e) => e.output).join('\n');
  }
}
