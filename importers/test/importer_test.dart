import 'package:beany_core/parser/parser.dart';
import 'package:beany_core/render/render.dart';
import 'package:beany_importer/src/importer.dart';
import 'package:test/test.dart';

import 'fixtures/trading212.dart';

void main() {
  test('Importer', () {
    var fixture = trading212TestData;
    var importer = CsvImporter(
      decisionTree: fixture.decisionTree,
      transformers: fixture.trData.map(
        (key, value) => MapEntry(key, value.transformer),
      ),
    );

    var transactions = importer.run(fixture.csvInput);
    var output = transactions.map((e) => render(e)).join('\n');
    expect(output, _format(fixture.expectedOutput));
  });
}

String _format(String input) {
  var statements = parse(input).all().val().toList();
  return statements.map((e) => render(e)).join('\n');
}
