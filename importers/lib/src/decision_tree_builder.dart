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
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

IList<IMap<String, String>> simplifyFeatures(
  IList<IMap<String, String>> input,
) {
  // Maybe it would be nice to convert this into some kind of data frame
  // Lets try it without DataFrames and then compare the code

  // 1. Validate the input.
  var keys = input.first.keys.toISet();
  for (var row in input) {
    if (row.keys.toISet() != keys) {
      throw Exception("All rows should have the same keys");
    }
  }

  // 2. Remove the columns where the value is always the same
  for (var key in keys) {
    var values = input.map((row) => row[key]).toISet();
    if (values.length == 1) {
      input = input.map((map) => map.remove(key)).toIList();
    }
  }
  keys = input.first.keys.toISet();

  // 3. Remove columns where another columns' value is the same
  for (var i = 0; i < keys.length; i++) {
    for (var j = i + 1; j < keys.length; j++) {
      var key1 = keys[i];
      var key2 = keys[j];
      var values1 = input.map((row) => row[key1]).toISet();
      var values2 = input.map((row) => row[key2]).toISet();
      if (values1 == values2) {
        input = input.map((map) => map.remove(key2)).toIList();
      }
    }
  }
  keys = input.first.keys.toISet();

  // 4. Convert all numerical fields to boolean
  //    This is easy to do when the column is a normal decimal
  //    what about when it has a currency attached?

  // 5. How to Handle currencies?
  // 6. How to handle dates?

  return input;
}

DecisionNode buildDecisionTree(
  IList<IMap<String, String>> input,
  List<String> transformerNames,
) {
  // 1. Simplify the features
  input = simplifyFeatures(input);

  // 2. Build the Decision Tree
  //    For each key, build a Decision
  if (transformerNames.isEmpty) {
    throw Exception("No transformers provided");
  }
  if (transformerNames.length == 1) {
    return DecisionLeafNode(transformerNames.first);
  }

  throw Exception("Not implemented");
}
