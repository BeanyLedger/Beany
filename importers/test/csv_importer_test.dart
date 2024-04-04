import 'package:beany_core/parser/parser.dart';
import 'package:beany_core/render/render.dart';
import 'package:beany_importer/src/csv_importer.dart';
import 'package:beany_importer/src/wise.dart';
import 'package:csv/csv.dart';
import 'package:test/test.dart';

var config = WiseConverterConfig("Assets:Wise", "Expenses:BankCharges");

void main() {
  test('LaCaixa', () {
    var csvInput =
        "45371.0,45371.0,ENDESA ENERGIA S.,Recibo de suministros,-37.91,4009.32";
    final input = parseCsvRow0(csvInput);

    final importer = TransactionTransformer(
      dateTransformers: [CsvIndexPosTransformer(0), DateTransformerExcel()],
      narrationTransformers: [CsvIndexPosTransformer(2)],
      commentsTransformers: [CsvIndexPosTransformer(3)],
      postingTransformers: [
        PostingTransformer(
          accountTransformers: [
            AccountTransformerFixed("Assets:Personal:Spain:LaCaixa")
          ],
          amountTransformers: [
            CsvIndexPosTransformer(4),
            NumberTransformerDecimalPoint()
          ],
          currencyTransformers: [StringTransformerFixed('EUR')],
        ),
      ],
    );

    final expectedOutput = """
2024-03-20 * "ENDESA ENERGIA S."
  ; Recibo de suministros
  Assets:Personal:Spain:LaCaixa   -37.91 EUR
""";

    var actualOutput = render(importer.apply(input));
    expect(actualOutput, _format(expectedOutput));
  });

  test('Amazon', () {
    var csvInput =
        "404-7319078-6347502,3 Scale Home Brew Hydrometer Wine Beer Cider Alcohol Testing Making Tester; ,Vishesh Handa,2019-06-24,\"EUR 2,34\",N/A,N/A,N/A,N/A,";
    final input = parseCsvRow0(csvInput);

    final importer = TransactionTransformer(
      dateTransformers: [
        CsvIndexPosTransformer(3),
        DateTransformerFormat('yyyy-MM-dd')
      ],
      narrationTransformers: [
        CsvIndexPosTransformer(1),
        StringTrimmingTransformer()
      ],
      meta0KeyTransformer: [StringTransformerFixed('orderId')],
      meta0ValueTransformer: [CsvIndexPosTransformer(0)],
      postingTransformers: [
        PostingTransformer(
          accountTransformers: [AccountTransformerFixed("Expenses:Amazon")],
          amountTransformers: [
            CsvIndexPosTransformer(4),
            StringSplittingTransformer(1, expectedParts: 2, separator: ' '),
            NumberTransformerDecimalComma()
          ],
          currencyTransformers: [
            CsvIndexPosTransformer(4),
            StringSplittingTransformer(0, expectedParts: 2, separator: ' '),
          ],
        ),
      ],
    );

    final expectedOutput = """
2019-06-24 * "3 Scale Home Brew Hydrometer Wine Beer Cider Alcohol Testing Making Tester;"
  orderId: "404-7319078-6347502"
  Expenses:Amazon  2.34 EUR
""";

    var actualOutput = render(importer.apply(input));
    expect(actualOutput, _format(expectedOutput));
  });

  test('N26 Deposit', () {
    var csvInput = """
Deposit,2022-03-10 07:39:09,,,,,,,,1000.00,,,1000.00,"Bank Transfer",40459ed3-7f6c-442d-a288-1fcf7ca0a73b,
""";
    final input = parseCsvRow0(csvInput);

    final importer = TransactionTransformer(
      dateTransformers: [
        CsvIndexPosTransformer(1),
        DateTransformerFormat('yyyy-MM-dd HH:mm:ss')
      ],
      narrationTransformers: [CsvIndexPosTransformer(0)],
      payeeTransformers: [CsvIndexPosTransformer(13)],
      meta0KeyTransformer: [StringTransformerFixed('id')],
      meta0ValueTransformer: [CsvIndexPosTransformer(14)],
      postingTransformers: [
        PostingTransformer(
          accountTransformers: [AccountTransformerFixed("Assets:N26")],
          amountTransformers: [
            CsvIndexPosTransformer(9),
            NumberTransformerDecimalPoint()
          ],
          currencyTransformers: [StringTransformerFixed('EUR')],
        ),
      ],
    );

    final expectedOutput = """
2022-03-10 * "Deposit" "Bank Transfer"
  id: "40459ed3-7f6c-442d-a288-1fcf7ca0a73b"
  Assets:N26  1000.00 EUR
""";

    var actualOutput = render(importer.apply(input));
    expect(actualOutput, _format(expectedOutput));
  });
}

List<String> parseCsvRow0(String csvInput) {
  final rows = const CsvToListConverter().convert(
    csvInput,
    eol: '\n',
    fieldDelimiter: ',',
    shouldParseNumbers: false,
  );
  return rows[0].map((e) => e.toString()).toList();
}

String _format(String input) {
  var statements = parse(input).all().val().toList();
  return statements.map((e) => render(e)).join('\n');
}
