import 'package:beany_core/core/core.dart';
import 'package:beany_importer/src/transformers.dart';
import 'package:beany_importer/src/decision_tree.dart';

import 'common.dart';

var _tr1 = SingleTransformerTestData(
  name: 'Only',
  csvInput:
      "45371.0,45371.0,ENDESA ENERGIA S.,Recibo de suministros,-37.91,4009.32",
  output: """
2024-03-20 * "ENDESA ENERGIA S."
  ; Recibo de suministros
  Assets:LaCaixa   -37.91 EUR
""",
  transformer: TransactionTransformer(
    dateTransformers: SeqTransformer([
      MapValueTransformer("Fecha"),
      DateTransformerExcel(),
    ]),
    narrationTransformers: MapValueTransformer("Movimiento"),
    commentsTransformers: MapValueTransformer("Más datos"),
    postingTransformers: [
      PostingTransformer(
        accountTransformer: AccountTransformerFixed("Assets:LaCaixa"),
        amountTransformer: AmountTransformer(
          numberTransformer: SeqTransformer([
            MapValueTransformer("Importe"),
            NumberTransformerDecimalPoint(),
          ]),
          currencyTransformer: CurrencyTransformerFixed(CUR('EUR')),
        ),
      ),
    ],
  ),
);

var _tr2 = SingleTransformerTestData(
  name: 'Only',
  csvInput: "45359.0,45359.0,BIZUM RECIBIDO,BIZUM,16.35,4047.23",
  output: """
2024-03-08 * "BIZUM RECIBIDO"
  ; BIZUM
  Assets:LaCaixa  16.35 EUR
""",
  transformer: _tr1.transformer,
);

var caixaTestData = ImporterTestData(
  name: 'Caixa',
  trData: [_tr1, _tr2],
  csvHeaders: "Fecha,Fecha valor,Movimiento,Más datos,Importe,Saldo",
  decisionTree: DecisionLeafNode('Only'),
);
