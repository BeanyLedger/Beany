import 'package:gringotts/parser/GringottsLexer.dart';
import 'package:gringotts/parser/GringottsParser.dart';
import 'package:antlr4/antlr4.dart';

GringottsParser parse(String text) {
  // if (!text.endsWith('\n')) text += '\n';
  print(text);
  final inputStream = InputStream.fromString(text);
  final lexer = GringottsLexer(inputStream);
  final tokens = CommonTokenStream(lexer);
  final parser = GringottsParser(tokens);
  parser.addErrorListener(DiagnosticErrorListener());

  return parser;
}
