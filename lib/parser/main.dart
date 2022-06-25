import 'package:antlr4/antlr4.dart';
import "./GringottsLexer.dart";
import "./GringottsParser.dart";

class TreeShapeListener implements ParseTreeListener {
  @override
  void enterEveryRule(ParserRuleContext ctx) {
    print(ctx.text);
  }

  @override
  void exitEveryRule(ParserRuleContext node) {}

  @override
  void visitErrorNode(ErrorNode node) {}

  @override
  void visitTerminal(TerminalNode node) {}
}

void main() {
  GringottsLexer.checkVersion();
  GringottsParser.checkVersion();
  final input = "2022-04-05 open Assets:New";
  final inputStream = InputStream.fromString(input + '\n');
  final lexer = GringottsLexer(inputStream);
  final tokens = CommonTokenStream(lexer);
  final parser = GringottsParser(tokens);
  parser.addErrorListener(DiagnosticErrorListener());
  parser.buildParseTree = true;
  final tree = parser.all();

  ParseTreeWalker.DEFAULT.walk(TreeShapeListener(), tree);
}
