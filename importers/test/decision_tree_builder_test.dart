import 'package:beany_importer/src/csv_utils.dart';
import 'package:beany_importer/src/decision_tree.dart';
import 'package:beany_importer/src/decision_tree_builder.dart';
import 'package:beany_importer/src/utils/data_frame.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:test/test.dart';

import 'fixtures/fixtures.dart';

void main() {
  for (var fixture in allFixtures) {
    test(fixture.name, () {
      if (fixture.name == "Trading212" || fixture.name == "Wise") return;

      var tree = buildDecisionTree(
        parseCsvToMap(fixture.csvInput).map((e) => e.toIMap()).toIList(),
        fixture.trData.keys.toList(),
      );

      expect(tree, fixture.decisionTree);
    });
  }

  test('Test entropy with binary labels', () {
    var df = DataFrame.fromArray([
      ['play'],
      ['yes'],
      ['no'],
      ['yes'],
      ['yes'],
    ]);

    double result = entropy(df, 'play');
    expect(result, closeTo(0.811, 0.001));
  });

  test('Test entropy with single label', () {
    var df = DataFrame.fromArray([
      ['play'],
      ['yes'],
      ['yes'],
      ['yes'],
    ]);

    double result = entropy(df, 'play');
    expect(result, equals(0));
  });

  /*
  // FIXME:
  test('Test information gain with two attributes', () {
    var df = DataFrame.fromArray([
      ['outlook', 'play'],
      ['sunny', 'yes'],
      ['overcast', 'yes'],
      ['rainy', 'no'],
      ['sunny', 'no'],
      ['overcast', 'yes'],
    ]);

    double result = informationGain(df, 'play', 'outlook');
    expect(result, closeTo(0.970, 0.001));
  });
  */

  test('Test information gain with no gain', () {
    var df = DataFrame.fromArray([
      ['outlook', 'play'],
      ['sunny', 'yes'],
      ['sunny', 'yes'],
      ['sunny', 'yes'],
    ]);

    double result = informationGain(df, 'play', 'outlook');
    expect(result, equals(0));
  });

  test('Test simple ID3 tree building', () {
    var df = DataFrame.fromArray([
      ['outlook', 'temperature', 'humidity', 'wind', 'decision'],
      ['Sunny', 'Hot', 'High', 'Weak', 'No'],
      ['Sunny', 'Hot', 'High', 'Strong', 'No'],
      ['Overcast', 'Hot', 'High', 'Weak', 'Yes'],
      ['Rain', 'Mild', 'High', 'Weak', 'Yes'],
      ['Rain', 'Cool', 'Normal', 'Weak', 'Yes'],
      ['Rain', 'Cool', 'Normal', 'Strong', 'No'],
      ['Overcast', 'Cool', 'Normal', 'Strong', 'Yes'],
      ['Sunny', 'Mild', 'High', 'Weak', 'No'],
      ['Sunny', 'Cool', 'Normal', 'Weak', 'Yes'],
      ['Rain', 'Mild', 'Normal', 'Weak', 'Yes'],
      ['Sunny', 'Mild', 'Normal', 'Strong', 'Yes'],
      ['Overcast', 'Mild', 'High', 'Strong', 'Yes'],
      ['Overcast', 'Hot', 'Normal', 'Weak', 'Yes'],
      ['Rain', 'Mild', 'High', 'Strong', 'No'],
    ]);

    var tree = id3(
      df,
      IList(['outlook', 'temperature', 'humidity', 'wind']),
      'decision',
    );
    var expectedTree = DecisionEnumNode(
      fieldName: 'outlook',
      branches: {
        'Sunny': DecisionEnumNode(
          fieldName: 'humidity',
          branches: {
            'High': DecisionLeafNode('No'),
            'Normal': DecisionLeafNode('Yes'),
          },
        ),
        'Overcast': DecisionLeafNode('Yes'),
        'Rain': DecisionEnumNode(
          fieldName: 'wind',
          branches: {
            'Weak': DecisionLeafNode('Yes'),
            'Strong': DecisionLeafNode('No'),
          },
        ),
      },
    );
    expect(tree, expectedTree);
  });
}
