import 'dart:io';

import 'package:antlr4/antlr4.dart';
import 'package:beany/core/transaction.dart';
import 'package:beany/parser/parser.dart';

int main(List<String> args) {
  if (args.length != 1) {
    print('usage: file');
    return 1;
  }

  var input = File(args.first).readAsStringSync();

  var parser = parse(input);
  try {
    var statements = parser.all().val();
    for (var st in statements) {
      if (st is TransactionSpec) {
        try {
          st.resolve();
        } catch (ex) {
          print(ex);
          exit(1);
        }
      }
    }
  } on ParseCancellationException catch (e) {
    print(e);
    print(e.stackTrace);
    print(parser.currentToken);
    exit(1);
  } catch (e) {
    print(e);
    exit(1);
  }

  /*if (pResult.isFailure) {
    print('Failure: $pResult');
    var remaining = pResult.buffer.substring(pResult.position);
    var lines = LineSplitter.split(remaining).toList();
    print(lines[0]);
    return 1;
  }*/

  return 0;
}
