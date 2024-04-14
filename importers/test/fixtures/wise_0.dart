import 'package:beany_importer/src/csv_importer.dart';
import 'package:beany_importer/src/decision_tree.dart';

import 'common.dart';

var _purchase0 = SingleTransformerTestData(
  csvInput: """
"CARD_TRANSACTION-1279776353",COMPLETED,OUT,"2024-02-26 12:13:29","2024-02-26 12:13:29",0.07,EUR,,,"Vishesh Handa",13.25,EUR,Audible,14.38,USD,1.08530000,,
""",
  name: 'Purchase0',
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

var _purchase1 = SingleTransformerTestData(
  csvInput: """
"CARD_TRANSACTION-1352812512",COMPLETED,OUT,"2024-03-30 18:55:30","2024-03-30 18:55:30",0.00,EUR,,,"Vishesh Handa",8.90,EUR,"Sifan Sumi 2018 Sl",8.90,EUR,1.00000000,,
""",
  name: 'Purchase1',
  output: """
2024-03-30 * "Sifan Sumi 2018 Sl"
  id: "CARD_TRANSACTION-1352812512"
  Assets:Wise  -8.90 EUR
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
    ],
  ),
);

var _purchase2 = SingleTransformerTestData(
  csvInput: """
"CARD_TRANSACTION-1279776353",COMPLETED,OUT,"2024-02-26 12:13:29","2024-02-26 12:13:29",0.00,USD,,,"Vishesh Handa",0.56,USD,Audible,0.56,USD,1.00000000,,
""",
  name: 'Purchase2',
  output: """
2024-02-26 * "Audible"
  id: "CARD_TRANSACTION-1279776353"
  Assets:Wise  -0.56 USD
""",
  transformer: _purchase1.transformer,
);

var _income = SingleTransformerTestData(
  csvInput: """
TRANSFER-996241724,COMPLETED,IN,"2024-03-11 18:06:56","2024-03-11 18:07:02",4.14,USD,,,"MEDL CORPORATION",7195.86,USD,"Vishesh Handa",7195.86,USD,1.0,,
""",
  name: 'Income',
  output: """
2024-03-11 * "MEDL CORPORATION"
  id: "TRANSFER-996241724"
  Assets:Wise           7195.86 USD
  Expenses:BankCharges     4.14 USD
  """,
  transformer: TransactionTransformer(
    dateTransformers: SeqTransformer(
        [MapValueTransformer("3"), DateTransformerFormat('yyyy-MM-dd')]),
    narrationTransformers: MapValueTransformer("9"),
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
    _purchase0.name: _purchase0,
    _purchase1.name: _purchase1,
    _purchase2.name: _purchase2,
    _income.name: _income,
  },
  csvHeaders: """
0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
""",
  decisionTree: DecisionEnumNode(fieldName: "2", branches: {
    "OUT": DecisionFieldExistsNode(
      fieldName: "5",
      existsBranch: DecisionLeafNode(_purchase0.name),
      notExistsBranch: DecisionLeafNode(_purchase1.name),
    ),
    "IN": DecisionLeafNode(_income.name),
  }),
);
