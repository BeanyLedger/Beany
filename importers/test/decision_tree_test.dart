import 'package:beany_importer/src/csv_utils.dart';
import 'package:beany_importer/src/decision_tree.dart';
import 'package:test/test.dart';

void main() {
  test('DecisionTree', () {
    var csvInput = """
Action,Time,ISIN,Ticker,Name,No. of shares,Price / share,Currency (Price / share),Exchange rate,Total (EUR),Withholding tax,Currency (Withholding tax),Charge amount (EUR),Notes,ID,Currency conversion fee (EUR)
Deposit,2022-03-10 07:39:09,,,,,,,,1000.00,,,1000.00,"Bank Transfer",40459ed3-7f6c-442d-a288-1fcf7ca0a73b,
Dividend (Ordinary),2022-04-06 07:39:19,IE00B3XXRP09,VUSA,"Vanguard S&P 500 (Dist)",10.0000000000,0.20,GBP,Not available,2.36,-0.00,GBP,,,,
Market buy,2022-05-13 08:20:23,IE00B3XXRP09,VUSA,"Vanguard S&P 500 (Dist)",3.3000000000,61.74,GBP,0.85166,239.59,,,,,EOF1908601484,0.36
""";

    var tree = DecisionEnumNode(fieldName: 'Action', branches: {
      'Deposit': DecisionLeafNode('Deposit'),
      'Dividend (Ordinary)': DecisionLeafNode('Dividend'),
      'Market buy': DecisionLeafNode('Buy'),
    });

    var input = parseCsvToMap(csvInput);
    expect(tree.classify(input[0]), 'Deposit');
    expect(tree.classify(input[1]), 'Dividend');
    expect(tree.classify(input[2]), 'Buy');
  });
}
