import 'package:beany_importer/src/csv_importer.dart';
import 'package:beany_importer/src/decision_tree.dart';

import 'common.dart';

var _purchase = SingleTransformerTestData(
  csvInput: """
"CARD_TRANSACTION-1279776353",COMPLETED,OUT,"2024-02-26 12:13:29","2024-02-26 12:13:29",0.07,EUR,,,"Vishesh Handa",13.25,EUR,Audible,14.38,USD,1.08530000,,
""",
  name: 'Purchase',
  output: """
2024-02-26 * "Audible"
  id: "CARD_TRANSACTION-1279776353"
  Assets:Wise               -13.25 EUR
  Expenses:BankCharges        0.07 EUR
""",
  transformer: TransactionTransformer(
    dateTransformers: SeqTransformer(
        [MapValueTransformer("3"), DateTransformerFormat('yyyy-MM-dd')]),
    narrationTransformers: MapValueTransformer("12"),
    metaTransformers: [
      MetaDataEntryTransformer(
        keyTransformer: StringTransformerFixed('id'),
        valueTransformer: SeqTransformer([
          MapValueTransformer("0"),
          MetaValueTransformer(),
        ]),
      ),
    ],
    postingTransformers: [
      PostingTransformer(
        accountTransformer: AccountTransformerFixed("Assets:Wise"),
        amountTransformer: AmountTransformer(
          numberTransformer: SeqTransformer([
            MapValueTransformer("10"),
            NumberTransformerDecimalPoint(),
            NumberTransformerFlipSign(),
          ]),
          currencyTransformer: SeqTransformer([
            MapValueTransformer("11"),
            CurrencyTransformer(),
          ]),
        ),
      ),
      PostingTransformer(
        accountTransformer: AccountTransformerFixed("Expenses:BankCharges"),
        amountTransformer: AmountTransformer(
          numberTransformer: SeqTransformer([
            MapValueTransformer("5"),
            NumberTransformerDecimalPoint(),
          ]),
          currencyTransformer: SeqTransformer([
            MapValueTransformer("6"),
            CurrencyTransformer(),
          ]),
        ),
      ),
    ],
  ),
);

var wise0TestData = ImporterTestData(
  name: 'Wise',
  trData: {
    _purchase.name: _purchase,
  },
  csvHeaders: """
0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
""",
  decisionTree: DecisionLeafNode(_purchase.name),
);
