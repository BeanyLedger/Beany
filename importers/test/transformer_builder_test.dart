import 'package:beany_core/core/core.dart';
import 'package:beany_core/misc/date.dart';
import 'package:beany_importer/src/csv_importer.dart';
import 'package:beany_importer/src/transformer_builder.dart';
import 'package:decimal/decimal.dart';
import 'package:test/test.dart';

void main() {
  test('Date Transformer Excel', () {
    var inp = "45371.0";
    var out = Date(2024, 03, 20);

    var trChain = [buildDateTransformer(inp, out)!];
    var actualOutput = applyTransformers<String, Date>(trChain, inp);
    expect(actualOutput, out);
  });

  test('Date Transformer Excel Bad', () {
    var inp = "1.0";
    var out = Date(2024, 03, 20);

    var tr = buildDateTransformer(inp, out);
    expect(tr, isNull);
  });

  test('Number Transformer', () {
    var inp = "37.91";
    var out = D("37.91");

    var trChain = buildNumberTransformerChain(inp, out);
    var actualOutput = applyTransformers<String, Decimal>(trChain, inp);
    expect(actualOutput, out);
  });

  test('Number Transformer with comma', () {
    var inp = "44.333,22";
    var out = D("44333.22");

    var trChain = buildNumberTransformerChain(inp, out);
    var actualOutput = applyTransformers<String, Decimal>(trChain, inp);
    expect(actualOutput, out);
  });
}
