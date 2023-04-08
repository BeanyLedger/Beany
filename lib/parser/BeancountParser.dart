// Generated from Beancount.g4 by ANTLR 4.12.0
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes
import 'package:antlr4/antlr4.dart';

import 'BeancountListener.dart';
import 'BeancountBaseListener.dart';

const int RULE_all = 0,
    RULE_statement = 1,
    RULE_directive = 2,
    RULE_account = 3,
    RULE_currency = 4,
    RULE_amount = 5,
    RULE_includeStatement = 6,
    RULE_optionStatement = 7,
    RULE_commentStatement = 8,
    RULE_balanceStatement = 9,
    RULE_closeStatement = 10,
    RULE_openStatement = 11,
    RULE_commodityStatement = 12,
    RULE_priceStatement = 13,
    RULE_eventStatement = 14,
    RULE_documentStatement = 15,
    RULE_noteStatement = 16,
    RULE_empty_line = 17,
    RULE_trStatement = 18,
    RULE_tr_header = 19,
    RULE_tr_flag = 20,
    RULE_inline_comment = 21,
    RULE_tr_comment = 22,
    RULE_posting_spec_account_only = 23,
    RULE_posting_spec_account_amount = 24,
    RULE_posting_spec_explicit_per_price = 25,
    RULE_posting_spec_explicit_total_price = 26,
    RULE_price = 27,
    RULE_date = 28,
    RULE_quoted_string = 29,
    RULE_tags = 30,
    RULE_metadata = 31,
    RULE_metadata_key = 32,
    RULE_metadata_value = 33;

class BeancountParser extends Parser {
  static final checkVersion =
      () => RuntimeMetaData.checkVersion('4.12.0', RuntimeMetaData.VERSION);
  static const int TOKEN_EOF = IntStream.EOF;

  static final List<DFA> _decisionToDFA = List.generate(
      _ATN.numberOfDecisions, (i) => DFA(_ATN.getDecisionState(i), i));
  static final PredictionContextCache _sharedContextCache =
      PredictionContextCache();
  static const int TOKEN_T__0 = 1,
      TOKEN_T__1 = 2,
      TOKEN_T__2 = 3,
      TOKEN_T__3 = 4,
      TOKEN_T__4 = 5,
      TOKEN_T__5 = 6,
      TOKEN_T__6 = 7,
      TOKEN_T__7 = 8,
      TOKEN_T__8 = 9,
      TOKEN_T__9 = 10,
      TOKEN_T__10 = 11,
      TOKEN_T__11 = 12,
      TOKEN_T__12 = 13,
      TOKEN_T__13 = 14,
      TOKEN_T__14 = 15,
      TOKEN_DIGIT = 16,
      TOKEN_YEAR = 17,
      TOKEN_MONTH = 18,
      TOKEN_DAY = 19,
      TOKEN_DATE = 20,
      TOKEN_NUMBER = 21,
      TOKEN_TAG = 22,
      TOKEN_WORD = 23,
      TOKEN_WHITESPACE = 24,
      TOKEN_NEWLINE = 25,
      TOKEN_TR_FLAG = 26,
      TOKEN_STR = 27;

  @override
  final List<String> ruleNames = [
    'all',
    'statement',
    'directive',
    'account',
    'currency',
    'amount',
    'includeStatement',
    'optionStatement',
    'commentStatement',
    'balanceStatement',
    'closeStatement',
    'openStatement',
    'commodityStatement',
    'priceStatement',
    'eventStatement',
    'documentStatement',
    'noteStatement',
    'empty_line',
    'trStatement',
    'tr_header',
    'tr_flag',
    'inline_comment',
    'tr_comment',
    'posting_spec_account_only',
    'posting_spec_account_amount',
    'posting_spec_explicit_per_price',
    'posting_spec_explicit_total_price',
    'price',
    'date',
    'quoted_string',
    'tags',
    'metadata',
    'metadata_key',
    'metadata_value'
  ];

  static final List<String?> _LITERAL_NAMES = [
    null,
    "':'",
    "'include'",
    "'option'",
    "'#'",
    "';'",
    "'balance'",
    "'close'",
    "'open'",
    "'commodity'",
    "'price'",
    "'event'",
    "'document'",
    "'note'",
    "'@'",
    "'@@'"
  ];
  static final List<String?> _SYMBOLIC_NAMES = [
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    "DIGIT",
    "YEAR",
    "MONTH",
    "DAY",
    "DATE",
    "NUMBER",
    "TAG",
    "WORD",
    "WHITESPACE",
    "NEWLINE",
    "TR_FLAG",
    "STR"
  ];
  static final Vocabulary VOCABULARY =
      VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

  @override
  Vocabulary get vocabulary {
    return VOCABULARY;
  }

  @override
  String get grammarFileName => 'Beancount.g4';

  @override
  List<int> get serializedATN => _serializedATN;

  @override
  ATN getATN() {
    return _ATN;
  }

  BeancountParser(TokenStream input) : super(input) {
    interpreter =
        ParserATNSimulator(this, _ATN, _decisionToDFA, _sharedContextCache);
  }

  AllContext all() {
    dynamic _localctx = AllContext(context, state);
    enterRule(_localctx, 0, RULE_all);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 72;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while ((((_la) & ~0x3f) == 0 && ((1 << _la) & 34603068) != 0)) {
        state = 70;
        errorHandler.sync(this);
        switch (tokenStream.LA(1)!) {
          case TOKEN_T__1:
          case TOKEN_T__2:
          case TOKEN_T__3:
          case TOKEN_T__4:
          case TOKEN_DATE:
            state = 68;
            statement();
            break;
          case TOKEN_NEWLINE:
            state = 69;
            empty_line();
            break;
          default:
            throw NoViableAltException(this);
        }
        state = 74;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 75;
      match(TOKEN_EOF);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  StatementContext statement() {
    dynamic _localctx = StatementContext(context, state);
    enterRule(_localctx, 2, RULE_statement);
    try {
      state = 81;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
        case TOKEN_DATE:
          enterOuterAlt(_localctx, 1);
          state = 77;
          directive();
          break;
        case TOKEN_T__1:
          enterOuterAlt(_localctx, 2);
          state = 78;
          includeStatement();
          break;
        case TOKEN_T__2:
          enterOuterAlt(_localctx, 3);
          state = 79;
          optionStatement();
          break;
        case TOKEN_T__3:
        case TOKEN_T__4:
          enterOuterAlt(_localctx, 4);
          state = 80;
          commentStatement();
          break;
        default:
          throw NoViableAltException(this);
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  DirectiveContext directive() {
    dynamic _localctx = DirectiveContext(context, state);
    enterRule(_localctx, 4, RULE_directive);
    try {
      enterOuterAlt(_localctx, 1);
      state = 92;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 3, context)) {
        case 1:
          state = 83;
          balanceStatement();
          break;
        case 2:
          state = 84;
          closeStatement();
          break;
        case 3:
          state = 85;
          openStatement();
          break;
        case 4:
          state = 86;
          commodityStatement();
          break;
        case 5:
          state = 87;
          priceStatement();
          break;
        case 6:
          state = 88;
          eventStatement();
          break;
        case 7:
          state = 89;
          documentStatement();
          break;
        case 8:
          state = 90;
          noteStatement();
          break;
        case 9:
          state = 91;
          trStatement();
          break;
      }
      state = 94;
      match(TOKEN_NEWLINE);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  AccountContext account() {
    dynamic _localctx = AccountContext(context, state);
    enterRule(_localctx, 6, RULE_account);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 96;
      match(TOKEN_WORD);
      state = 99;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 97;
        match(TOKEN_T__0);
        state = 98;
        match(TOKEN_WORD);
        state = 101;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while (_la == TOKEN_T__0);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  CurrencyContext currency() {
    dynamic _localctx = CurrencyContext(context, state);
    enterRule(_localctx, 8, RULE_currency);
    try {
      enterOuterAlt(_localctx, 1);
      state = 103;
      match(TOKEN_WORD);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  AmountContext amount() {
    dynamic _localctx = AmountContext(context, state);
    enterRule(_localctx, 10, RULE_amount);
    try {
      enterOuterAlt(_localctx, 1);
      state = 105;
      match(TOKEN_NUMBER);
      state = 106;
      currency();
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  IncludeStatementContext includeStatement() {
    dynamic _localctx = IncludeStatementContext(context, state);
    enterRule(_localctx, 12, RULE_includeStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 108;
      match(TOKEN_T__1);
      state = 109;
      quoted_string();
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  OptionStatementContext optionStatement() {
    dynamic _localctx = OptionStatementContext(context, state);
    enterRule(_localctx, 14, RULE_optionStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 111;
      match(TOKEN_T__2);
      state = 112;
      _localctx.key = quoted_string();
      state = 113;
      _localctx.value = quoted_string();
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  CommentStatementContext commentStatement() {
    dynamic _localctx = CommentStatementContext(context, state);
    enterRule(_localctx, 16, RULE_commentStatement);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 115;
      _la = tokenStream.LA(1)!;
      if (!(_la == TOKEN_T__3 || _la == TOKEN_T__4)) {
        errorHandler.recoverInline(this);
      } else {
        if (tokenStream.LA(1)! == IntStream.EOF) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
      state = 119;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while ((((_la) & ~0x3f) == 0 && ((1 << _la) & 234881022) != 0)) {
        state = 116;
        _la = tokenStream.LA(1)!;
        if (_la <= 0 || (_la == TOKEN_NEWLINE)) {
          errorHandler.recoverInline(this);
        } else {
          if (tokenStream.LA(1)! == IntStream.EOF) matchedEOF = true;
          errorHandler.reportMatch(this);
          consume();
        }
        state = 121;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 122;
      match(TOKEN_NEWLINE);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  BalanceStatementContext balanceStatement() {
    dynamic _localctx = BalanceStatementContext(context, state);
    enterRule(_localctx, 18, RULE_balanceStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 124;
      date();
      state = 125;
      match(TOKEN_T__5);
      state = 126;
      account();
      state = 127;
      amount();
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  CloseStatementContext closeStatement() {
    dynamic _localctx = CloseStatementContext(context, state);
    enterRule(_localctx, 20, RULE_closeStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 129;
      date();
      state = 130;
      match(TOKEN_T__6);
      state = 131;
      account();
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  OpenStatementContext openStatement() {
    dynamic _localctx = OpenStatementContext(context, state);
    enterRule(_localctx, 22, RULE_openStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 133;
      date();
      state = 134;
      match(TOKEN_T__7);
      state = 135;
      account();
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  CommodityStatementContext commodityStatement() {
    dynamic _localctx = CommodityStatementContext(context, state);
    enterRule(_localctx, 24, RULE_commodityStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 137;
      date();
      state = 138;
      match(TOKEN_T__8);
      state = 139;
      currency();
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  PriceStatementContext priceStatement() {
    dynamic _localctx = PriceStatementContext(context, state);
    enterRule(_localctx, 26, RULE_priceStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 141;
      date();
      state = 142;
      match(TOKEN_T__9);
      state = 143;
      currency();
      state = 144;
      amount();
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  EventStatementContext eventStatement() {
    dynamic _localctx = EventStatementContext(context, state);
    enterRule(_localctx, 28, RULE_eventStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 146;
      date();
      state = 147;
      match(TOKEN_T__10);
      state = 148;
      _localctx.name = quoted_string();
      state = 149;
      _localctx.value = quoted_string();
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  DocumentStatementContext documentStatement() {
    dynamic _localctx = DocumentStatementContext(context, state);
    enterRule(_localctx, 30, RULE_documentStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 151;
      date();
      state = 152;
      match(TOKEN_T__11);
      state = 153;
      account();
      state = 154;
      quoted_string();
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  NoteStatementContext noteStatement() {
    dynamic _localctx = NoteStatementContext(context, state);
    enterRule(_localctx, 32, RULE_noteStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 156;
      date();
      state = 157;
      match(TOKEN_T__12);
      state = 158;
      account();
      state = 159;
      quoted_string();
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  Empty_lineContext empty_line() {
    dynamic _localctx = Empty_lineContext(context, state);
    enterRule(_localctx, 34, RULE_empty_line);
    try {
      enterOuterAlt(_localctx, 1);
      state = 161;
      match(TOKEN_NEWLINE);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  TrStatementContext trStatement() {
    dynamic _localctx = TrStatementContext(context, state);
    enterRule(_localctx, 36, RULE_trStatement);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 163;
      tr_header();
      state = 164;
      match(TOKEN_NEWLINE);
      state = 170;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_T__4) {
        state = 165;
        tr_comment();
        state = 166;
        match(TOKEN_NEWLINE);
        state = 172;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 173;
      metadata();
      state = 182;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 178;
        errorHandler.sync(this);
        switch (interpreter!.adaptivePredict(tokenStream, 7, context)) {
          case 1:
            state = 174;
            posting_spec_account_only();
            break;
          case 2:
            state = 175;
            posting_spec_account_amount();
            break;
          case 3:
            state = 176;
            posting_spec_explicit_per_price();
            break;
          case 4:
            state = 177;
            posting_spec_explicit_total_price();
            break;
        }
        state = 180;
        match(TOKEN_NEWLINE);
        state = 184;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while (_la == TOKEN_WORD);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  Tr_headerContext tr_header() {
    dynamic _localctx = Tr_headerContext(context, state);
    enterRule(_localctx, 38, RULE_tr_header);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 186;
      date();
      state = 187;
      tr_flag();
      state = 188;
      _localctx.narration = quoted_string();
      state = 190;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_STR) {
        state = 189;
        _localctx.payee = quoted_string();
      }

      state = 193;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_TAG) {
        state = 192;
        tags();
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  Tr_flagContext tr_flag() {
    dynamic _localctx = Tr_flagContext(context, state);
    enterRule(_localctx, 40, RULE_tr_flag);
    try {
      enterOuterAlt(_localctx, 1);
      state = 195;
      match(TOKEN_TR_FLAG);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  Inline_commentContext inline_comment() {
    dynamic _localctx = Inline_commentContext(context, state);
    enterRule(_localctx, 42, RULE_inline_comment);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 197;
      match(TOKEN_T__4);
      state = 201;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while ((((_la) & ~0x3f) == 0 && ((1 << _la) & 234881022) != 0)) {
        state = 198;
        _la = tokenStream.LA(1)!;
        if (_la <= 0 || (_la == TOKEN_NEWLINE)) {
          errorHandler.recoverInline(this);
        } else {
          if (tokenStream.LA(1)! == IntStream.EOF) matchedEOF = true;
          errorHandler.reportMatch(this);
          consume();
        }
        state = 203;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  Tr_commentContext tr_comment() {
    dynamic _localctx = Tr_commentContext(context, state);
    enterRule(_localctx, 44, RULE_tr_comment);
    try {
      enterOuterAlt(_localctx, 1);
      state = 204;
      inline_comment();
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  Posting_spec_account_onlyContext posting_spec_account_only() {
    dynamic _localctx = Posting_spec_account_onlyContext(context, state);
    enterRule(_localctx, 46, RULE_posting_spec_account_only);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 206;
      account();
      state = 208;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_TAG) {
        state = 207;
        tags();
      }

      state = 211;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_T__4) {
        state = 210;
        inline_comment();
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  Posting_spec_account_amountContext posting_spec_account_amount() {
    dynamic _localctx = Posting_spec_account_amountContext(context, state);
    enterRule(_localctx, 48, RULE_posting_spec_account_amount);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 213;
      account();
      state = 214;
      amount();
      state = 216;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_TAG) {
        state = 215;
        tags();
      }

      state = 219;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_T__4) {
        state = 218;
        inline_comment();
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  Posting_spec_explicit_per_priceContext posting_spec_explicit_per_price() {
    dynamic _localctx = Posting_spec_explicit_per_priceContext(context, state);
    enterRule(_localctx, 50, RULE_posting_spec_explicit_per_price);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 221;
      account();
      state = 222;
      amount();
      state = 223;
      match(TOKEN_T__13);
      state = 224;
      price();
      state = 226;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_TAG) {
        state = 225;
        tags();
      }

      state = 229;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_T__4) {
        state = 228;
        inline_comment();
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  Posting_spec_explicit_total_priceContext posting_spec_explicit_total_price() {
    dynamic _localctx =
        Posting_spec_explicit_total_priceContext(context, state);
    enterRule(_localctx, 52, RULE_posting_spec_explicit_total_price);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 231;
      account();
      state = 232;
      amount();
      state = 233;
      match(TOKEN_T__14);
      state = 234;
      price();
      state = 236;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_TAG) {
        state = 235;
        tags();
      }

      state = 239;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_T__4) {
        state = 238;
        inline_comment();
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  PriceContext price() {
    dynamic _localctx = PriceContext(context, state);
    enterRule(_localctx, 54, RULE_price);
    try {
      enterOuterAlt(_localctx, 1);
      state = 241;
      amount();
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  DateContext date() {
    dynamic _localctx = DateContext(context, state);
    enterRule(_localctx, 56, RULE_date);
    try {
      enterOuterAlt(_localctx, 1);
      state = 243;
      match(TOKEN_DATE);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  Quoted_stringContext quoted_string() {
    dynamic _localctx = Quoted_stringContext(context, state);
    enterRule(_localctx, 58, RULE_quoted_string);
    try {
      enterOuterAlt(_localctx, 1);
      state = 245;
      match(TOKEN_STR);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  TagsContext tags() {
    dynamic _localctx = TagsContext(context, state);
    enterRule(_localctx, 60, RULE_tags);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 248;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 247;
        match(TOKEN_TAG);
        state = 250;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while (_la == TOKEN_TAG);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  MetadataContext metadata() {
    dynamic _localctx = MetadataContext(context, state);
    enterRule(_localctx, 62, RULE_metadata);
    try {
      int _alt;
      enterOuterAlt(_localctx, 1);
      state = 259;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 21, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 252;
          metadata_key();
          state = 253;
          match(TOKEN_T__0);
          state = 254;
          metadata_value();
          state = 255;
          match(TOKEN_NEWLINE);
        }
        state = 261;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 21, context);
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  Metadata_keyContext metadata_key() {
    dynamic _localctx = Metadata_keyContext(context, state);
    enterRule(_localctx, 64, RULE_metadata_key);
    try {
      enterOuterAlt(_localctx, 1);
      state = 262;
      match(TOKEN_WORD);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  Metadata_valueContext metadata_value() {
    dynamic _localctx = Metadata_valueContext(context, state);
    enterRule(_localctx, 66, RULE_metadata_value);
    try {
      state = 269;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 22, context)) {
        case 1:
          enterOuterAlt(_localctx, 1);
          state = 264;
          quoted_string();
          break;
        case 2:
          enterOuterAlt(_localctx, 2);
          state = 265;
          match(TOKEN_TAG);
          break;
        case 3:
          enterOuterAlt(_localctx, 3);
          state = 266;
          match(TOKEN_NUMBER);
          break;
        case 4:
          enterOuterAlt(_localctx, 4);
          state = 267;
          amount();
          break;
        case 5:
          enterOuterAlt(_localctx, 5);
          state = 268;
          account();
          break;
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  static const List<int> _serializedATN = [
    4,
    1,
    27,
    272,
    2,
    0,
    7,
    0,
    2,
    1,
    7,
    1,
    2,
    2,
    7,
    2,
    2,
    3,
    7,
    3,
    2,
    4,
    7,
    4,
    2,
    5,
    7,
    5,
    2,
    6,
    7,
    6,
    2,
    7,
    7,
    7,
    2,
    8,
    7,
    8,
    2,
    9,
    7,
    9,
    2,
    10,
    7,
    10,
    2,
    11,
    7,
    11,
    2,
    12,
    7,
    12,
    2,
    13,
    7,
    13,
    2,
    14,
    7,
    14,
    2,
    15,
    7,
    15,
    2,
    16,
    7,
    16,
    2,
    17,
    7,
    17,
    2,
    18,
    7,
    18,
    2,
    19,
    7,
    19,
    2,
    20,
    7,
    20,
    2,
    21,
    7,
    21,
    2,
    22,
    7,
    22,
    2,
    23,
    7,
    23,
    2,
    24,
    7,
    24,
    2,
    25,
    7,
    25,
    2,
    26,
    7,
    26,
    2,
    27,
    7,
    27,
    2,
    28,
    7,
    28,
    2,
    29,
    7,
    29,
    2,
    30,
    7,
    30,
    2,
    31,
    7,
    31,
    2,
    32,
    7,
    32,
    2,
    33,
    7,
    33,
    1,
    0,
    1,
    0,
    5,
    0,
    71,
    8,
    0,
    10,
    0,
    12,
    0,
    74,
    9,
    0,
    1,
    0,
    1,
    0,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    3,
    1,
    82,
    8,
    1,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    3,
    2,
    93,
    8,
    2,
    1,
    2,
    1,
    2,
    1,
    3,
    1,
    3,
    1,
    3,
    4,
    3,
    100,
    8,
    3,
    11,
    3,
    12,
    3,
    101,
    1,
    4,
    1,
    4,
    1,
    5,
    1,
    5,
    1,
    5,
    1,
    6,
    1,
    6,
    1,
    6,
    1,
    7,
    1,
    7,
    1,
    7,
    1,
    7,
    1,
    8,
    1,
    8,
    5,
    8,
    118,
    8,
    8,
    10,
    8,
    12,
    8,
    121,
    9,
    8,
    1,
    8,
    1,
    8,
    1,
    9,
    1,
    9,
    1,
    9,
    1,
    9,
    1,
    9,
    1,
    10,
    1,
    10,
    1,
    10,
    1,
    10,
    1,
    11,
    1,
    11,
    1,
    11,
    1,
    11,
    1,
    12,
    1,
    12,
    1,
    12,
    1,
    12,
    1,
    13,
    1,
    13,
    1,
    13,
    1,
    13,
    1,
    13,
    1,
    14,
    1,
    14,
    1,
    14,
    1,
    14,
    1,
    14,
    1,
    15,
    1,
    15,
    1,
    15,
    1,
    15,
    1,
    15,
    1,
    16,
    1,
    16,
    1,
    16,
    1,
    16,
    1,
    16,
    1,
    17,
    1,
    17,
    1,
    18,
    1,
    18,
    1,
    18,
    1,
    18,
    1,
    18,
    5,
    18,
    169,
    8,
    18,
    10,
    18,
    12,
    18,
    172,
    9,
    18,
    1,
    18,
    1,
    18,
    1,
    18,
    1,
    18,
    1,
    18,
    3,
    18,
    179,
    8,
    18,
    1,
    18,
    1,
    18,
    4,
    18,
    183,
    8,
    18,
    11,
    18,
    12,
    18,
    184,
    1,
    19,
    1,
    19,
    1,
    19,
    1,
    19,
    3,
    19,
    191,
    8,
    19,
    1,
    19,
    3,
    19,
    194,
    8,
    19,
    1,
    20,
    1,
    20,
    1,
    21,
    1,
    21,
    5,
    21,
    200,
    8,
    21,
    10,
    21,
    12,
    21,
    203,
    9,
    21,
    1,
    22,
    1,
    22,
    1,
    23,
    1,
    23,
    3,
    23,
    209,
    8,
    23,
    1,
    23,
    3,
    23,
    212,
    8,
    23,
    1,
    24,
    1,
    24,
    1,
    24,
    3,
    24,
    217,
    8,
    24,
    1,
    24,
    3,
    24,
    220,
    8,
    24,
    1,
    25,
    1,
    25,
    1,
    25,
    1,
    25,
    1,
    25,
    3,
    25,
    227,
    8,
    25,
    1,
    25,
    3,
    25,
    230,
    8,
    25,
    1,
    26,
    1,
    26,
    1,
    26,
    1,
    26,
    1,
    26,
    3,
    26,
    237,
    8,
    26,
    1,
    26,
    3,
    26,
    240,
    8,
    26,
    1,
    27,
    1,
    27,
    1,
    28,
    1,
    28,
    1,
    29,
    1,
    29,
    1,
    30,
    4,
    30,
    249,
    8,
    30,
    11,
    30,
    12,
    30,
    250,
    1,
    31,
    1,
    31,
    1,
    31,
    1,
    31,
    1,
    31,
    5,
    31,
    258,
    8,
    31,
    10,
    31,
    12,
    31,
    261,
    9,
    31,
    1,
    32,
    1,
    32,
    1,
    33,
    1,
    33,
    1,
    33,
    1,
    33,
    1,
    33,
    3,
    33,
    270,
    8,
    33,
    1,
    33,
    0,
    0,
    34,
    0,
    2,
    4,
    6,
    8,
    10,
    12,
    14,
    16,
    18,
    20,
    22,
    24,
    26,
    28,
    30,
    32,
    34,
    36,
    38,
    40,
    42,
    44,
    46,
    48,
    50,
    52,
    54,
    56,
    58,
    60,
    62,
    64,
    66,
    0,
    2,
    1,
    0,
    4,
    5,
    1,
    0,
    25,
    25,
    274,
    0,
    72,
    1,
    0,
    0,
    0,
    2,
    81,
    1,
    0,
    0,
    0,
    4,
    92,
    1,
    0,
    0,
    0,
    6,
    96,
    1,
    0,
    0,
    0,
    8,
    103,
    1,
    0,
    0,
    0,
    10,
    105,
    1,
    0,
    0,
    0,
    12,
    108,
    1,
    0,
    0,
    0,
    14,
    111,
    1,
    0,
    0,
    0,
    16,
    115,
    1,
    0,
    0,
    0,
    18,
    124,
    1,
    0,
    0,
    0,
    20,
    129,
    1,
    0,
    0,
    0,
    22,
    133,
    1,
    0,
    0,
    0,
    24,
    137,
    1,
    0,
    0,
    0,
    26,
    141,
    1,
    0,
    0,
    0,
    28,
    146,
    1,
    0,
    0,
    0,
    30,
    151,
    1,
    0,
    0,
    0,
    32,
    156,
    1,
    0,
    0,
    0,
    34,
    161,
    1,
    0,
    0,
    0,
    36,
    163,
    1,
    0,
    0,
    0,
    38,
    186,
    1,
    0,
    0,
    0,
    40,
    195,
    1,
    0,
    0,
    0,
    42,
    197,
    1,
    0,
    0,
    0,
    44,
    204,
    1,
    0,
    0,
    0,
    46,
    206,
    1,
    0,
    0,
    0,
    48,
    213,
    1,
    0,
    0,
    0,
    50,
    221,
    1,
    0,
    0,
    0,
    52,
    231,
    1,
    0,
    0,
    0,
    54,
    241,
    1,
    0,
    0,
    0,
    56,
    243,
    1,
    0,
    0,
    0,
    58,
    245,
    1,
    0,
    0,
    0,
    60,
    248,
    1,
    0,
    0,
    0,
    62,
    259,
    1,
    0,
    0,
    0,
    64,
    262,
    1,
    0,
    0,
    0,
    66,
    269,
    1,
    0,
    0,
    0,
    68,
    71,
    3,
    2,
    1,
    0,
    69,
    71,
    3,
    34,
    17,
    0,
    70,
    68,
    1,
    0,
    0,
    0,
    70,
    69,
    1,
    0,
    0,
    0,
    71,
    74,
    1,
    0,
    0,
    0,
    72,
    70,
    1,
    0,
    0,
    0,
    72,
    73,
    1,
    0,
    0,
    0,
    73,
    75,
    1,
    0,
    0,
    0,
    74,
    72,
    1,
    0,
    0,
    0,
    75,
    76,
    5,
    0,
    0,
    1,
    76,
    1,
    1,
    0,
    0,
    0,
    77,
    82,
    3,
    4,
    2,
    0,
    78,
    82,
    3,
    12,
    6,
    0,
    79,
    82,
    3,
    14,
    7,
    0,
    80,
    82,
    3,
    16,
    8,
    0,
    81,
    77,
    1,
    0,
    0,
    0,
    81,
    78,
    1,
    0,
    0,
    0,
    81,
    79,
    1,
    0,
    0,
    0,
    81,
    80,
    1,
    0,
    0,
    0,
    82,
    3,
    1,
    0,
    0,
    0,
    83,
    93,
    3,
    18,
    9,
    0,
    84,
    93,
    3,
    20,
    10,
    0,
    85,
    93,
    3,
    22,
    11,
    0,
    86,
    93,
    3,
    24,
    12,
    0,
    87,
    93,
    3,
    26,
    13,
    0,
    88,
    93,
    3,
    28,
    14,
    0,
    89,
    93,
    3,
    30,
    15,
    0,
    90,
    93,
    3,
    32,
    16,
    0,
    91,
    93,
    3,
    36,
    18,
    0,
    92,
    83,
    1,
    0,
    0,
    0,
    92,
    84,
    1,
    0,
    0,
    0,
    92,
    85,
    1,
    0,
    0,
    0,
    92,
    86,
    1,
    0,
    0,
    0,
    92,
    87,
    1,
    0,
    0,
    0,
    92,
    88,
    1,
    0,
    0,
    0,
    92,
    89,
    1,
    0,
    0,
    0,
    92,
    90,
    1,
    0,
    0,
    0,
    92,
    91,
    1,
    0,
    0,
    0,
    93,
    94,
    1,
    0,
    0,
    0,
    94,
    95,
    5,
    25,
    0,
    0,
    95,
    5,
    1,
    0,
    0,
    0,
    96,
    99,
    5,
    23,
    0,
    0,
    97,
    98,
    5,
    1,
    0,
    0,
    98,
    100,
    5,
    23,
    0,
    0,
    99,
    97,
    1,
    0,
    0,
    0,
    100,
    101,
    1,
    0,
    0,
    0,
    101,
    99,
    1,
    0,
    0,
    0,
    101,
    102,
    1,
    0,
    0,
    0,
    102,
    7,
    1,
    0,
    0,
    0,
    103,
    104,
    5,
    23,
    0,
    0,
    104,
    9,
    1,
    0,
    0,
    0,
    105,
    106,
    5,
    21,
    0,
    0,
    106,
    107,
    3,
    8,
    4,
    0,
    107,
    11,
    1,
    0,
    0,
    0,
    108,
    109,
    5,
    2,
    0,
    0,
    109,
    110,
    3,
    58,
    29,
    0,
    110,
    13,
    1,
    0,
    0,
    0,
    111,
    112,
    5,
    3,
    0,
    0,
    112,
    113,
    3,
    58,
    29,
    0,
    113,
    114,
    3,
    58,
    29,
    0,
    114,
    15,
    1,
    0,
    0,
    0,
    115,
    119,
    7,
    0,
    0,
    0,
    116,
    118,
    8,
    1,
    0,
    0,
    117,
    116,
    1,
    0,
    0,
    0,
    118,
    121,
    1,
    0,
    0,
    0,
    119,
    117,
    1,
    0,
    0,
    0,
    119,
    120,
    1,
    0,
    0,
    0,
    120,
    122,
    1,
    0,
    0,
    0,
    121,
    119,
    1,
    0,
    0,
    0,
    122,
    123,
    5,
    25,
    0,
    0,
    123,
    17,
    1,
    0,
    0,
    0,
    124,
    125,
    3,
    56,
    28,
    0,
    125,
    126,
    5,
    6,
    0,
    0,
    126,
    127,
    3,
    6,
    3,
    0,
    127,
    128,
    3,
    10,
    5,
    0,
    128,
    19,
    1,
    0,
    0,
    0,
    129,
    130,
    3,
    56,
    28,
    0,
    130,
    131,
    5,
    7,
    0,
    0,
    131,
    132,
    3,
    6,
    3,
    0,
    132,
    21,
    1,
    0,
    0,
    0,
    133,
    134,
    3,
    56,
    28,
    0,
    134,
    135,
    5,
    8,
    0,
    0,
    135,
    136,
    3,
    6,
    3,
    0,
    136,
    23,
    1,
    0,
    0,
    0,
    137,
    138,
    3,
    56,
    28,
    0,
    138,
    139,
    5,
    9,
    0,
    0,
    139,
    140,
    3,
    8,
    4,
    0,
    140,
    25,
    1,
    0,
    0,
    0,
    141,
    142,
    3,
    56,
    28,
    0,
    142,
    143,
    5,
    10,
    0,
    0,
    143,
    144,
    3,
    8,
    4,
    0,
    144,
    145,
    3,
    10,
    5,
    0,
    145,
    27,
    1,
    0,
    0,
    0,
    146,
    147,
    3,
    56,
    28,
    0,
    147,
    148,
    5,
    11,
    0,
    0,
    148,
    149,
    3,
    58,
    29,
    0,
    149,
    150,
    3,
    58,
    29,
    0,
    150,
    29,
    1,
    0,
    0,
    0,
    151,
    152,
    3,
    56,
    28,
    0,
    152,
    153,
    5,
    12,
    0,
    0,
    153,
    154,
    3,
    6,
    3,
    0,
    154,
    155,
    3,
    58,
    29,
    0,
    155,
    31,
    1,
    0,
    0,
    0,
    156,
    157,
    3,
    56,
    28,
    0,
    157,
    158,
    5,
    13,
    0,
    0,
    158,
    159,
    3,
    6,
    3,
    0,
    159,
    160,
    3,
    58,
    29,
    0,
    160,
    33,
    1,
    0,
    0,
    0,
    161,
    162,
    5,
    25,
    0,
    0,
    162,
    35,
    1,
    0,
    0,
    0,
    163,
    164,
    3,
    38,
    19,
    0,
    164,
    170,
    5,
    25,
    0,
    0,
    165,
    166,
    3,
    44,
    22,
    0,
    166,
    167,
    5,
    25,
    0,
    0,
    167,
    169,
    1,
    0,
    0,
    0,
    168,
    165,
    1,
    0,
    0,
    0,
    169,
    172,
    1,
    0,
    0,
    0,
    170,
    168,
    1,
    0,
    0,
    0,
    170,
    171,
    1,
    0,
    0,
    0,
    171,
    173,
    1,
    0,
    0,
    0,
    172,
    170,
    1,
    0,
    0,
    0,
    173,
    182,
    3,
    62,
    31,
    0,
    174,
    179,
    3,
    46,
    23,
    0,
    175,
    179,
    3,
    48,
    24,
    0,
    176,
    179,
    3,
    50,
    25,
    0,
    177,
    179,
    3,
    52,
    26,
    0,
    178,
    174,
    1,
    0,
    0,
    0,
    178,
    175,
    1,
    0,
    0,
    0,
    178,
    176,
    1,
    0,
    0,
    0,
    178,
    177,
    1,
    0,
    0,
    0,
    179,
    180,
    1,
    0,
    0,
    0,
    180,
    181,
    5,
    25,
    0,
    0,
    181,
    183,
    1,
    0,
    0,
    0,
    182,
    178,
    1,
    0,
    0,
    0,
    183,
    184,
    1,
    0,
    0,
    0,
    184,
    182,
    1,
    0,
    0,
    0,
    184,
    185,
    1,
    0,
    0,
    0,
    185,
    37,
    1,
    0,
    0,
    0,
    186,
    187,
    3,
    56,
    28,
    0,
    187,
    188,
    3,
    40,
    20,
    0,
    188,
    190,
    3,
    58,
    29,
    0,
    189,
    191,
    3,
    58,
    29,
    0,
    190,
    189,
    1,
    0,
    0,
    0,
    190,
    191,
    1,
    0,
    0,
    0,
    191,
    193,
    1,
    0,
    0,
    0,
    192,
    194,
    3,
    60,
    30,
    0,
    193,
    192,
    1,
    0,
    0,
    0,
    193,
    194,
    1,
    0,
    0,
    0,
    194,
    39,
    1,
    0,
    0,
    0,
    195,
    196,
    5,
    26,
    0,
    0,
    196,
    41,
    1,
    0,
    0,
    0,
    197,
    201,
    5,
    5,
    0,
    0,
    198,
    200,
    8,
    1,
    0,
    0,
    199,
    198,
    1,
    0,
    0,
    0,
    200,
    203,
    1,
    0,
    0,
    0,
    201,
    199,
    1,
    0,
    0,
    0,
    201,
    202,
    1,
    0,
    0,
    0,
    202,
    43,
    1,
    0,
    0,
    0,
    203,
    201,
    1,
    0,
    0,
    0,
    204,
    205,
    3,
    42,
    21,
    0,
    205,
    45,
    1,
    0,
    0,
    0,
    206,
    208,
    3,
    6,
    3,
    0,
    207,
    209,
    3,
    60,
    30,
    0,
    208,
    207,
    1,
    0,
    0,
    0,
    208,
    209,
    1,
    0,
    0,
    0,
    209,
    211,
    1,
    0,
    0,
    0,
    210,
    212,
    3,
    42,
    21,
    0,
    211,
    210,
    1,
    0,
    0,
    0,
    211,
    212,
    1,
    0,
    0,
    0,
    212,
    47,
    1,
    0,
    0,
    0,
    213,
    214,
    3,
    6,
    3,
    0,
    214,
    216,
    3,
    10,
    5,
    0,
    215,
    217,
    3,
    60,
    30,
    0,
    216,
    215,
    1,
    0,
    0,
    0,
    216,
    217,
    1,
    0,
    0,
    0,
    217,
    219,
    1,
    0,
    0,
    0,
    218,
    220,
    3,
    42,
    21,
    0,
    219,
    218,
    1,
    0,
    0,
    0,
    219,
    220,
    1,
    0,
    0,
    0,
    220,
    49,
    1,
    0,
    0,
    0,
    221,
    222,
    3,
    6,
    3,
    0,
    222,
    223,
    3,
    10,
    5,
    0,
    223,
    224,
    5,
    14,
    0,
    0,
    224,
    226,
    3,
    54,
    27,
    0,
    225,
    227,
    3,
    60,
    30,
    0,
    226,
    225,
    1,
    0,
    0,
    0,
    226,
    227,
    1,
    0,
    0,
    0,
    227,
    229,
    1,
    0,
    0,
    0,
    228,
    230,
    3,
    42,
    21,
    0,
    229,
    228,
    1,
    0,
    0,
    0,
    229,
    230,
    1,
    0,
    0,
    0,
    230,
    51,
    1,
    0,
    0,
    0,
    231,
    232,
    3,
    6,
    3,
    0,
    232,
    233,
    3,
    10,
    5,
    0,
    233,
    234,
    5,
    15,
    0,
    0,
    234,
    236,
    3,
    54,
    27,
    0,
    235,
    237,
    3,
    60,
    30,
    0,
    236,
    235,
    1,
    0,
    0,
    0,
    236,
    237,
    1,
    0,
    0,
    0,
    237,
    239,
    1,
    0,
    0,
    0,
    238,
    240,
    3,
    42,
    21,
    0,
    239,
    238,
    1,
    0,
    0,
    0,
    239,
    240,
    1,
    0,
    0,
    0,
    240,
    53,
    1,
    0,
    0,
    0,
    241,
    242,
    3,
    10,
    5,
    0,
    242,
    55,
    1,
    0,
    0,
    0,
    243,
    244,
    5,
    20,
    0,
    0,
    244,
    57,
    1,
    0,
    0,
    0,
    245,
    246,
    5,
    27,
    0,
    0,
    246,
    59,
    1,
    0,
    0,
    0,
    247,
    249,
    5,
    22,
    0,
    0,
    248,
    247,
    1,
    0,
    0,
    0,
    249,
    250,
    1,
    0,
    0,
    0,
    250,
    248,
    1,
    0,
    0,
    0,
    250,
    251,
    1,
    0,
    0,
    0,
    251,
    61,
    1,
    0,
    0,
    0,
    252,
    253,
    3,
    64,
    32,
    0,
    253,
    254,
    5,
    1,
    0,
    0,
    254,
    255,
    3,
    66,
    33,
    0,
    255,
    256,
    5,
    25,
    0,
    0,
    256,
    258,
    1,
    0,
    0,
    0,
    257,
    252,
    1,
    0,
    0,
    0,
    258,
    261,
    1,
    0,
    0,
    0,
    259,
    257,
    1,
    0,
    0,
    0,
    259,
    260,
    1,
    0,
    0,
    0,
    260,
    63,
    1,
    0,
    0,
    0,
    261,
    259,
    1,
    0,
    0,
    0,
    262,
    263,
    5,
    23,
    0,
    0,
    263,
    65,
    1,
    0,
    0,
    0,
    264,
    270,
    3,
    58,
    29,
    0,
    265,
    270,
    5,
    22,
    0,
    0,
    266,
    270,
    5,
    21,
    0,
    0,
    267,
    270,
    3,
    10,
    5,
    0,
    268,
    270,
    3,
    6,
    3,
    0,
    269,
    264,
    1,
    0,
    0,
    0,
    269,
    265,
    1,
    0,
    0,
    0,
    269,
    266,
    1,
    0,
    0,
    0,
    269,
    267,
    1,
    0,
    0,
    0,
    269,
    268,
    1,
    0,
    0,
    0,
    270,
    67,
    1,
    0,
    0,
    0,
    23,
    70,
    72,
    81,
    92,
    101,
    119,
    170,
    178,
    184,
    190,
    193,
    201,
    208,
    211,
    216,
    219,
    226,
    229,
    236,
    239,
    250,
    259,
    269
  ];

  static final ATN _ATN = ATNDeserializer().deserialize(_serializedATN);
}

class AllContext extends ParserRuleContext {
  TerminalNode? EOF() => getToken(BeancountParser.TOKEN_EOF, 0);
  List<StatementContext> statements() => getRuleContexts<StatementContext>();
  StatementContext? statement(int i) => getRuleContext<StatementContext>(i);
  List<Empty_lineContext> empty_lines() => getRuleContexts<Empty_lineContext>();
  Empty_lineContext? empty_line(int i) => getRuleContext<Empty_lineContext>(i);
  AllContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_all;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterAll(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitAll(this);
  }
}

class StatementContext extends ParserRuleContext {
  DirectiveContext? directive() => getRuleContext<DirectiveContext>(0);
  IncludeStatementContext? includeStatement() =>
      getRuleContext<IncludeStatementContext>(0);
  OptionStatementContext? optionStatement() =>
      getRuleContext<OptionStatementContext>(0);
  CommentStatementContext? commentStatement() =>
      getRuleContext<CommentStatementContext>(0);
  StatementContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_statement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterStatement(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitStatement(this);
  }
}

class DirectiveContext extends ParserRuleContext {
  TerminalNode? NEWLINE() => getToken(BeancountParser.TOKEN_NEWLINE, 0);
  BalanceStatementContext? balanceStatement() =>
      getRuleContext<BalanceStatementContext>(0);
  CloseStatementContext? closeStatement() =>
      getRuleContext<CloseStatementContext>(0);
  OpenStatementContext? openStatement() =>
      getRuleContext<OpenStatementContext>(0);
  CommodityStatementContext? commodityStatement() =>
      getRuleContext<CommodityStatementContext>(0);
  PriceStatementContext? priceStatement() =>
      getRuleContext<PriceStatementContext>(0);
  EventStatementContext? eventStatement() =>
      getRuleContext<EventStatementContext>(0);
  DocumentStatementContext? documentStatement() =>
      getRuleContext<DocumentStatementContext>(0);
  NoteStatementContext? noteStatement() =>
      getRuleContext<NoteStatementContext>(0);
  TrStatementContext? trStatement() => getRuleContext<TrStatementContext>(0);
  DirectiveContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_directive;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterDirective(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitDirective(this);
  }
}

class AccountContext extends ParserRuleContext {
  List<TerminalNode> WORDs() => getTokens(BeancountParser.TOKEN_WORD);
  TerminalNode? WORD(int i) => getToken(BeancountParser.TOKEN_WORD, i);
  AccountContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_account;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterAccount(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitAccount(this);
  }
}

class CurrencyContext extends ParserRuleContext {
  TerminalNode? WORD() => getToken(BeancountParser.TOKEN_WORD, 0);
  CurrencyContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_currency;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterCurrency(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitCurrency(this);
  }
}

class AmountContext extends ParserRuleContext {
  TerminalNode? NUMBER() => getToken(BeancountParser.TOKEN_NUMBER, 0);
  CurrencyContext? currency() => getRuleContext<CurrencyContext>(0);
  AmountContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_amount;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterAmount(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitAmount(this);
  }
}

class IncludeStatementContext extends ParserRuleContext {
  Quoted_stringContext? quoted_string() =>
      getRuleContext<Quoted_stringContext>(0);
  IncludeStatementContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_includeStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterIncludeStatement(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitIncludeStatement(this);
  }
}

class OptionStatementContext extends ParserRuleContext {
  Quoted_stringContext? key;
  Quoted_stringContext? value;
  List<Quoted_stringContext> quoted_strings() =>
      getRuleContexts<Quoted_stringContext>();
  Quoted_stringContext? quoted_string(int i) =>
      getRuleContext<Quoted_stringContext>(i);
  OptionStatementContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_optionStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterOptionStatement(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitOptionStatement(this);
  }
}

class CommentStatementContext extends ParserRuleContext {
  List<TerminalNode> NEWLINEs() => getTokens(BeancountParser.TOKEN_NEWLINE);
  TerminalNode? NEWLINE(int i) => getToken(BeancountParser.TOKEN_NEWLINE, i);
  CommentStatementContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_commentStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterCommentStatement(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitCommentStatement(this);
  }
}

class BalanceStatementContext extends ParserRuleContext {
  DateContext? date() => getRuleContext<DateContext>(0);
  AccountContext? account() => getRuleContext<AccountContext>(0);
  AmountContext? amount() => getRuleContext<AmountContext>(0);
  BalanceStatementContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_balanceStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterBalanceStatement(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitBalanceStatement(this);
  }
}

class CloseStatementContext extends ParserRuleContext {
  DateContext? date() => getRuleContext<DateContext>(0);
  AccountContext? account() => getRuleContext<AccountContext>(0);
  CloseStatementContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_closeStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterCloseStatement(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitCloseStatement(this);
  }
}

class OpenStatementContext extends ParserRuleContext {
  DateContext? date() => getRuleContext<DateContext>(0);
  AccountContext? account() => getRuleContext<AccountContext>(0);
  OpenStatementContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_openStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterOpenStatement(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitOpenStatement(this);
  }
}

class CommodityStatementContext extends ParserRuleContext {
  DateContext? date() => getRuleContext<DateContext>(0);
  CurrencyContext? currency() => getRuleContext<CurrencyContext>(0);
  CommodityStatementContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_commodityStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterCommodityStatement(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitCommodityStatement(this);
  }
}

class PriceStatementContext extends ParserRuleContext {
  DateContext? date() => getRuleContext<DateContext>(0);
  CurrencyContext? currency() => getRuleContext<CurrencyContext>(0);
  AmountContext? amount() => getRuleContext<AmountContext>(0);
  PriceStatementContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_priceStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterPriceStatement(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitPriceStatement(this);
  }
}

class EventStatementContext extends ParserRuleContext {
  Quoted_stringContext? name;
  Quoted_stringContext? value;
  DateContext? date() => getRuleContext<DateContext>(0);
  List<Quoted_stringContext> quoted_strings() =>
      getRuleContexts<Quoted_stringContext>();
  Quoted_stringContext? quoted_string(int i) =>
      getRuleContext<Quoted_stringContext>(i);
  EventStatementContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_eventStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterEventStatement(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitEventStatement(this);
  }
}

class DocumentStatementContext extends ParserRuleContext {
  DateContext? date() => getRuleContext<DateContext>(0);
  AccountContext? account() => getRuleContext<AccountContext>(0);
  Quoted_stringContext? quoted_string() =>
      getRuleContext<Quoted_stringContext>(0);
  DocumentStatementContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_documentStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterDocumentStatement(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitDocumentStatement(this);
  }
}

class NoteStatementContext extends ParserRuleContext {
  DateContext? date() => getRuleContext<DateContext>(0);
  AccountContext? account() => getRuleContext<AccountContext>(0);
  Quoted_stringContext? quoted_string() =>
      getRuleContext<Quoted_stringContext>(0);
  NoteStatementContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_noteStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterNoteStatement(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitNoteStatement(this);
  }
}

class Empty_lineContext extends ParserRuleContext {
  TerminalNode? NEWLINE() => getToken(BeancountParser.TOKEN_NEWLINE, 0);
  Empty_lineContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_empty_line;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterEmpty_line(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitEmpty_line(this);
  }
}

class TrStatementContext extends ParserRuleContext {
  Tr_headerContext? tr_header() => getRuleContext<Tr_headerContext>(0);
  List<TerminalNode> NEWLINEs() => getTokens(BeancountParser.TOKEN_NEWLINE);
  TerminalNode? NEWLINE(int i) => getToken(BeancountParser.TOKEN_NEWLINE, i);
  MetadataContext? metadata() => getRuleContext<MetadataContext>(0);
  List<Tr_commentContext> tr_comments() => getRuleContexts<Tr_commentContext>();
  Tr_commentContext? tr_comment(int i) => getRuleContext<Tr_commentContext>(i);
  List<Posting_spec_account_onlyContext> posting_spec_account_onlys() =>
      getRuleContexts<Posting_spec_account_onlyContext>();
  Posting_spec_account_onlyContext? posting_spec_account_only(int i) =>
      getRuleContext<Posting_spec_account_onlyContext>(i);
  List<Posting_spec_account_amountContext> posting_spec_account_amounts() =>
      getRuleContexts<Posting_spec_account_amountContext>();
  Posting_spec_account_amountContext? posting_spec_account_amount(int i) =>
      getRuleContext<Posting_spec_account_amountContext>(i);
  List<Posting_spec_explicit_per_priceContext>
      posting_spec_explicit_per_prices() =>
          getRuleContexts<Posting_spec_explicit_per_priceContext>();
  Posting_spec_explicit_per_priceContext? posting_spec_explicit_per_price(
          int i) =>
      getRuleContext<Posting_spec_explicit_per_priceContext>(i);
  List<Posting_spec_explicit_total_priceContext>
      posting_spec_explicit_total_prices() =>
          getRuleContexts<Posting_spec_explicit_total_priceContext>();
  Posting_spec_explicit_total_priceContext? posting_spec_explicit_total_price(
          int i) =>
      getRuleContext<Posting_spec_explicit_total_priceContext>(i);
  TrStatementContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_trStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterTrStatement(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitTrStatement(this);
  }
}

class Tr_headerContext extends ParserRuleContext {
  Quoted_stringContext? narration;
  Quoted_stringContext? payee;
  DateContext? date() => getRuleContext<DateContext>(0);
  Tr_flagContext? tr_flag() => getRuleContext<Tr_flagContext>(0);
  List<Quoted_stringContext> quoted_strings() =>
      getRuleContexts<Quoted_stringContext>();
  Quoted_stringContext? quoted_string(int i) =>
      getRuleContext<Quoted_stringContext>(i);
  TagsContext? tags() => getRuleContext<TagsContext>(0);
  Tr_headerContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_tr_header;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterTr_header(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitTr_header(this);
  }
}

class Tr_flagContext extends ParserRuleContext {
  TerminalNode? TR_FLAG() => getToken(BeancountParser.TOKEN_TR_FLAG, 0);
  Tr_flagContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_tr_flag;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterTr_flag(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitTr_flag(this);
  }
}

class Inline_commentContext extends ParserRuleContext {
  List<TerminalNode> NEWLINEs() => getTokens(BeancountParser.TOKEN_NEWLINE);
  TerminalNode? NEWLINE(int i) => getToken(BeancountParser.TOKEN_NEWLINE, i);
  Inline_commentContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_inline_comment;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterInline_comment(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitInline_comment(this);
  }
}

class Tr_commentContext extends ParserRuleContext {
  Inline_commentContext? inline_comment() =>
      getRuleContext<Inline_commentContext>(0);
  Tr_commentContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_tr_comment;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterTr_comment(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitTr_comment(this);
  }
}

class Posting_spec_account_onlyContext extends ParserRuleContext {
  AccountContext? account() => getRuleContext<AccountContext>(0);
  TagsContext? tags() => getRuleContext<TagsContext>(0);
  Inline_commentContext? inline_comment() =>
      getRuleContext<Inline_commentContext>(0);
  Posting_spec_account_onlyContext(
      [ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_posting_spec_account_only;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener)
      listener.enterPosting_spec_account_only(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener)
      listener.exitPosting_spec_account_only(this);
  }
}

class Posting_spec_account_amountContext extends ParserRuleContext {
  AccountContext? account() => getRuleContext<AccountContext>(0);
  AmountContext? amount() => getRuleContext<AmountContext>(0);
  TagsContext? tags() => getRuleContext<TagsContext>(0);
  Inline_commentContext? inline_comment() =>
      getRuleContext<Inline_commentContext>(0);
  Posting_spec_account_amountContext(
      [ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_posting_spec_account_amount;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener)
      listener.enterPosting_spec_account_amount(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener)
      listener.exitPosting_spec_account_amount(this);
  }
}

class Posting_spec_explicit_per_priceContext extends ParserRuleContext {
  AccountContext? account() => getRuleContext<AccountContext>(0);
  AmountContext? amount() => getRuleContext<AmountContext>(0);
  PriceContext? price() => getRuleContext<PriceContext>(0);
  TagsContext? tags() => getRuleContext<TagsContext>(0);
  Inline_commentContext? inline_comment() =>
      getRuleContext<Inline_commentContext>(0);
  Posting_spec_explicit_per_priceContext(
      [ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_posting_spec_explicit_per_price;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener)
      listener.enterPosting_spec_explicit_per_price(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener)
      listener.exitPosting_spec_explicit_per_price(this);
  }
}

class Posting_spec_explicit_total_priceContext extends ParserRuleContext {
  AccountContext? account() => getRuleContext<AccountContext>(0);
  AmountContext? amount() => getRuleContext<AmountContext>(0);
  PriceContext? price() => getRuleContext<PriceContext>(0);
  TagsContext? tags() => getRuleContext<TagsContext>(0);
  Inline_commentContext? inline_comment() =>
      getRuleContext<Inline_commentContext>(0);
  Posting_spec_explicit_total_priceContext(
      [ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_posting_spec_explicit_total_price;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener)
      listener.enterPosting_spec_explicit_total_price(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener)
      listener.exitPosting_spec_explicit_total_price(this);
  }
}

class PriceContext extends ParserRuleContext {
  AmountContext? amount() => getRuleContext<AmountContext>(0);
  PriceContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_price;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterPrice(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitPrice(this);
  }
}

class DateContext extends ParserRuleContext {
  TerminalNode? DATE() => getToken(BeancountParser.TOKEN_DATE, 0);
  DateContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_date;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterDate(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitDate(this);
  }
}

class Quoted_stringContext extends ParserRuleContext {
  TerminalNode? STR() => getToken(BeancountParser.TOKEN_STR, 0);
  Quoted_stringContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_quoted_string;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterQuoted_string(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitQuoted_string(this);
  }
}

class TagsContext extends ParserRuleContext {
  List<TerminalNode> TAGs() => getTokens(BeancountParser.TOKEN_TAG);
  TerminalNode? TAG(int i) => getToken(BeancountParser.TOKEN_TAG, i);
  TagsContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_tags;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterTags(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitTags(this);
  }
}

class MetadataContext extends ParserRuleContext {
  List<Metadata_keyContext> metadata_keys() =>
      getRuleContexts<Metadata_keyContext>();
  Metadata_keyContext? metadata_key(int i) =>
      getRuleContext<Metadata_keyContext>(i);
  List<Metadata_valueContext> metadata_values() =>
      getRuleContexts<Metadata_valueContext>();
  Metadata_valueContext? metadata_value(int i) =>
      getRuleContext<Metadata_valueContext>(i);
  List<TerminalNode> NEWLINEs() => getTokens(BeancountParser.TOKEN_NEWLINE);
  TerminalNode? NEWLINE(int i) => getToken(BeancountParser.TOKEN_NEWLINE, i);
  MetadataContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_metadata;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterMetadata(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitMetadata(this);
  }
}

class Metadata_keyContext extends ParserRuleContext {
  TerminalNode? WORD() => getToken(BeancountParser.TOKEN_WORD, 0);
  Metadata_keyContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_metadata_key;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterMetadata_key(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitMetadata_key(this);
  }
}

class Metadata_valueContext extends ParserRuleContext {
  Quoted_stringContext? quoted_string() =>
      getRuleContext<Quoted_stringContext>(0);
  TerminalNode? TAG() => getToken(BeancountParser.TOKEN_TAG, 0);
  TerminalNode? NUMBER() => getToken(BeancountParser.TOKEN_NUMBER, 0);
  AmountContext? amount() => getRuleContext<AmountContext>(0);
  AccountContext? account() => getRuleContext<AccountContext>(0);
  Metadata_valueContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_metadata_value;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.enterMetadata_value(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is BeancountListener) listener.exitMetadata_value(this);
  }
}
