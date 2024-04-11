import 'package:beany_core/core/amount.dart';
import 'package:beany_core/core/core.dart';
import 'package:beany_core/core/currency.dart';
import 'package:beany_core/misc/date.dart';
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
    TransformerBuilderTest<String, Currency>(
      builder: CurrencyTransformerBuilder(),
      testData: [
        TestData("EUR", CUR("EUR")),
        TestData("EURD", CUR("EUR"), shouldFail: true),
      ],
    ),
    TransformerBuilderTest<String, String>(
      builder: StringMatchingTransformerBuilder(),
      testData: [
        TestData("blah", "blah"),
        TestData("blah ", "blah"),
        TestData("blahd", "blah", shouldFail: true),
      ],
    ),
    TransformerBuilderTest<Map<String, String>, Amount>(
      builder: AmountTransformerBuilder(),
      testData: [
        TestData({
          "0": "37.91",
          "1": "EUR",
        }, Amount(D("37.91"), CUR("EUR"))),
        TestData({
          "0": "37.91",
          "1": "Food",
        }, Amount(D("37.91"), CUR("EUR"))),
        TestData({
          "0": "32.90",
          "1": "Food",
        }, Amount(D("37.91"), CUR("EUR")), shouldFail: true),
        TestData({
          "0": "37,91 EUR",
          "1": "Food",
        }, Amount(D("37.91"), CUR("EUR"))),
      ],
    ),
    TransformerBuilderTest<Map<String, String>, Date>(
      builder: MapIteratorTransformerBuilder(
        builder: DateTransformerBuilder(),
      ),
      testData: [
        TestData({
          "0": "45371.0",
          "1": "45371.0",
          "2": "ENDESA ENERGIA S.,Recibo de suministros",
          "3": "-37.91",
          "4": "4009.32",
        }, Date(2024, 03, 20)),
      ],
    ),
  ];

  for (var tbTest in tbTestData) {
    group("${tbTest.builder.runtimeType}", () {
      for (var data in tbTest.testData) {
        test("Number Transformer ${data.input} -> ${data.expectedOutput}", () {
          var builder = tbTest.builder;
          var matchingTrs = builder.build(data.input, data.expectedOutput);
          if (data.shouldFail) {
            expect(matchingTrs, isEmpty);
          } else {
            expect(matchingTrs, isNotEmpty);
            for (var tr in matchingTrs) {
              var out = tr.transform(data.input);
              expect(out, data.expectedOutput);
            }
          }
        });
      }
    });
  }
}
