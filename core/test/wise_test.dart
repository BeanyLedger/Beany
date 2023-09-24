import 'dart:io';

import 'package:beany/importer/wise.dart';
import 'package:beany/parser/parser.dart';
import 'package:beany/render/render.dart';
import 'package:test/test.dart';

var config = WiseConverterConfig("Assets:Wise", "Expenses:BankCharges");

void main() {
  test('Basic Test', () {
    var filePath = 'test/testdata/wise_test_data.json';
    var jsonInput = File(filePath).readAsStringSync();

    var statements = convertWise(config, jsonInput);
    var actualOutput = statements.map((e) => render(e)).join('\n');
    var expectedOutput =
        File('test/testdata/wise_output.beancount').readAsStringSync();

    expect(actualOutput, _format(expectedOutput));
  });

  test("Another transaction", () {
    var input = """
    {
      "type": "DEBIT",
      "date": "2022-07-11T17:49:43.559336Z",
      "amount": { "value": -38.83, "currency": "EUR", "zero": false },
      "totalFees": { "value": 0.0, "currency": "EUR", "zero": true },
      "details": {
        "type": "DIRECT_DEBIT",
        "description": "Paid to AIGUES DE BARCELONA, S.A.",
        "originator": "AIGUES DE BARCELONA, S.A.",
        "paymentReference": "2022-07-11-04.41.30.547053"
      },
      "exchangeDetails": null,
      "runningBalance": { "value": 5918.21, "currency": "EUR", "zero": false },
      "referenceNumber": "DIRECT_DEBIT-3322166",
      "attachment": null,
      "activityAssetAttributions": []
    }
    """;
    var wt = parseWiseTransaction(input);
    var tr = convertWiseTransaction(config, wt);
    var expectedOutput = """
2022-07-11 * "AIGUES DE BARCELONA, S.A."
  id: "DIRECT_DEBIT-3322166"
  Assets:Wise  -38.83 EUR
""";

    expect(render(tr), expectedOutput);
  });

  test("Conversion", () {
    var input = """
    {
      "type": "CREDIT",
      "date": "2022-10-08T10:00:30.917367Z",
      "amount": { "value": 6131.38, "currency": "EUR", "zero": false },
      "totalFees": { "value": 0.0, "currency": "EUR", "zero": true },
      "details": {
        "type": "CONVERSION",
        "description": "Converted 6000.00 USD to 6131.38 EUR",
        "sourceAmount": { "value": 6000.0, "currency": "USD", "zero": false },
        "targetAmount": { "value": 6131.38, "currency": "EUR", "zero": false },
        "rate": 1.0267
      },
      "exchangeDetails": {
        "toAmount": { "value": 6131.38, "currency": "EUR", "zero": false },
        "fromAmount": { "value": 6000.0, "currency": "USD", "zero": false },
        "rate": 1.0267
      },
      "runningBalance": { "value": 9036.23, "currency": "EUR", "zero": false },
      "referenceNumber": "BALANCE-652343984",
      "attachment": null,
      "activityAssetAttributions": []
    }
    """;

    var wt = parseWiseTransaction(input);
    var tr = convertWiseTransaction(config, wt);
    var expectedOutput = """
2022-10-08 * "Converted 6000.00 USD to 6131.38 EUR"
  id: "BALANCE-652343984"
  Assets:Wise           -6000.00 USD @ 1.0267 EUR
  Expenses:BankCharges      0.00 EUR @@ EUR
  Assets:Wise            6131.38 EUR
""";

//  Expenses:BankCharges     28.07 USD @@ EUR
    expect(render(tr), expectedOutput);
  });
}

String _format(String input) {
  var statements = parse(input).all().val().toList();
  return statements.map((e) => render(e)).join('\n');
}
