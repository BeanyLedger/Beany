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

      if (trList.isEmpty) {
        throw Exception(
            "There should be at least one transformer. $input $out");
      }
      transformerMatrix.add(trList);
    }

    // 3. Name the transformers and all
    var transformersList = selectTransformers(transformerMatrix);
    var transformersByName = _nameTransformers(transformersList);

    // In order to build the decision tree we need the expected output for each row
    var outputNames = <String>[];
    for (var tr in transformersList) {
      for (var x in transformersByName.entries) {
        if (x.value == tr) {
          outputNames.add(x.key);
          break;
        }
      }
    }

    // 4. Create the DecisionTree
    var decisionTree = buildDecisionTree(
      inputRows.map((e) => IMap(e)).toIList(),
      outputNames,
    );

    // 5. Return it
    return CsvImporter(
      transformers: transformersByName,
      decisionTree: decisionTree,
      trainingDataHeaders: inputRows.first.keys.toList(),
    );
  }
}

Map<String, TransactionTransformer> _nameTransformers(
  List<TransactionTransformer> transformers,
) {
  // Remove duplicates
  var trSet = transformers.toSet();

  var transformersByName = <String, TransactionTransformer>{};
  var i = 0;
  for (var tr in trSet) {
    transformersByName["tr-$i"] = tr;
    i++;
  }

  return transformersByName;
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
