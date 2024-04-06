import 'package:beany_core/parser/parser.dart';
import 'package:beany_core/render/render.dart';
import 'package:beany_importer/src/csv_utils.dart';
import 'package:test/test.dart';

import 'fixtures/trading212.dart';

var fixtures = [
  trading212TestData,
];

void main() {
  for (var fixture in fixtures) {
    group(fixture.name, () {
      for (var trTest in fixture.trData.values) {
        test(trTest.name, () {
          final input = _parseCsvRow0(trTest.csvInput);

          var t = trTest.transformer;
          var actualOutput = render(t.transform(input));
          expect(actualOutput, _format(trTest.output));
        });
      }
    });
  }
}

Map<String, String> _parseCsvRow0(String csvInput) {
  return parseCsvToMapInventHeaders(csvInput)[0];
}

String _format(String input) {
  var statements = parse(input).all().val().toList();
  return statements.map((e) => render(e)).join('\n');
}
