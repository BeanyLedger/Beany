import 'package:beany_core/core/core.dart';
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
            currencyTransformer: CurrencyTransformerFixed(CUR('EUR')),
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
            currencyTransformer: CurrencyTransformerFixed(CUR('EUR')),
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
            currencyTransformer: CurrencyTransformerFixed(CUR('EUR')),
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
