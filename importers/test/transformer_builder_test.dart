import 'package:beany_core/core/core.dart';
import 'package:beany_core/misc/date.dart';
import 'package:beany_importer/src/csv_importer.dart';
import 'package:beany_importer/src/transformer_builder.dart';
import 'package:decimal/decimal.dart';
import 'package:test/test.dart';

class TestData<INP, OUT> {
  final INP input;
  final OUT expectedOutput;
  final bool shouldFail;

  TestData(this.input, this.expectedOutput, {this.shouldFail = false});
}

void main() {
  group("Date Transformer", () {
    var dateTestData = <TestData<String, Date>>[
      TestData("45371.0", Date(2024, 03, 20)),
      TestData("1.0", Date(2024, 03, 20), shouldFail: true),
      TestData("31-Jan-2011", Date(2011, 01, 31)),
    ];

    for (var data in dateTestData) {
      test("Date Transformer ${data.input} -> ${data.expectedOutput}", () {
        var builder = DateTransformerBuilder();
        var trC = builder.build(data.input, data.expectedOutput);
        if (data.shouldFail) {
          expect(trC, isEmpty);
        } else {
          var out = applyTransformers(trC, data.input);
          expect(out, data.expectedOutput);
        }
      });
    }
  });

  group("Number Transformer", () {
    var numberTestData = <TestData<String, Decimal>>[
      TestData("37.91", D("37.91")),
      TestData("44.333,22", D("44333.22")),
      TestData("22D", D("44333.22"), shouldFail: true),
    ];

    for (var data in numberTestData) {
      test("Number Transformer ${data.input} -> ${data.expectedOutput}", () {
        var trC = buildNumberTransformerChain(data.input, data.expectedOutput);
        if (data.shouldFail) {
          expect(trC, isEmpty);
        } else {
          var out = applyTransformers<String, Decimal>(trC, data.input);
          expect(out, data.expectedOutput);
        }
      });
    }
  });

  group("CSV to Date Transformer Builder", () {
    var csvTestData = <TestData<List<String>, Date>>[
      TestData([
        "45371.0",
        "45371.0",
        "ENDESA ENERGIA S.,Recibo de suministros",
        "-37.91",
        "4009.32"
      ], Date(2024, 03, 20)),
    ];

    for (var data in csvTestData) {
      test(
          "List<String> to Date Transformer ${data.input} -> ${data.expectedOutput}",
          () {
        var builder = ListIteratorTransformerBuilder(
          builder: DateTransformerBuilder(),
        );
        var trC = builder.build(data.input, data.expectedOutput);
        if (data.shouldFail) {
          expect(trC, isEmpty);
        } else {
          var out = applyTransformers(trC, data.input);
          expect(out, data.expectedOutput);
        }
      });
    }
  });
}
