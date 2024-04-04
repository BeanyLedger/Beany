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
      posting0AccountTransformers: [
        AccountTransformerFixed("Assets:Personal:Spain:LaCaixa")
      ],
      posting0AmountTransformers: [
        CsvIndexPosTransformer(4),
        NumberTransformerDecimalPoint()
      ],
      posting0CurrencyTransformers: [StringTransformerFixed('EUR')],
    );

    final expectedOutput = """
2024-03-20 * "ENDESA ENERGIA S."
  ; Recibo de suministros
  Assets:Personal:Spain:LaCaixa   -37.91 EUR
""";

    var actualOutput = render(importer.apply(input));
    expect(actualOutput, _format(expectedOutput));
  });
}

String _format(String input) {
  var statements = parse(input).all().val().toList();
  return statements.map((e) => render(e)).join('\n');
}
