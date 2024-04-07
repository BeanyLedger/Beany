import 'package:beany_core/parser/parser.dart';
import 'package:beany_core/render/render.dart';
import 'package:beany_importer/src/csv_utils.dart';
import 'package:test/test.dart';

import 'fixtures/fixtures.dart';

void main() {
  for (var fixture in allFixtures) {
    group(fixture.name, () {
      for (var trTest in fixture.trData.values) {
        test(trTest.name, () {
          final csvInput = fixture.csvInputForTransformer(trTest.name);
          final input = parseCsvToMap(csvInput).first;

          var t = trTest.transformer;
          var actualOutput = render(t.transform(input));
          expect(actualOutput, _format(trTest.output));
        });
      }
    });
  }
}

String _format(String input) {
  var statements = parse(input).all().val().toList();
  return statements.map((e) => render(e)).join('\n');
}
