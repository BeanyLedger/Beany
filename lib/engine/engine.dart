import 'dart:io';

import 'package:beany/core/core.dart';
import 'package:beany/core/statements.dart';
import 'package:beany/parser/parser.dart';
import 'package:path/path.dart' as p;

class Engine {
  List<Statement> statements = [];

  Engine(this.statements);

  static Future<Engine> loadRootFile(String filePath) async {
    var rootDir = p.dirname(filePath);

    var file = File(filePath);
    var text = await file.readAsString();
    var statements = parse(text).all().val().toList();
    var extraStatements = <Statement>[];
    for (var statement in statements) {
      if (statement is Include) {
        var include = statement;
        var includeFile = File(p.join(rootDir, include.path));
        var includeText = await includeFile.readAsString();
        var includeStatements = parse(includeText).all().val();
        extraStatements.addAll(includeStatements);
      }
    }
    return Engine([...statements, ...extraStatements]);
  }
}

// Maybe there should be 1 function to open a file, parse all the statements are return them?
