import 'package:beany_core/core/core.dart';
import 'package:beany_importer/src/transformers.dart';
import 'package:beany_importer/src/decision_tree.dart';
import 'package:beany_importer/src/transformers_cost.dart';
import 'package:beany_importer/src/transformers_numbers.dart';

import 'common.dart';

/*
Headers

0: Action
1: Time
2: ISIN
3: Ticker
4: Name
5: No. of shares
6: Price / share
7: Currency (Price / share)
8: Exchange rate
9: Total (EUR)
10: Withholding tax
11: Currency (Withholding tax)
12: Charge amount (EUR)
13: Notes
14: ID
15: Currency conversion fee (EUR)

*/

var _deposit = SingleTransformerTestData(
  name: 'Deposit',
  csvInput: """
Deposit,2022-03-10 07:39:09,,,,,,,,1000.00,,,1000.00,"Bank Transfer",40459ed3-7f6c-442d-a288-1fcf7ca0a73b,
""",
  output: """
2022-03-10 * "Deposit" "Bank Transfer"
  id: "40459ed3-7f6c-442d-a288-1fcf7ca0a73b"
  Assets:N26  1000.00 EUR
""",
  transformer: TransactionTransformer(
    dateTransformers: SeqTransformer([
      MapValueTransformer("Time"),
      DateTransformerFormat('yyyy-MM-dd'),
    ]),
    narrationTransformers: MapValueTransformer("Action"),
    payeeTransformers: MapValueTransformer("Notes"),
    metaTransformers: [
      MetaDataEntryTransformer(
        keyTransformer: StringTransformerFixed('id'),
        valueTransformer: SeqTransformer([
          MapValueTransformer("ID"),
          MetaValueTransformer(),
        ]),
      ),
    ],
    postingTransformers: [
      PostingTransformer(
        accountTransformer: AccountTransformerFixed("Assets:N26"),
        amountTransformer: AmountTransformer(
          numberTransformer: SeqTransformer([
            MapValueTransformer("Total (EUR)"),
            NumberTransformerDecimalPoint(),
          ]),
          currencyTransformer: CurrencyTransformerFixed(CUR('EUR')),
        ),
      ),
    ],
  ),
);

var _marketBuy = SingleTransformerTestData(
  name: 'MarketBuy',
  csvInput: """
Market buy,2022-03-11 13:39:01,IE00B3XXRP09,VUSA,"Vanguard S&P 500 ETF",10.0000000000,62.43,GBP,0.83977,744.47,,,,,EOF1828459892,1.12
""",
  output: """
2022-03-11 * "Market buy" "Vanguard S&P 500 ETF"
  isin: "IE00B3XXRP09"
  id: "EOF1828459892"
  Assets:N26  10.00 VUSA {{ 744.47 EUR }}
""",
  transformer: TransactionTransformer(
    dateTransformers: SeqTransformer([
      MapValueTransformer("Time"),
      DateTransformerFormat('yyyy-MM-dd HH:mm:ss'),
    ]),
    narrationTransformers: MapValueTransformer("Action"),
    payeeTransformers: MapValueTransformer("Name"),
    metaTransformers: [
      MetaDataEntryTransformer(
        keyTransformer: StringTransformerFixed('isin'),
        valueTransformer: SeqTransformer([
          MapValueTransformer("ISIN"),
          MetaValueTransformer(),
        ]),
      ),
      MetaDataEntryTransformer(
        keyTransformer: StringTransformerFixed('id'),
        valueTransformer: SeqTransformer([
          MapValueTransformer("ID"),
          MetaValueTransformer(),
        ]),
      ),
    ],
    postingTransformers: [
      PostingTransformer(
        accountTransformer: AccountTransformerFixed("Assets:N26"),
        amountTransformer: AmountTransformer(
          numberTransformer: SeqTransformer([
            MapValueTransformer("No. of shares"),
            NumberTransformerDecimalPoint(),
          ]),
          currencyTransformer: SeqTransformer([
            MapValueTransformer("Ticker"),
            CurrencyTransformer(),
          ]),
        ),
        costSpecTransformer: SeqTransformer([
          MapValueTransformer("Total (EUR)"),
          NumberTransformerDecimalPoint(),
          CostSpecTotalTransformer(currency: CUR('EUR')),
        ]),
      ),
    ],
  ),
);

var _dividend = SingleTransformerTestData(
  name: 'Dividend',
  csvInput: """
Dividend (Ordinary),2022-04-06 07:39:19,IE00B3XXRP09,VUSA,"Vanguard S&P 500 (Dist)",10.0000000000,0.20,GBP,Not available,2.36,-0.00,GBP,,,,
""",
  output: """
2022-04-06 * "Dividend (Ordinary)" "Vanguard S&P 500 (Dist)"
    Income:Dividends  -2.36 EUR
    Assets:Trading212
""",
  transformer: TransactionTransformer(
    dateTransformers: SeqTransformer([
      MapValueTransformer("Time"),
      DateTransformerFormat('yyyy-MM-dd'),
    ]),
    narrationTransformers: MapValueTransformer("Action"),
    payeeTransformers: MapValueTransformer("Name"),
    postingTransformers: [
      PostingTransformer(
        accountTransformer: AccountTransformerFixed("Income:Dividends"),
        amountTransformer: AmountTransformer(
          numberTransformer: SeqTransformer([
            MapValueTransformer("Total (EUR)"),
            NumberTransformerDecimalPoint(),
            NumberTransformerFlipSign(),
          ]),
          currencyTransformer: CurrencyTransformerFixed(CUR('EUR')),
        ),
      ),
      PostingTransformer(
        accountTransformer: AccountTransformerFixed("Assets:Trading212"),
      ),
    ],
  ),
);

// Add test for withdrawl
// Withdrawal,2023-02-10 12:11:34,,,,,,,,,982.96,"Sent to Bank Account BE70967069118425",4ba269d2-535c-4344-84d2-abc0e2022d7d,
/*
2023-02-10 * "Withdrawal"
    Assets:Personal:Trading212  -982.96 EUR
    Assets:ZeroSum:BankTransfer
  */

/*
  Market sell,2023-02-10 12:10:50,IE00B3XXRP09,VUSA,"Vanguard S&P 500 (Dist)",13.3000000000,63.52,GBP,0.88370,-26.63,954.52,,EOF2263033364,1.43
2023-02-10 * "Market Sell" "Vanguard S&P 500 (Dist)"
    Assets:Personal:Trading212  -13.30 IE00B3XXRP09 {}
    Assets:Personal:Trading212  954.52 EUR
    Income:Trading
    */

var trading212TestData = ImporterTestData(
  name: 'Trading212',
  trData: {
    _deposit.name: _deposit,
    _marketBuy.name: _marketBuy,
    _dividend.name: _dividend,
  },
  csvHeaders: """
Action,Time,ISIN,Ticker,Name,No. of shares,Price / share,Currency (Price / share),Exchange rate,Total (EUR),Withholding tax,Currency (Withholding tax),Charge amount (EUR),Notes,ID,Currency conversion fee (EUR)
""",
  decisionTree: DecisionEnumNode(fieldName: 'Action', branches: {
    'Deposit': DecisionLeafNode(_deposit.name),
    'Dividend (Ordinary)': DecisionLeafNode(_dividend.name),
    'Market buy': DecisionLeafNode(_marketBuy.name),
  }),
);
