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
