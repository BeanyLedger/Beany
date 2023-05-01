import 'dart:io';

import 'package:antlr4/antlr4.dart';
import 'package:beany/engine/ledger.dart';

Future<void> main(List<String> args) async {
  if (args.length != 1) {
    print('usage: file');
    exit(1);
  }

  try {
    var ledger = await Ledger.loadRootFile(args.first);
    print("Found: ${ledger.statements.length} statements");
  } on ParseCancellationException catch (e) {
    print(e);
    print(e.stackTrace);
    exit(1);
  } catch (e, stackTrace) {
    print(e);
    print(stackTrace);
    exit(1);
  }
}
