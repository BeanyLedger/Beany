import 'package:beany_core/parser/parser.dart';
import 'package:beany_core/render/render.dart';
import 'package:beany_importer/src/csv_importer.dart';
import 'package:beany_importer/src/csv_utils.dart';
import 'package:test/test.dart';

void main() {
  test('LaCaixa', () {
    var csvInput =
        "45371.0,45371.0,ENDESA ENERGIA S.,Recibo de suministros,-37.91,4009.32";
    final input = parseCsvRow0(csvInput);

    final importer = TransactionTransformer(
      dateTransformers: SeqTransformer([
        MapValueTransformer("0"),
        DateTransformerExcel(),
      ]),
      narrationTransformers: MapValueTransformer("2"),
      commentsTransformers: MapValueTransformer("3"),
      postingTransformers: [
        PostingTransformer(
          accountTransformer: AccountTransformerFixed("Assets:LaCaixa"),
          amountTransformer: AmountTransformer(
            numberTransformer: SeqTransformer([
              MapValueTransformer("4"),
              NumberTransformerDecimalPoint(),
            ]),
            currencyTransformer: CurrencyTransformerFixed('EUR'),
          ),
        ),
      ],
    );

    final expectedOutput = """
2024-03-20 * "ENDESA ENERGIA S."
  ; Recibo de suministros
  Assets:LaCaixa   -37.91 EUR
""";

    var actualOutput = render(importer.transform(input));
    expect(actualOutput, _format(expectedOutput));
  });

  test('Amazon', () {
    var csvInput =
        "404-7319078-6347502,3 Scale Home Brew Hydrometer Wine Beer Cider Alcohol Testing Making Tester; ,Vishesh Handa,2019-06-24,\"EUR 2,34\",N/A,N/A,N/A,N/A,";
    final input = parseCsvRow0(csvInput);

    final importer = TransactionTransformer(
      dateTransformers: SeqTransformer([
        MapValueTransformer("3"),
        DateTransformerFormat('yyyy-MM-dd'),
      ]),
      narrationTransformers: SeqTransformer([
        MapValueTransformer("1"),
        StringTrimmingTransformer(),
      ]),
      metaTransformers: [
        MetaDataTransformer(
          keyTransformer: StringTransformerFixed('orderId'),
          valueTransformer: MapValueTransformer("0"),
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
    );

    final expectedOutput = """
2019-06-24 * "3 Scale Home Brew Hydrometer Wine Beer Cider Alcohol Testing Making Tester;"
  orderId: "404-7319078-6347502"
  Expenses:Amazon  2.34 EUR
""";

    var actualOutput = render(importer.transform(input));
    expect(actualOutput, _format(expectedOutput));
  });

  test('N26 Deposit', () {
    var csvInput = """
Deposit,2022-03-10 07:39:09,,,,,,,,1000.00,,,1000.00,"Bank Transfer",40459ed3-7f6c-442d-a288-1fcf7ca0a73b,
""";
    final input = parseCsvRow0(csvInput);

    final importer = TransactionTransformer(
      dateTransformers: SeqTransformer([
        MapValueTransformer("1"),
        DateTransformerFormat('yyyy-MM-dd HH:mm:ss'),
      ]),
      narrationTransformers: MapValueTransformer("0"),
      payeeTransformers: MapValueTransformer("13"),
      metaTransformers: [
        MetaDataTransformer(
          keyTransformer: StringTransformerFixed('id'),
          valueTransformer: MapValueTransformer("14"),
        ),
      ],
      postingTransformers: [
        PostingTransformer(
          accountTransformer: AccountTransformerFixed("Assets:N26"),
          amountTransformer: AmountTransformer(
            numberTransformer: SeqTransformer([
              MapValueTransformer("9"),
              NumberTransformerDecimalPoint(),
            ]),
            currencyTransformer: CurrencyTransformerFixed('EUR'),
          ),
        ),
      ],
    );

    final expectedOutput = """
2022-03-10 * "Deposit" "Bank Transfer"
  id: "40459ed3-7f6c-442d-a288-1fcf7ca0a73b"
  Assets:N26  1000.00 EUR
""";

    var actualOutput = render(importer.transform(input));
    expect(actualOutput, _format(expectedOutput));
  });

  test('N26 Market Buy', () {
    var csvInput = """
Market buy,2022-03-11 13:39:01,IE00B3XXRP09,VUSA,"Vanguard S&P 500 ETF",10.0000000000,62.43,GBP,0.83977,744.47,,,,,EOF1828459892,1.12
""";
    final input = parseCsvRow0(csvInput);

    final importer = TransactionTransformer(
      dateTransformers: SeqTransformer([
        MapValueTransformer("1"),
        DateTransformerFormat('yyyy-MM-dd HH:mm:ss'),
      ]),
      narrationTransformers: MapValueTransformer("0"),
      payeeTransformers: MapValueTransformer("4"),
      metaTransformers: [
        MetaDataTransformer(
          keyTransformer: StringTransformerFixed('isin'),
          valueTransformer: MapValueTransformer("2"),
        ),
        MetaDataTransformer(
          keyTransformer: StringTransformerFixed('id'),
          valueTransformer: MapValueTransformer("14"),
        ),
      ],
      postingTransformers: [
        PostingTransformer(
          accountTransformer: AccountTransformerFixed("Assets:N26"),
          amountTransformer: AmountTransformer(
            numberTransformer: SeqTransformer([
              MapValueTransformer("5"),
              NumberTransformerDecimalPoint(),
            ]),
            currencyTransformer: SeqTransformer([
              MapValueTransformer("3"),
              CurrencyTransformer(),
            ]),
          ),
          costSpecTransformer: SeqTransformer([
            MapValueTransformer("9"),
            NumberTransformerDecimalPoint(),
            CostSpecTotalTransformer(currency: 'EUR'),
          ]),
        ),
      ],
    );

    final expectedOutput = """
2022-03-11 * "Market buy" "Vanguard S&P 500 ETF"
  isin: "IE00B3XXRP09"
  id: "EOF1828459892"
  Assets:N26  10.00 VUSA {{ 744.47 EUR }}
""";

    var actualOutput = render(importer.transform(input));
    expect(actualOutput, _format(expectedOutput));
  });

  test("N26 Divident", () {
    var csvInput = """
Dividend (Ordinary),2022-04-06 07:39:19,IE00B3XXRP09,VUSA,"Vanguard S&P 500 (Dist)",10.0000000000,0.20,GBP,Not available,2.36,-0.00,GBP,,,,
""";
    final input = parseCsvRow0(csvInput);

    final importer = TransactionTransformer(
      dateTransformers: SeqTransformer([
        MapValueTransformer("1"),
        DateTransformerFormat('yyyy-MM-dd'),
      ]),
      narrationTransformers: MapValueTransformer("0"),
      payeeTransformers: MapValueTransformer("4"),
      postingTransformers: [
        PostingTransformer(
          accountTransformer: AccountTransformerFixed("Income:Dividends"),
          amountTransformer: AmountTransformer(
            numberTransformer: SeqTransformer([
              MapValueTransformer("9"),
              NumberTransformerDecimalPoint(),
              NumberTransformerFlipSign(),
            ]),
            currencyTransformer: CurrencyTransformerFixed('EUR'),
          ),
        ),
        PostingTransformer(
          accountTransformer: AccountTransformerFixed("Assets:Trading212"),
        ),
      ],
    );

    final expectedOutput = """
2022-04-06 * "Dividend (Ordinary)" "Vanguard S&P 500 (Dist)"
    Income:Dividends  -2.36 EUR
    Assets:Trading212
""";

    var actualOutput = render(importer.transform(input));
    expect(actualOutput, _format(expectedOutput));
  });

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

  test('Wise complex test', () {
    var csvInput = """
"CARD_TRANSACTION-1279776353",COMPLETED,OUT,"2024-02-26 12:13:29","2024-02-26 12:13:29",0.07,EUR,,,"Vishesh Handa",13.25,EUR,Audible,14.38,USD,1.08530000,,
""";
    final input = parseCsvRow0(csvInput);

    final importer = TransactionTransformer(
      dateTransformers: SeqTransformer(
          [MapValueTransformer("3"), DateTransformerFormat('yyyy-MM-dd')]),
      narrationTransformers: MapValueTransformer("12"),
      metaTransformers: [
        MetaDataTransformer(
          keyTransformer: StringTransformerFixed('id'),
          valueTransformer: MapValueTransformer("0"),
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
    );

    final expectedOutput = """
2024-02-26 * "Audible"
  id: "CARD_TRANSACTION-1279776353"
  Assets:Wise               -13.25 EUR
  Expenses:BankCharges        0.07 EUR
""";

    var actualOutput = render(importer.transform(input));
    expect(actualOutput, _format(expectedOutput));
  });

  test('operator ==', () {
    final importer1 = TransactionTransformer(
      dateTransformers: SeqTransformer([
        MapValueTransformer("0"),
        DateTransformerExcel(),
      ]),
      narrationTransformers: MapValueTransformer("2"),
      commentsTransformers: MapValueTransformer("3"),
      postingTransformers: [
        PostingTransformer(
          accountTransformer: AccountTransformerFixed("Assets:LaCaixa"),
          amountTransformer: AmountTransformer(
            numberTransformer: SeqTransformer([
              MapValueTransformer("4"),
              NumberTransformerDecimalPoint(),
            ]),
            currencyTransformer: CurrencyTransformerFixed('EUR'),
          ),
        ),
      ],
    );
    final importer2 = TransactionTransformer(
      dateTransformers: SeqTransformer([
        MapValueTransformer("0"),
        DateTransformerExcel(),
      ]),
      narrationTransformers: MapValueTransformer("2"),
      commentsTransformers: MapValueTransformer("3"),
      postingTransformers: [
        PostingTransformer(
          accountTransformer: AccountTransformerFixed("Assets:LaCaixa"),
          amountTransformer: AmountTransformer(
            numberTransformer: SeqTransformer([
              MapValueTransformer("4"),
              NumberTransformerDecimalPoint(),
            ]),
            currencyTransformer: CurrencyTransformerFixed('EUR'),
          ),
        ),
      ],
    );
    expect(importer1 == importer2, isTrue);
  });
}

Map<String, String> parseCsvRow0(String csvInput) {
  return parseCsvToMapInventHeaders(csvInput)[0];
}

String _format(String input) {
  var statements = parse(input).all().val().toList();
  return statements.map((e) => render(e)).join('\n');
}
