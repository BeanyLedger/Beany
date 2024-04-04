import 'package:beany_core/parser/parser.dart';
import 'package:beany_core/render/render.dart';
import 'package:beany_importer/src/csv_importer.dart';
import 'package:beany_importer/src/wise.dart';
import 'package:csv/csv.dart';
import 'package:test/test.dart';

var config = WiseConverterConfig("Assets:Wise", "Expenses:BankCharges");

void main() {
  test('Test Working', () {
    var csvInput =
        "45371.0,45371.0,ENDESA ENERGIA S.,Recibo de suministros,-37.91,4009.32";
    final rows = const CsvToListConverter().convert(
      csvInput,
      eol: '\n',
      fieldDelimiter: ',',
      shouldParseNumbers: false,
    );
    final row = rows[0];

    final importer = TrainedData(
      dateIndex: 0,
      dateTransformer: DateTransformerExcel(),
      narrationIndex: 2,
      narrationTransformer: StringTransformerNone(),
      payeeIndex: -1,
      payeeTransformer: StringTransformerNone(),
      meta0Index: -1,
      meta0Transformer: StringTransformerNone(),
      meta1Index: -1,
      meta1Transformer: StringTransformerNone(),
      meta2Index: -1,
      meta2Transformer: StringTransformerNone(),
      posting0AccountIndex: 0,
      posting0AccountTransformer:
          AccountTransformerFixed("Assets:Personal:Spain:LaCaixa"),
      posting0AmountIndex: 4,
      posting0AmountTransformer: NumberTransformerDecimalPoint(),
      posting0CurrencyIndex: 0,
      posting0CurrencyTransformer: StringTransformerFixed('EUR'),
    );

    final expectedOutput = """
2024-03-20 * "ENDESA ENERGIA S."
    Assets:Personal:Spain:LaCaixa   -37.91 EUR
""";

    var actualOutput = render(importer.apply(row));
    expect(actualOutput, _format(expectedOutput));
  });
}

String _format(String input) {
  var statements = parse(input).all().val().toList();
  return statements.map((e) => render(e)).join('\n');
}
