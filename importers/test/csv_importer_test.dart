import 'package:beany_core/core/core.dart';
import 'package:beany_importer/src/transformers.dart';
import 'package:beany_importer/src/transformers_numbers.dart';
import 'package:test/test.dart';

void main() {
  test('operator ==', () {
    final importer1 = TransactionTransformer(
      dateTransformers: SeqTransformer([
        MapValueTransformer("0"),
        DateTransformerExcel(),
      ]),
      narrationTransformers: MapValueTransformer("2"),
      commentsTransformers: MapValueTransformer("3"),
      postingTransformers: [
        PostingTransformer(
          accountTransformer: AccountTransformerFixed("Assets:LaCaixa"),
          amountTransformer: AmountTransformer(
            numberTransformer: SeqTransformer([
              MapValueTransformer("4"),
              NumberTransformerDecimalPoint(),
            ]),
            currencyTransformer: CurrencyTransformerFixed(CUR('EUR')),
          ),
        ),
      ],
    );
    final importer2 = TransactionTransformer(
      dateTransformers: SeqTransformer([
        MapValueTransformer("0"),
        DateTransformerExcel(),
      ]),
      narrationTransformers: MapValueTransformer("2"),
      commentsTransformers: MapValueTransformer("3"),
      postingTransformers: [
        PostingTransformer(
          accountTransformer: AccountTransformerFixed("Assets:LaCaixa"),
          amountTransformer: AmountTransformer(
            numberTransformer: SeqTransformer([
              MapValueTransformer("4"),
              NumberTransformerDecimalPoint(),
            ]),
            currencyTransformer: CurrencyTransformerFixed(CUR('EUR')),
          ),
        ),
      ],
    );
    expect(importer1 == importer2, isTrue);
  });
}



// TODO: Allow the transformers to be serialized and deserialized
//       Why?

// TODO: We need better error handling for the when the transformation chain fails
//       or if an individual one fails
//       Ideally one should get the input, the transformers applied, and the exact transformer than failed
//       and why it failed
