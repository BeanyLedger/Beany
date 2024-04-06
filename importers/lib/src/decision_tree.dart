import 'package:beany_core/core/transaction.dart';
import 'package:beany_importer/src/csv_importer.dart';
import 'package:beany_importer/src/csv_utils.dart';
import 'package:equatable/equatable.dart';

abstract class DecisionNode extends Equatable {
  bool get isLeaf;

  DecisionNode decide(Map<String, String> input);

  String? classify(Map<String, String> input) {
    var currentNode = this;
    while (!currentNode.isLeaf) {
      currentNode = currentNode.decide(input);
    }
    return switch (currentNode) {
      (DecisionLeafNode leaf) => leaf.transformerName,
      DecisionLeafNodeSkip() => null,
      _ => throw Exception('Unknown DecisionNode type'),
    };
  }
}

class DecisionLeafNode extends DecisionNode {
  final String transformerName;

  DecisionLeafNode(this.transformerName);

  @override
  bool get isLeaf => true;

  @override
  DecisionNode decide(Map<String, String> input) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [transformerName];
}

class DecisionLeafNodeSkip extends DecisionNode {
  @override
  bool get isLeaf => true;

  @override
  DecisionNode decide(Map<String, String> input) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [];
}

class DecisionEnumNode extends DecisionNode {
  final String fieldName;
  final Map<String, DecisionNode> branches;

  DecisionEnumNode({required this.fieldName, required this.branches});

  @override
  bool get isLeaf => false;

  @override
  DecisionNode decide(Map<String, String> input) {
    var field = input[fieldName];
    if (field == null) {
      throw Exception('Field $fieldName not found in input');
    }
    var branch = branches[field];
    if (branch == null) {
      throw Exception('No branch found for field $field');
    }
    return branch;
  }

  @override
  List<Object?> get props => [fieldName, branches];
}

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
