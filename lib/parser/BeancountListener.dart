// Generated from Beancount.g4 by ANTLR 4.10.1
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes

import 'package:antlr4/antlr4.dart';

import 'BeancountParser.dart';

/// This abstract class defines a complete listener for a parse tree produced by
/// [BeancountParser].
abstract class BeancountListener extends ParseTreeListener {
  /// Enter a parse tree produced by [BeancountParser.all].
  /// [ctx] the parse tree
  void enterAll(AllContext ctx);

  /// Exit a parse tree produced by [BeancountParser.all].
  /// [ctx] the parse tree
  void exitAll(AllContext ctx);

  /// Enter a parse tree produced by [BeancountParser.statement].
  /// [ctx] the parse tree
  void enterStatement(StatementContext ctx);

  /// Exit a parse tree produced by [BeancountParser.statement].
  /// [ctx] the parse tree
  void exitStatement(StatementContext ctx);

  /// Enter a parse tree produced by [BeancountParser.directive].
  /// [ctx] the parse tree
  void enterDirective(DirectiveContext ctx);

  /// Exit a parse tree produced by [BeancountParser.directive].
  /// [ctx] the parse tree
  void exitDirective(DirectiveContext ctx);

  /// Enter a parse tree produced by [BeancountParser.account].
  /// [ctx] the parse tree
  void enterAccount(AccountContext ctx);

  /// Exit a parse tree produced by [BeancountParser.account].
  /// [ctx] the parse tree
  void exitAccount(AccountContext ctx);

  /// Enter a parse tree produced by [BeancountParser.currency].
  /// [ctx] the parse tree
  void enterCurrency(CurrencyContext ctx);

  /// Exit a parse tree produced by [BeancountParser.currency].
  /// [ctx] the parse tree
  void exitCurrency(CurrencyContext ctx);

  /// Enter a parse tree produced by [BeancountParser.amount].
  /// [ctx] the parse tree
  void enterAmount(AmountContext ctx);

  /// Exit a parse tree produced by [BeancountParser.amount].
  /// [ctx] the parse tree
  void exitAmount(AmountContext ctx);

  /// Enter a parse tree produced by [BeancountParser.includeStatement].
  /// [ctx] the parse tree
  void enterIncludeStatement(IncludeStatementContext ctx);

  /// Exit a parse tree produced by [BeancountParser.includeStatement].
  /// [ctx] the parse tree
  void exitIncludeStatement(IncludeStatementContext ctx);

  /// Enter a parse tree produced by [BeancountParser.optionStatement].
  /// [ctx] the parse tree
  void enterOptionStatement(OptionStatementContext ctx);

  /// Exit a parse tree produced by [BeancountParser.optionStatement].
  /// [ctx] the parse tree
  void exitOptionStatement(OptionStatementContext ctx);

  /// Enter a parse tree produced by [BeancountParser.commentStatement].
  /// [ctx] the parse tree
  void enterCommentStatement(CommentStatementContext ctx);

  /// Exit a parse tree produced by [BeancountParser.commentStatement].
  /// [ctx] the parse tree
  void exitCommentStatement(CommentStatementContext ctx);

  /// Enter a parse tree produced by [BeancountParser.balanceStatement].
  /// [ctx] the parse tree
  void enterBalanceStatement(BalanceStatementContext ctx);

  /// Exit a parse tree produced by [BeancountParser.balanceStatement].
  /// [ctx] the parse tree
  void exitBalanceStatement(BalanceStatementContext ctx);

  /// Enter a parse tree produced by [BeancountParser.closeStatement].
  /// [ctx] the parse tree
  void enterCloseStatement(CloseStatementContext ctx);

  /// Exit a parse tree produced by [BeancountParser.closeStatement].
  /// [ctx] the parse tree
  void exitCloseStatement(CloseStatementContext ctx);

  /// Enter a parse tree produced by [BeancountParser.openStatement].
  /// [ctx] the parse tree
  void enterOpenStatement(OpenStatementContext ctx);

  /// Exit a parse tree produced by [BeancountParser.openStatement].
  /// [ctx] the parse tree
  void exitOpenStatement(OpenStatementContext ctx);

  /// Enter a parse tree produced by [BeancountParser.commodityStatement].
  /// [ctx] the parse tree
  void enterCommodityStatement(CommodityStatementContext ctx);

  /// Exit a parse tree produced by [BeancountParser.commodityStatement].
  /// [ctx] the parse tree
  void exitCommodityStatement(CommodityStatementContext ctx);

  /// Enter a parse tree produced by [BeancountParser.priceStatement].
  /// [ctx] the parse tree
  void enterPriceStatement(PriceStatementContext ctx);

  /// Exit a parse tree produced by [BeancountParser.priceStatement].
  /// [ctx] the parse tree
  void exitPriceStatement(PriceStatementContext ctx);

  /// Enter a parse tree produced by [BeancountParser.eventStatement].
  /// [ctx] the parse tree
  void enterEventStatement(EventStatementContext ctx);

  /// Exit a parse tree produced by [BeancountParser.eventStatement].
  /// [ctx] the parse tree
  void exitEventStatement(EventStatementContext ctx);

  /// Enter a parse tree produced by [BeancountParser.documentStatement].
  /// [ctx] the parse tree
  void enterDocumentStatement(DocumentStatementContext ctx);

  /// Exit a parse tree produced by [BeancountParser.documentStatement].
  /// [ctx] the parse tree
  void exitDocumentStatement(DocumentStatementContext ctx);

  /// Enter a parse tree produced by [BeancountParser.noteStatement].
  /// [ctx] the parse tree
  void enterNoteStatement(NoteStatementContext ctx);

  /// Exit a parse tree produced by [BeancountParser.noteStatement].
  /// [ctx] the parse tree
  void exitNoteStatement(NoteStatementContext ctx);

  /// Enter a parse tree produced by [BeancountParser.empty_line].
  /// [ctx] the parse tree
  void enterEmpty_line(Empty_lineContext ctx);

  /// Exit a parse tree produced by [BeancountParser.empty_line].
  /// [ctx] the parse tree
  void exitEmpty_line(Empty_lineContext ctx);

  /// Enter a parse tree produced by [BeancountParser.trStatement].
  /// [ctx] the parse tree
  void enterTrStatement(TrStatementContext ctx);

  /// Exit a parse tree produced by [BeancountParser.trStatement].
  /// [ctx] the parse tree
  void exitTrStatement(TrStatementContext ctx);

  /// Enter a parse tree produced by [BeancountParser.tr_header].
  /// [ctx] the parse tree
  void enterTr_header(Tr_headerContext ctx);

  /// Exit a parse tree produced by [BeancountParser.tr_header].
  /// [ctx] the parse tree
  void exitTr_header(Tr_headerContext ctx);

  /// Enter a parse tree produced by [BeancountParser.tr_flag].
  /// [ctx] the parse tree
  void enterTr_flag(Tr_flagContext ctx);

  /// Exit a parse tree produced by [BeancountParser.tr_flag].
  /// [ctx] the parse tree
  void exitTr_flag(Tr_flagContext ctx);

  /// Enter a parse tree produced by [BeancountParser.inline_comment].
  /// [ctx] the parse tree
  void enterInline_comment(Inline_commentContext ctx);

  /// Exit a parse tree produced by [BeancountParser.inline_comment].
  /// [ctx] the parse tree
  void exitInline_comment(Inline_commentContext ctx);

  /// Enter a parse tree produced by [BeancountParser.tr_comment].
  /// [ctx] the parse tree
  void enterTr_comment(Tr_commentContext ctx);

  /// Exit a parse tree produced by [BeancountParser.tr_comment].
  /// [ctx] the parse tree
  void exitTr_comment(Tr_commentContext ctx);

  /// Enter a parse tree produced by [BeancountParser.posting_spec_account_only].
  /// [ctx] the parse tree
  void enterPosting_spec_account_only(Posting_spec_account_onlyContext ctx);

  /// Exit a parse tree produced by [BeancountParser.posting_spec_account_only].
  /// [ctx] the parse tree
  void exitPosting_spec_account_only(Posting_spec_account_onlyContext ctx);

  /// Enter a parse tree produced by [BeancountParser.posting_spec_account_amount].
  /// [ctx] the parse tree
  void enterPosting_spec_account_amount(Posting_spec_account_amountContext ctx);

  /// Exit a parse tree produced by [BeancountParser.posting_spec_account_amount].
  /// [ctx] the parse tree
  void exitPosting_spec_account_amount(Posting_spec_account_amountContext ctx);

  /// Enter a parse tree produced by [BeancountParser.posting_spec_explicit_per_price].
  /// [ctx] the parse tree
  void enterPosting_spec_explicit_per_price(
      Posting_spec_explicit_per_priceContext ctx);

  /// Exit a parse tree produced by [BeancountParser.posting_spec_explicit_per_price].
  /// [ctx] the parse tree
  void exitPosting_spec_explicit_per_price(
      Posting_spec_explicit_per_priceContext ctx);

  /// Enter a parse tree produced by [BeancountParser.posting_spec_explicit_total_price].
  /// [ctx] the parse tree
  void enterPosting_spec_explicit_total_price(
      Posting_spec_explicit_total_priceContext ctx);

  /// Exit a parse tree produced by [BeancountParser.posting_spec_explicit_total_price].
  /// [ctx] the parse tree
  void exitPosting_spec_explicit_total_price(
      Posting_spec_explicit_total_priceContext ctx);

  /// Enter a parse tree produced by [BeancountParser.price].
  /// [ctx] the parse tree
  void enterPrice(PriceContext ctx);

  /// Exit a parse tree produced by [BeancountParser.price].
  /// [ctx] the parse tree
  void exitPrice(PriceContext ctx);

  /// Enter a parse tree produced by [BeancountParser.date].
  /// [ctx] the parse tree
  void enterDate(DateContext ctx);

  /// Exit a parse tree produced by [BeancountParser.date].
  /// [ctx] the parse tree
  void exitDate(DateContext ctx);

  /// Enter a parse tree produced by [BeancountParser.quoted_string].
  /// [ctx] the parse tree
  void enterQuoted_string(Quoted_stringContext ctx);

  /// Exit a parse tree produced by [BeancountParser.quoted_string].
  /// [ctx] the parse tree
  void exitQuoted_string(Quoted_stringContext ctx);

  /// Enter a parse tree produced by [BeancountParser.tags].
  /// [ctx] the parse tree
  void enterTags(TagsContext ctx);

  /// Exit a parse tree produced by [BeancountParser.tags].
  /// [ctx] the parse tree
  void exitTags(TagsContext ctx);

  /// Enter a parse tree produced by [BeancountParser.metadata].
  /// [ctx] the parse tree
  void enterMetadata(MetadataContext ctx);

  /// Exit a parse tree produced by [BeancountParser.metadata].
  /// [ctx] the parse tree
  void exitMetadata(MetadataContext ctx);

  /// Enter a parse tree produced by [BeancountParser.metadata_key].
  /// [ctx] the parse tree
  void enterMetadata_key(Metadata_keyContext ctx);

  /// Exit a parse tree produced by [BeancountParser.metadata_key].
  /// [ctx] the parse tree
  void exitMetadata_key(Metadata_keyContext ctx);

  /// Enter a parse tree produced by [BeancountParser.metadata_value].
  /// [ctx] the parse tree
  void enterMetadata_value(Metadata_valueContext ctx);

  /// Exit a parse tree produced by [BeancountParser.metadata_value].
  /// [ctx] the parse tree
  void exitMetadata_value(Metadata_valueContext ctx);
}
