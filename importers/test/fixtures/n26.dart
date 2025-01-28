import 'package:beany_core/core/core.dart';
import 'package:beany_core/render/render.dart';
import 'package:beany_importer/src/importer_builder.dart';
import 'package:beany_importer/src/transformers.dart';
import 'package:beany_importer/src/decision_tree.dart';

import 'common.dart';

const _input = """
"Booking Date","Value Date","Partner Name","Partner Iban",Type,"Payment Reference","Account Name","Amount (EUR)","Original Amount","Original Currency","Exchange Rate"
2024-01-02,2024-01-04,"GOOGLE*CLOUD LXXXXX",,Presentment,-,"Main Account",-0.04,0.04,EUR,1
2024-01-09,2024-01-10,"OCCIDENT GCO,S.A.U SEGU Y REAS",ESxxxxx,"Direct Debit","xx MIXTO BASICO CON CONT.REEMB. DENTAL.Recibo:ANT4867606 01/01/2024-01/02/2024. P.Total:69,66. Copago:6,00. Antares es Plu","Main Account",-75.66,,,
2024-01-18,2024-01-19,N26,,Reward,"N26 Cashback","Main Account",0.2,,,
2024-01-18,2024-01-19,"CHATGPT SUBSCRIPTION",,Presentment,-,"Main Account",-18.42,20,USD,0.921
2024-01-22,2024-01-23,"Stripe Technology Europe Ltd",DKxxxxx,"Credit Transfer","GitHub Sponsors xxxx","Main Account",1.80,,,
""";

const _output = """
2024-01-02 * "GOOGLE*CLOUD LXXXXX"
  Assets:Work:N26  -0.04 EUR

2024-01-09 * "OCCIDENT GCO,S.A.U SEGU Y REAS"
  Assets:Work:N26  -75.66 EUR

2024-01-18 * "N26"
  Assets:Work:N26  0.2 EUR

2024-01-18 * "CHATGPT SUBSCRIPTION"
  Assets:Work:N26  -18.42 EUR

2024-01-22 * "Stripe Technology Europe Ltd"
  Assets:Work:N26  1.80 EUR

; Random Comment
""";

var _transformer = TransactionTransformer(
  dateTransformers: SeqTransformer([
    MapValueTransformer("Booking Date"),
    DateTransformerFormat('yyyy-MM-dd'),
  ]),
  narrationTransformers: MapValueTransformer("Partner Name"),
  postingTransformers: [
    PostingTransformer(
      accountTransformer: AccountTransformerFixed("Assets:Work:N26"),
      amountTransformer: AmountTransformer(
        numberTransformer: SeqTransformer([
          MapValueTransformer("Amount (EUR)"),
          NumberTransformerDecimalPoint(),
        ]),
        currencyTransformer: CurrencyTransformerFixed(CUR('EUR')),
      ),
    ),
  ],
);

ImporterTestData _buildTransformerTestData(String input, String output) {
  var (inputRows, outputTransactions) = parseCsvInputAndOutput(input, output);

  var trData = <SingleTransformerTestData>[];
  for (var i = 0; i < inputRows.length; i++) {
    var inputRow = inputRows[i];
    var outputTransaction = outputTransactions[i];
    var tr = SingleTransformerTestData(
      name: 'Only',
      csvInput: inputRow.values.map((v) => '"$v"').join(","),
      output: render(outputTransaction),
      transformer: _transformer,
    );
    trData.add(tr);
  }

  var csvHeaders = inputRows[0].keys.join(",");
  var n26TestData = ImporterTestData(
    name: 'N26',
    trData: trData,
    csvHeaders: csvHeaders,
    decisionTree: DecisionLeafNode('Only'),
  );

  return n26TestData;
}

var n26TestData = _buildTransformerTestData(_input, _output);
