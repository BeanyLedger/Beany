import 'dart:math';

/*

So the brancher takes the following input:

- A list of csv rows
- A list of transactions
- A Transformer for converting the csv row to a transaction

Step 1: Reduce the number of transformers to the minimum
  - If there are clear duplicates, then remove those
  - See if there are any transformers that can be combined to work for both inputs, how?
    - I guess, the Transformer Builders should give multiple Transformers
    - This way it'll be easier to slim down the transformers

Step 2:
  - Get the list of non-used fields in any of the transformers
    - See if that enum value can be used to make a decision
    - If yes, you're good to go

    - These are essentially heuristics for feature selection
      - One heuristic is if the field has a different value per transaction
        as with that there is a large chance of overfitting

  - Another way would be to make the decision based on if a field is present or not
    - What constitues a field being present?
      - If it's not 0.0 or empty string
      - I think with these two conditions we should be good?

  - What about a DecisionTreeNode for when a field == a particular value
    for say 'N/A'

  - The next step would be to build a 2 level decision tree
  - I think I like that I at least have something like a DecisionNode


Deposit,2022-03-10 07:39:09,,,,,,,,1000.00,,,1000.00,"Bank Transfer",40459ed3-7f6c-442d-a288-1fcf7ca0a73b,
Dividend (Ordinary),2022-04-06 07:39:19,IE00B3XXRP09,VUSA,"Vanguard S&P 500 (Dist)",10.0000000000,0.20,GBP,Not available,2.36,-0.00,GBP,,,,
Market buy,2022-05-13 08:20:23,IE00B3XXRP09,VUSA,"Vanguard S&P 500 (Dist)",3.3000000000,61.74,GBP,0.85166,239.59,,,,,EOF1908601484,0.36
*/

// Practical Example
// Use Trading212
// -> It has 3 different kinds of operations

// Create a full serialization format
// for a complete transformer
// This would include both the Transformers and the TransformerDecisionTree
// What should I call it?
// Maybe just an Importer?

// Step 1:
// For [ Map<String, String> -> List<Transformer> ]
// try to reduce the list of transformers to the minimum
// a. Just do a simple equality of transformers, after simplification
// b. Can one transformer be combined with another? How?

// Step 2:
// Convert these into a Map<String, Transformer> so that each
// unique transformer is given a name
// Also, I guess for the List<Transformer> we just take the first one

// Step 3:
// You have [ Map<String, String> -> TransformerName ]

// We could try to simplify the features
// -> all the fields used as numbers should be converted to a boolean (true/false)
// -> for when they are present, and when they are not

// If the field always has the same value, then it's of no use, and we can remove it

import 'package:beany_importer/src/decision_tree.dart';
import 'package:beany_importer/src/utils/data_frame.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

double entropy(DataFrame df, String targetColumn) {
  // Count label occurrences
  var labelCounts = df.valueCounts(targetColumn).values.toList();
  int total = labelCounts.fold(0, (sum, count) => sum + count);
  double entropy = 0.0;

  for (var count in labelCounts) {
    double probability = count / total;
    entropy -= probability * log(probability) / ln2;
  }
  return entropy;
}

double informationGain(DataFrame df, String targetColumn, String attribute) {
  double totalEntropy = entropy(df, targetColumn);
  double subsetsEntropy = 0.0;
  int totalSize = df.nrows;

  // Group by the attribute
  var grouped = df.groupBy(attribute);

  for (var groupEntry in grouped.entries) {
    var df = groupEntry.value;
    double subsetEntropy = entropy(df, targetColumn);
    subsetsEntropy += (df.nrows / totalSize) * subsetEntropy;
  }

  return totalEntropy - subsetsEntropy;
}

DecisionNode id3(
  DataFrame df,
  IList<String> attributes,
  String targetColumn,
) {
  // Base cases
  var labels = df.column(targetColumn).toISet();
  if (labels.length == 1) {
    return DecisionLeafNode(labels.first);
  }

  if (attributes.isEmpty) {
    throw Exception("No attributes left to split on");
    // var mostCommonLabel = df.mode([targetColumn]).row(0)[0];
    // return TreeNode(label: mostCommonLabel);
  }

  // Choose best attribute
  String bestAttribute = '';
  double bestGain = -1;
  for (var attribute in attributes) {
    double gain = informationGain(df, targetColumn, attribute);
    if (gain > bestGain) {
      bestGain = gain;
      bestAttribute = attribute;
    }
    // FIXME: Maybe there should be a better criteria for 'best'
    //        Some kind of hueuristic, on each field which can be used to figure out
    //        when there are multiple options
    //        - At the end of the day, this is also creating multiple trees
  }

  // Create normal ID3 node
  var children = <String, DecisionNode>{};
  var grouped = df.groupBy(bestAttribute);

  for (var group in grouped.entries) {
    var value = group.key;
    // var subset = group.value.removeColumn(bestAttribute);
    var newAttributes = attributes.remove(bestAttribute);
    children[value] = id3(group.value, newAttributes, targetColumn);
  }

  return DecisionEnumNode(fieldName: bestAttribute, branches: children);
}

DecisionNode buildDecisionTree(
  IList<IMap<String, String>> input,
  List<String> transformerNames,
) {
  if (input.isEmpty) {
    throw ArgumentError("No input data");
  }
  if (transformerNames.length != input.length) {
    throw ArgumentError(
        "Number of transformer names should match the number of input rows");
  }

  // Convert the input to a DataFrame
  var data = <List<String>>[
    [...input.first.keys, 'Transformer']
  ];
  for (var i = 0; i < input.length; i++) {
    var map = input[i];
    var row = <String>[];
    for (var entry in map.entries) {
      row.add(entry.value);
    }
    row.add(transformerNames[i]);
    data.add(row);
  }
  var df = DataFrame.fromArray(data);

  var attributes = input.first.keys;
  return id3(df, attributes.toIList(), 'Transformer');
}
