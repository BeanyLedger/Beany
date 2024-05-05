import 'package:beany_core/parser/parser.dart';
import 'package:beany_core/render/render.dart';
import 'package:beany_importer/src/importer_builder.dart';
import 'package:test/test.dart';

import 'fixtures/fixtures.dart';

void main() {
  for (var fixture in allFixtures) {
    test(fixture.name, () {
      // FIXME: Stop skipping these tests
      if (fixture.name == "Wise") return;

      var builder = CsvImporterBuilder(
        csvInput: fixture.csvInput,
        output: fixture.expectedOutput,
      );
      var importer = builder.build();

      var transactions = importer.run(fixture.csvInput);
      var output = transactions.map((e) => render(e)).join('\n');
      expect(output, _format(fixture.expectedOutput));
    });
  }
}

String _format(String input) {
  var statements = parse(input).all().val().toList();
  return statements.map((e) => render(e)).join('\n');
}
