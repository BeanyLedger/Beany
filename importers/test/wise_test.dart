import 'package:beany_core/parser/parser.dart';
import 'package:beany_core/render/render.dart';
import 'package:beany_importer/src/wise.dart';
import 'package:test/test.dart';

var config = WiseConverterConfig("Assets:Wise", "Expenses:BankCharges");

void main() {
  test('Basic Test', () {
    var input = """
ID,Status,Direction,"Created on","Finished on","Source fee amount","Source fee currency","Target fee amount","Target fee currency","Source name","Source amount (after fees)","Source currency","Target name","Target amount (after fees)","Target currency","Exchange rate",Reference,Batch
"CARD_TRANSACTION-1352812512",COMPLETED,OUT,"2024-03-30 18:55:30","2024-03-30 18:55:30",0.00,EUR,,,"Vishesh Handa",8.90,EUR,"Sifan Sumi 2018 Sl",8.90,EUR,1.00000000,,
TRANSFER-996241724,COMPLETED,IN,"2024-03-11 18:06:56","2024-03-11 18:07:02",4.14,USD,,,"MEDL CORPORATION",7195.86,USD,"Vishesh Handa",7195.86,USD,1.0,,
"CARD_TRANSACTION-1279776353",COMPLETED,OUT,"2024-02-26 12:13:29","2024-02-26 12:13:29",0.07,EUR,,,"Vishesh Handa",13.25,EUR,Audible,14.38,USD,1.08530000,,
"CARD_TRANSACTION-1279776353",COMPLETED,OUT,"2024-02-26 12:13:29","2024-02-26 12:13:29",0.00,USD,,,"Vishesh Handa",0.56,USD,Audible,0.56,USD,1.00000000,,
""";

    var statements = convertWise(config, input);
    var actualOutput = statements.map((e) => render(e)).join('\n');
    var expectedOutput = """
2024-03-30 * "Sifan Sumi 2018 Sl"
  id: "CARD_TRANSACTION-1352812512"
  Assets:Wise  -8.90 EUR

2024-03-11 * "" "MEDL CORPORATION"
  id: "TRANSFER-996241724"
  Assets:Wise  7195.86 USD

2024-02-26 * "Audible"
  id: "CARD_TRANSACTION-1279776353"
  Assets:Wise               -13.25 EUR
  Expenses:BankCharges        0.07 EUR

2024-02-26 * "Audible"
  id: "CARD_TRANSACTION-1279776353"
  Assets:Wise  -0.56 USD
""";

    expect(actualOutput, _format(expectedOutput));
  });

  test('Currency Conversion', () {
    var input = """
ID,Status,Direction,"Created on","Finished on","Source fee amount","Source fee currency","Target fee amount","Target fee currency","Source name","Source amount (after fees)","Source currency","Target name","Target amount (after fees)","Target currency","Exchange rate",Reference,Batch
"BALANCE_TRANSACTION-1734932751",COMPLETED,NEUTRAL,"2024-02-04 23:56:13","2024-02-04 23:56:13",52.82,USD,,,"Vishesh Handa",10778.77,USD,"Vishesh Handa",10000.00,EUR,0.92775000,,
"BALANCE_TRANSACTION-1735891654",COMPLETED,IN,"2024-02-05 09:56:05","2024-02-05 09:56:05",50.24,USD,,,"Vishesh Handa",10249.76,USD,"Vishesh Handa",9532.28,EUR,0.93000000,,
""";

    var statements = convertWise(config, input);
    var actualOutput = statements.map((e) => render(e)).join('\n');
    var expectedOutput = """
2024-02-04 * "Currency Conversion"
  id: "BALANCE_TRANSACTION-1734932751"
  Assets:Wise                -10831.59 USD @ 0.92775 EUR
  Expenses:BankCharges           52.82 USD @ 0.92775 EUR
  Assets:Wise                 10000.00 EUR

2024-02-05 * "Currency Conversion"
  id: "BALANCE_TRANSACTION-1735891654"
  Expenses:Personal:BankCharges:Transferwise      50.24 USD @ 0.93 EUR
  Assets:Personal:Transferwise                -10300.00 USD @ 0.93 EUR
  Assets:Personal:Transferwise                  9532.28 EUR
""";

    expect(actualOutput, _format(expectedOutput));
  }, skip: true);
}

String _format(String input) {
  var statements = parse(input).all().val().toList();
  return statements.map((e) => render(e)).join('\n');
}
