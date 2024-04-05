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

class TransformerBuilderTest<INP, OUT> {
  TransformerBuilder<INP, OUT> builder;
  List<TestData<INP, OUT>> testData;

  TransformerBuilderTest({required this.builder, required this.testData});
}

void main() {
  var tbTestData = [
    TransformerBuilderTest<String, Date>(
      builder: DateTransformerBuilder(),
      testData: [
        TestData("45371.0", Date(2024, 03, 20)),
        TestData("1.0", Date(2024, 03, 20), shouldFail: true),
        TestData("31-Jan-2011", Date(2011, 01, 31)),
      ],
    ),
    TransformerBuilderTest<String, Decimal>(
      builder: NumberTransformerBuilder(),
      testData: [
        TestData("37.91", D("37.91")),
        TestData("44.333,22", D("44333.22")),
        TestData("22D", D("44333.22"), shouldFail: true),
      ],
    ),
    TransformerBuilderTest<List<String>, Date>(
      builder: ListIteratorTransformerBuilder(
        builder: DateTransformerBuilder(),
      ),
      testData: [
        TestData([
          "45371.0",
          "45371.0",
          "ENDESA ENERGIA S.,Recibo de suministros",
          "-37.91",
          "4009.32"
        ], Date(2024, 03, 20)),
      ],
    ),
  ];

  group("Transformer", () {
    for (var tbTest in tbTestData) {
      group("${tbTest.builder.runtimeType}", () {
        for (var data in tbTest.testData) {
          test("Number Transformer ${data.input} -> ${data.expectedOutput}",
              () {
            var builder = tbTest.builder;
            var trC = builder.build(data.input, data.expectedOutput);
            if (data.shouldFail) {
              expect(trC, isEmpty);
            } else {
              var tr = ChainedListTransformer(trC);
              var out = tr.transform(data.input);
              expect(out, data.expectedOutput);
            }
          });
        }
      });
    }
  });
}
