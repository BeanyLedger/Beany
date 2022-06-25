// Generated from Gringotts.g4 by ANTLR 4.10.1
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes
import 'package:antlr4/antlr4.dart';

import 'GringottsParser.dart';

/// This abstract class defines a complete listener for a parse tree produced by
/// [GringottsParser].
abstract class GringottsListener extends ParseTreeListener {
  /// Enter a parse tree produced by [GringottsParser.all].
  /// [ctx] the parse tree
  void enterAll(AllContext ctx);
  /// Exit a parse tree produced by [GringottsParser.all].
  /// [ctx] the parse tree
  void exitAll(AllContext ctx);

  /// Enter a parse tree produced by [GringottsParser.comment].
  /// [ctx] the parse tree
  void enterComment(CommentContext ctx);
  /// Exit a parse tree produced by [GringottsParser.comment].
  /// [ctx] the parse tree
  void exitComment(CommentContext ctx);

  /// Enter a parse tree produced by [GringottsParser.statement].
  /// [ctx] the parse tree
  void enterStatement(StatementContext ctx);
  /// Exit a parse tree produced by [GringottsParser.statement].
  /// [ctx] the parse tree
  void exitStatement(StatementContext ctx);

  /// Enter a parse tree produced by [GringottsParser.account].
  /// [ctx] the parse tree
  void enterAccount(AccountContext ctx);
  /// Exit a parse tree produced by [GringottsParser.account].
  /// [ctx] the parse tree
  void exitAccount(AccountContext ctx);

  /// Enter a parse tree produced by [GringottsParser.currency].
  /// [ctx] the parse tree
  void enterCurrency(CurrencyContext ctx);
  /// Exit a parse tree produced by [GringottsParser.currency].
  /// [ctx] the parse tree
  void exitCurrency(CurrencyContext ctx);

  /// Enter a parse tree produced by [GringottsParser.amount].
  /// [ctx] the parse tree
  void enterAmount(AmountContext ctx);
  /// Exit a parse tree produced by [GringottsParser.amount].
  /// [ctx] the parse tree
  void exitAmount(AmountContext ctx);

  /// Enter a parse tree produced by [GringottsParser.balanceStatement].
  /// [ctx] the parse tree
  void enterBalanceStatement(BalanceStatementContext ctx);
  /// Exit a parse tree produced by [GringottsParser.balanceStatement].
  /// [ctx] the parse tree
  void exitBalanceStatement(BalanceStatementContext ctx);

  /// Enter a parse tree produced by [GringottsParser.closeStatement].
  /// [ctx] the parse tree
  void enterCloseStatement(CloseStatementContext ctx);
  /// Exit a parse tree produced by [GringottsParser.closeStatement].
  /// [ctx] the parse tree
  void exitCloseStatement(CloseStatementContext ctx);

  /// Enter a parse tree produced by [GringottsParser.openStatement].
  /// [ctx] the parse tree
  void enterOpenStatement(OpenStatementContext ctx);
  /// Exit a parse tree produced by [GringottsParser.openStatement].
  /// [ctx] the parse tree
  void exitOpenStatement(OpenStatementContext ctx);

  /// Enter a parse tree produced by [GringottsParser.commodityStatement].
  /// [ctx] the parse tree
  void enterCommodityStatement(CommodityStatementContext ctx);
  /// Exit a parse tree produced by [GringottsParser.commodityStatement].
  /// [ctx] the parse tree
  void exitCommodityStatement(CommodityStatementContext ctx);

  /// Enter a parse tree produced by [GringottsParser.priceStatement].
  /// [ctx] the parse tree
  void enterPriceStatement(PriceStatementContext ctx);
  /// Exit a parse tree produced by [GringottsParser.priceStatement].
  /// [ctx] the parse tree
  void exitPriceStatement(PriceStatementContext ctx);

  /// Enter a parse tree produced by [GringottsParser.eventStatement].
  /// [ctx] the parse tree
  void enterEventStatement(EventStatementContext ctx);
  /// Exit a parse tree produced by [GringottsParser.eventStatement].
  /// [ctx] the parse tree
  void exitEventStatement(EventStatementContext ctx);

  /// Enter a parse tree produced by [GringottsParser.documentStatement].
  /// [ctx] the parse tree
  void enterDocumentStatement(DocumentStatementContext ctx);
  /// Exit a parse tree produced by [GringottsParser.documentStatement].
  /// [ctx] the parse tree
  void exitDocumentStatement(DocumentStatementContext ctx);

  /// Enter a parse tree produced by [GringottsParser.noteStatement].
  /// [ctx] the parse tree
  void enterNoteStatement(NoteStatementContext ctx);
  /// Exit a parse tree produced by [GringottsParser.noteStatement].
  /// [ctx] the parse tree
  void exitNoteStatement(NoteStatementContext ctx);

  /// Enter a parse tree produced by [GringottsParser.empty_line].
  /// [ctx] the parse tree
  void enterEmpty_line(Empty_lineContext ctx);
  /// Exit a parse tree produced by [GringottsParser.empty_line].
  /// [ctx] the parse tree
  void exitEmpty_line(Empty_lineContext ctx);

  /// Enter a parse tree produced by [GringottsParser.tr_statement].
  /// [ctx] the parse tree
  void enterTr_statement(Tr_statementContext ctx);
  /// Exit a parse tree produced by [GringottsParser.tr_statement].
  /// [ctx] the parse tree
  void exitTr_statement(Tr_statementContext ctx);

  /// Enter a parse tree produced by [GringottsParser.tr_header].
  /// [ctx] the parse tree
  void enterTr_header(Tr_headerContext ctx);
  /// Exit a parse tree produced by [GringottsParser.tr_header].
  /// [ctx] the parse tree
  void exitTr_header(Tr_headerContext ctx);

  /// Enter a parse tree produced by [GringottsParser.tr_comment].
  /// [ctx] the parse tree
  void enterTr_comment(Tr_commentContext ctx);
  /// Exit a parse tree produced by [GringottsParser.tr_comment].
  /// [ctx] the parse tree
  void exitTr_comment(Tr_commentContext ctx);

  /// Enter a parse tree produced by [GringottsParser.inline_comment].
  /// [ctx] the parse tree
  void enterInline_comment(Inline_commentContext ctx);
  /// Exit a parse tree produced by [GringottsParser.inline_comment].
  /// [ctx] the parse tree
  void exitInline_comment(Inline_commentContext ctx);

  /// Enter a parse tree produced by [GringottsParser.posting_spec_account_only].
  /// [ctx] the parse tree
  void enterPosting_spec_account_only(Posting_spec_account_onlyContext ctx);
  /// Exit a parse tree produced by [GringottsParser.posting_spec_account_only].
  /// [ctx] the parse tree
  void exitPosting_spec_account_only(Posting_spec_account_onlyContext ctx);

  /// Enter a parse tree produced by [GringottsParser.posting_spec_account_amount].
  /// [ctx] the parse tree
  void enterPosting_spec_account_amount(Posting_spec_account_amountContext ctx);
  /// Exit a parse tree produced by [GringottsParser.posting_spec_account_amount].
  /// [ctx] the parse tree
  void exitPosting_spec_account_amount(Posting_spec_account_amountContext ctx);

  /// Enter a parse tree produced by [GringottsParser.date].
  /// [ctx] the parse tree
  void enterDate(DateContext ctx);
  /// Exit a parse tree produced by [GringottsParser.date].
  /// [ctx] the parse tree
  void exitDate(DateContext ctx);
}