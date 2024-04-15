import 'package:beany_importer/src/transformers.dart';
import 'package:beany_importer/src/decision_tree.dart';
import 'package:beany_importer/src/transformers_numbers.dart';

import 'common.dart';

var _purcahse0 = SingleTransformerTestData(
  name: 'Purchase',
  csvInput:
      "404-7319078-6347502,3 Scale Home Brew Hydrometer Wine Beer Cider Alcohol Testing Making Tester; ,Vishesh Handa,2019-06-24,\"EUR 2,34\",N/A,N/A,N/A,N/A,",
  output: """
2019-06-24 * "3 Scale Home Brew Hydrometer Wine Beer Cider Alcohol Testing Making Tester;"
  orderId: "404-7319078-6347502"
  Expenses:Amazon  2.34 EUR
""",
  transformer: TransactionTransformer(
    dateTransformers: SeqTransformer([
      MapValueTransformer("3"),
      DateTransformerFormat('yyyy-MM-dd'),
    ]),
    narrationTransformers: SeqTransformer([
      MapValueTransformer("1"),
      StringTrimmingTransformer(),
    ]),
    metaTransformers: [
      MetaDataEntryTransformer(
        keyTransformer: StringTransformerFixed('orderId'),
        valueTransformer: SeqTransformer([
          MapValueTransformer("0"),
          MetaValueTransformer(),
        ]),
      ),
    ],
    postingTransformers: [
      PostingTransformer(
        accountTransformer: AccountTransformerFixed("Expenses:Amazon"),
        amountTransformer: AmountTransformer(
          numberTransformer: SeqTransformer([
            MapValueTransformer("4"),
            StringSplittingTransformer(1, expectedParts: 2, separator: ' '),
            NumberTransformerDecimalComma(),
          ]),
          currencyTransformer: SeqTransformer([
            MapValueTransformer("4"),
            StringSplittingTransformer(0, expectedParts: 2, separator: ' '),
            CurrencyTransformer(),
          ]),
        ),
      ),
    ],
  ),
);

var amazonTestData = ImporterTestData(
  name: 'Amazon',
  trData: {
    _purcahse0.name: _purcahse0,
  },
  csvHeaders: """
0, 1, 2, 3, 4, 5, 6, 7, 8, 9
""",
  decisionTree: DecisionLeafNode(_purcahse0.name),
);
