import 'package:beany_core/core/transaction.dart';
import 'package:beany_core/parser/parser.dart';
import 'package:beany_importer/src/csv_utils.dart';
import 'package:beany_importer/src/decision_tree_builder.dart';
import 'package:beany_importer/src/importer.dart';
import 'package:beany_importer/src/transformer_builder.dart';
import 'package:beany_importer/src/transformers_transaction.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class CsvImporterBuilder {
  final String csvInput;
  final String output;

  CsvImporterBuilder({
    required this.csvInput,
    required this.output,
  });

  CsvImporter build() {
    // Get the csv input + transaction match
    var inputRows = parseCsvToMap(csvInput);
    var outputStatements = parse(output).all().val().toList();
    var outputTransactions =
        outputStatements.whereType<TransactionSpec>().toList();
    if (outputStatements.length != outputTransactions.length) {
      throw Exception("All output statements should be transactions");
    }
    if (outputTransactions.isEmpty) {
      throw Exception("There should be at least one transaction");
    }
    if (inputRows.isEmpty) {
      throw Exception("There should be at least one row in the input");
    }
    if (inputRows.length != outputTransactions.length) {
      throw Exception(
          "The number of input rows should match the number of transactions");
    }

    // Build a Transformer for each of them
    var transformerMatrix = <List<TransactionTransformer>>[];
    for (var i = 0; i < inputRows.length; i++) {
      var input = inputRows[i];
      var out = outputTransactions[i];

      var builder = TransactionTransformerBuilder();
      var trList =
          builder.build(input, out).toList().cast<TransactionTransformer>();

      transformerMatrix.add(trList);
    }

    // 3. Name the transformers and all
    var transformers = _nameTransformers(
      selectTransformers(transformerMatrix),
    );

    // 4. Create the DecisionTree
    var decisionTree = buildDecisionTree(
      inputRows.map((e) => IMap(e)).toIList(),
      transformers.keys.toList(),
    );

    // 5. Return it
    return CsvImporter(
      transformers: transformers,
      decisionTree: decisionTree,
    );
  }
}

Map<String, TransactionTransformer> _nameTransformers(
  List<TransactionTransformer> transformers,
) {
  var names = <String, TransactionTransformer>{};
  for (var i = 0; i < transformers.length; i++) {
    var tr = transformers[i];
    var name = "tr-$i";
    names[name] = tr;
  }
  return names;
}

List<TransactionTransformer> selectTransformers(
  List<List<TransactionTransformer>> trMatrix,
) {
  trMatrix =
      trMatrix.map((list) => list.map((tr) => tr.simplify()).toList()).toList();

  // One should remove duplicates in a trList
  // the main thing is how 1 transformer is considered a duplicate of another

  // Setup scores for all to be zero
  var scores = <List<int>>[];
  for (var i = 0; i < trMatrix.length; i++) {
    var trList = trMatrix[i];
    var row = <int>[];
    for (var j = 0; j < trList.length; j++) {
      row.add(0);
    }
    scores.add(row);
  }

  // Give each one a score depending on if there are other transformers in other rows
  for (var i = 0; i < trMatrix.length; i++) {
    var trList = trMatrix[i];
    for (var j = 0; j < trList.length; j++) {
      var tr = trList[j];
      scores[i][j] += _computeScore(trMatrix, tr, i);
    }
  }

  // Select the best transformer for each row
  var selected = <TransactionTransformer>[];
  for (var i = 0; i < trMatrix.length; i++) {
    var trList = trMatrix[i];
    var bestTr = _highestScore(trList, scores[i]);

    selected.add(bestTr);
  }

  // Remove duplicates
  selected = selected.toSet().toList();

  return selected;
}

TransactionTransformer _highestScore(
  List<TransactionTransformer> trList,
  List<int> scores,
) {
  var bestScore = 0;
  var bestTr = trList.first;
  for (var i = 1; i < trList.length; i++) {
    var tr = trList[i];
    var score = scores[i];
    if (score > bestScore) {
      bestScore = score;
      bestTr = tr;
    }
  }
  return bestTr;
}

int _computeScore(
  List<List<TransactionTransformer>> trMatrix,
  TransactionTransformer tr,
  int row,
) {
  var score = 0;

  for (var i = 0; i < trMatrix.length; i++) {
    if (i == row) {
      continue;
    }
    var otherTrList = trMatrix[i];
    for (var j = 0; j < otherTrList.length; j++) {
      var otherTr = otherTrList[j];
      if (tr == otherTr) {
        score += 1;
        break;
      }
    }
  }

  return score;
}
