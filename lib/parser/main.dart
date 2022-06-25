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

  @override
  void enterCommodityStatement(CommodityStatementContext ctx) {}

  @override
  void enterDate(DateContext ctx) {}

  @override
  void enterDocumentStatement(DocumentStatementContext ctx) {}

  @override
  void enterEventStatement(EventStatementContext ctx) {}

  @override
  void enterInline_comment(Inline_commentContext ctx) {}

  @override
  void enterNoteStatement(NoteStatementContext ctx) {}

  @override
  void enterPosting_spec_account_amount(
      Posting_spec_account_amountContext ctx) {}

  @override
  void enterPosting_spec_account_only(Posting_spec_account_onlyContext ctx) {}

  @override
  void enterPriceStatement(PriceStatementContext ctx) {}

  @override
  void enterTr_comment(Tr_commentContext ctx) {}

  @override
  void enterTr_header(Tr_headerContext ctx) {}

  @override
  void enterTr_statement(Tr_statementContext ctx) {}

  @override
  void exitCommodityStatement(CommodityStatementContext ctx) {}

  @override
  void exitDate(DateContext ctx) {}

  @override
  void exitDocumentStatement(DocumentStatementContext ctx) {}

  @override
  void exitEventStatement(EventStatementContext ctx) {}

  @override
  void exitInline_comment(Inline_commentContext ctx) {}

  @override
  void exitNoteStatement(NoteStatementContext ctx) {}

  @override
  void exitPosting_spec_account_amount(
      Posting_spec_account_amountContext ctx) {}

  @override
  void exitPosting_spec_account_only(Posting_spec_account_onlyContext ctx) {}

  @override
  void exitPriceStatement(PriceStatementContext ctx) {}

  @override
  void exitTr_comment(Tr_commentContext ctx) {}

  @override
  void exitTr_header(Tr_headerContext ctx) {}

  @override
  void exitTr_statement(Tr_statementContext ctx) {}
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
