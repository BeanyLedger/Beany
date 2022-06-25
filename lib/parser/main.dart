import 'package:antlr4/antlr4.dart';
import 'package:gringotts/parser/GringottsListener.dart';
import "./GringottsLexer.dart";
import "./GringottsParser.dart";

class TreeShapeListener implements GringottsListener {
  @override
  void enterEveryRule(ParserRuleContext ctx) {
    // print(ctx.text);
  }

  @override
  void exitEveryRule(ParserRuleContext node) {}

  @override
  void visitErrorNode(ErrorNode node) {}

  @override
  void visitTerminal(TerminalNode node) {}

  @override
  void enterAccount(AccountContext ctx) {}

  @override
  void enterAll(AllContext ctx) {}

  @override
  void enterAmount(AmountContext ctx) {
    print("Amoutn text ${ctx.text}");
    print("Amount Numbers - ${ctx.NUMBER()}");
    print("Amount Currneyc - ${ctx.currency()!.text}");
  }

  @override
  void enterBalanceStatement(BalanceStatementContext ctx) {}

  @override
  void enterCloseStatement(CloseStatementContext ctx) {}

  @override
  void enterComment(CommentContext ctx) {}

  @override
  void enterCurrency(CurrencyContext ctx) {}

  @override
  void enterEmpty_line(Empty_lineContext ctx) {}

  @override
  void enterOpenStatement(OpenStatementContext ctx) {}

  @override
  void enterStatement(StatementContext ctx) {}

  @override
  void exitAccount(AccountContext ctx) {}

  @override
  void exitAll(AllContext ctx) {}

  @override
  void exitAmount(AmountContext ctx) {}

  @override
  void exitBalanceStatement(BalanceStatementContext ctx) {}

  @override
  void exitCloseStatement(CloseStatementContext ctx) {}

  @override
  void exitComment(CommentContext ctx) {}

  @override
  void exitCurrency(CurrencyContext ctx) {}

  @override
  void exitEmpty_line(Empty_lineContext ctx) {}

  @override
  void exitOpenStatement(OpenStatementContext ctx) {}

  @override
  void exitStatement(StatementContext ctx) {}
}

void main() {
  final input = "2022-04-05 balance Assets:New 22.8 EUR";
  final inputStream = InputStream.fromString(input + '\n');
  final lexer = GringottsLexer(inputStream);
  final tokens = CommonTokenStream(lexer);
  final parser = GringottsParser(tokens);
  parser.addErrorListener(DiagnosticErrorListener());
  final tree = parser.all();

  ParseTreeWalker.DEFAULT.walk(TreeShapeListener(), tree);
}
