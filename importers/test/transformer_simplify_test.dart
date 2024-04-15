import 'package:beany_importer/src/transformers.dart';
import 'package:test/test.dart';

void main() {
  test('NoOp', () {
    var tr = SeqTransformer<String, String>([
      MapValueTransformer("ID"),
      NoOpTransformer<String>(),
    ]);
    var trSimplified = SeqTransformer<String, String>([
      MapValueTransformer("ID"),
    ]);
    expect(tr.simplify(), trSimplified);
  });

  test('SeqTransformer', () {
    var tr = SeqTransformer<String, String>([
      MapValueTransformer("ID"),
      SeqTransformer<String, String>([
        NoOpTransformer<String>(),
        StringTrimmingTransformer(),
      ]),
    ]);
    var trSimplified = SeqTransformer<String, String>([
      MapValueTransformer("ID"),
      StringTrimmingTransformer(),
    ]);
    expect(tr.simplify(), trSimplified);
  });

  test("PostingTransformer", () {
    var postingTr = PostingTransformer(
      accountTransformer: AccountTransformerFixed("Assets:LaCaixa"),
      amountTransformer: NullTransformer(),
      costSpecTransformer: NullTransformer(),
      priceSpecTransformer: NullTransformer(),
    );

    var postingTrSimplified = PostingTransformer(
      accountTransformer: AccountTransformerFixed("Assets:LaCaixa"),
    );
    expect(postingTr.simplify(), postingTrSimplified);
  });
}

// Simplify the NullTransformer?

