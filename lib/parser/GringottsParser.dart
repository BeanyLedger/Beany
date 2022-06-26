// Generated from Gringotts.g4 by ANTLR 4.10.1
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes
import 'package:antlr4/antlr4.dart';

import 'GringottsListener.dart';
import 'GringottsBaseListener.dart';
const int RULE_all = 0, RULE_statement = 1, RULE_directive = 2, RULE_account = 3, 
          RULE_currency = 4, RULE_amount = 5, RULE_includeStatement = 6, 
          RULE_optionStatement = 7, RULE_commentStatement = 8, RULE_balanceStatement = 9, 
          RULE_closeStatement = 10, RULE_openStatement = 11, RULE_commodityStatement = 12, 
          RULE_priceStatement = 13, RULE_eventStatement = 14, RULE_documentStatement = 15, 
          RULE_noteStatement = 16, RULE_empty_line = 17, RULE_trStatement = 18, 
          RULE_tr_header = 19, RULE_inline_comment = 20, RULE_tr_comment = 21, 
          RULE_posting_spec_account_only = 22, RULE_posting_spec_account_amount = 23, 
          RULE_posting_spec_explicit_per_cost = 24, RULE_cost = 25, RULE_date = 26, 
          RULE_quoted_string = 27, RULE_tags = 28;
class GringottsParser extends Parser {
  static final checkVersion = () => RuntimeMetaData.checkVersion('4.10.1', RuntimeMetaData.VERSION);
  static const int TOKEN_EOF = IntStream.EOF;

  static final List<DFA> _decisionToDFA = List.generate(
      _ATN.numberOfDecisions, (i) => DFA(_ATN.getDecisionState(i), i));
  static final PredictionContextCache _sharedContextCache = PredictionContextCache();
  static const int TOKEN_T__0 = 1, TOKEN_T__1 = 2, TOKEN_T__2 = 3, TOKEN_T__3 = 4, 
                   TOKEN_T__4 = 5, TOKEN_T__5 = 6, TOKEN_T__6 = 7, TOKEN_T__7 = 8, 
                   TOKEN_T__8 = 9, TOKEN_T__9 = 10, TOKEN_T__10 = 11, TOKEN_T__11 = 12, 
                   TOKEN_T__12 = 13, TOKEN_T__13 = 14, TOKEN_DIGIT = 15, 
                   TOKEN_YEAR = 16, TOKEN_MONTH = 17, TOKEN_DAY = 18, TOKEN_DATE = 19, 
                   TOKEN_NUMBER = 20, TOKEN_TAG = 21, TOKEN_WORD = 22, TOKEN_WHITESPACE = 23, 
                   TOKEN_NEWLINE = 24, TOKEN_TR_FLAG = 25, TOKEN_STR = 26;

  @override
  final List<String> ruleNames = [
    'all', 'statement', 'directive', 'account', 'currency', 'amount', 'includeStatement', 
    'optionStatement', 'commentStatement', 'balanceStatement', 'closeStatement', 
    'openStatement', 'commodityStatement', 'priceStatement', 'eventStatement', 
    'documentStatement', 'noteStatement', 'empty_line', 'trStatement', 'tr_header', 
    'inline_comment', 'tr_comment', 'posting_spec_account_only', 'posting_spec_account_amount', 
    'posting_spec_explicit_per_cost', 'cost', 'date', 'quoted_string', 'tags'
  ];

  static final List<String?> _LITERAL_NAMES = [
      null, "':'", "'include'", "'option'", "'#'", "';'", "'balance'", "'close'", 
      "'open'", "'commodity'", "'price'", "'event'", "'document'", "'note'", 
      "'@'"
  ];
  static final List<String?> _SYMBOLIC_NAMES = [
      null, null, null, null, null, null, null, null, null, null, null, 
      null, null, null, null, "DIGIT", "YEAR", "MONTH", "DAY", "DATE", "NUMBER", 
      "TAG", "WORD", "WHITESPACE", "NEWLINE", "TR_FLAG", "STR"
  ];
  static final Vocabulary VOCABULARY = VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

  @override
  Vocabulary get vocabulary {
    return VOCABULARY;
  }

  @override
  String get grammarFileName => 'Gringotts.g4';

  @override
  List<int> get serializedATN => _serializedATN;

  @override
  ATN getATN() {
   return _ATN;
  }

  GringottsParser(TokenStream input) : super(input) {
    interpreter = ParserATNSimulator(this, _ATN, _decisionToDFA, _sharedContextCache);
  }

  AllContext all() {
    dynamic _localctx = AllContext(context, state);
    enterRule(_localctx, 0, RULE_all);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 62;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while ((((_la) & ~0x3f) == 0 && ((BigInt.one << _la) & ((BigInt.one << TOKEN_T__1) | (BigInt.one << TOKEN_T__2) | (BigInt.one << TOKEN_T__3) | (BigInt.one << TOKEN_T__4) | (BigInt.one << TOKEN_DATE) | (BigInt.one << TOKEN_NEWLINE))) != BigInt.zero)) {
        state = 60;
        errorHandler.sync(this);
        switch (tokenStream.LA(1)!) {
        case TOKEN_T__1:
        case TOKEN_T__2:
        case TOKEN_T__3:
        case TOKEN_T__4:
        case TOKEN_DATE:
          state = 58;
          statement();
          break;
        case TOKEN_NEWLINE:
          state = 59;
          empty_line();
          break;
        default:
          throw NoViableAltException(this);
        }
        state = 64;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 65;
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
      state = 71;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_DATE:
        enterOuterAlt(_localctx, 1);
        state = 67;
        directive();
        break;
      case TOKEN_T__1:
        enterOuterAlt(_localctx, 2);
        state = 68;
        includeStatement();
        break;
      case TOKEN_T__2:
        enterOuterAlt(_localctx, 3);
        state = 69;
        optionStatement();
        break;
      case TOKEN_T__3:
      case TOKEN_T__4:
        enterOuterAlt(_localctx, 4);
        state = 70;
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
      state = 82;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 3, context)) {
      case 1:
        state = 73;
        balanceStatement();
        break;
      case 2:
        state = 74;
        closeStatement();
        break;
      case 3:
        state = 75;
        openStatement();
        break;
      case 4:
        state = 76;
        commodityStatement();
        break;
      case 5:
        state = 77;
        priceStatement();
        break;
      case 6:
        state = 78;
        eventStatement();
        break;
      case 7:
        state = 79;
        documentStatement();
        break;
      case 8:
        state = 80;
        noteStatement();
        break;
      case 9:
        state = 81;
        trStatement();
        break;
      }
      state = 84;
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
      state = 86;
      match(TOKEN_WORD);
      state = 89; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 87;
        match(TOKEN_T__0);
        state = 88;
        match(TOKEN_WORD);
        state = 91; 
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
      state = 93;
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
      state = 95;
      match(TOKEN_NUMBER);
      state = 96;
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
      state = 98;
      match(TOKEN_T__1);
      state = 99;
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
      state = 101;
      match(TOKEN_T__2);
      state = 102;
      _localctx.key = quoted_string();
      state = 103;
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
      state = 105;
      _la = tokenStream.LA(1)!;
      if (!(_la == TOKEN_T__3 || _la == TOKEN_T__4)) {
      errorHandler.recoverInline(this);
      } else {
        if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
      state = 109;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while ((((_la) & ~0x3f) == 0 && ((BigInt.one << _la) & ((BigInt.one << TOKEN_T__0) | (BigInt.one << TOKEN_T__1) | (BigInt.one << TOKEN_T__2) | (BigInt.one << TOKEN_T__3) | (BigInt.one << TOKEN_T__4) | (BigInt.one << TOKEN_T__5) | (BigInt.one << TOKEN_T__6) | (BigInt.one << TOKEN_T__7) | (BigInt.one << TOKEN_T__8) | (BigInt.one << TOKEN_T__9) | (BigInt.one << TOKEN_T__10) | (BigInt.one << TOKEN_T__11) | (BigInt.one << TOKEN_T__12) | (BigInt.one << TOKEN_T__13) | (BigInt.one << TOKEN_DIGIT) | (BigInt.one << TOKEN_YEAR) | (BigInt.one << TOKEN_MONTH) | (BigInt.one << TOKEN_DAY) | (BigInt.one << TOKEN_DATE) | (BigInt.one << TOKEN_NUMBER) | (BigInt.one << TOKEN_TAG) | (BigInt.one << TOKEN_WORD) | (BigInt.one << TOKEN_WHITESPACE) | (BigInt.one << TOKEN_TR_FLAG) | (BigInt.one << TOKEN_STR))) != BigInt.zero)) {
        state = 106;
        _la = tokenStream.LA(1)!;
        if (_la <= 0 || (_la == TOKEN_NEWLINE)) {
        errorHandler.recoverInline(this);
        } else {
          if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
          errorHandler.reportMatch(this);
          consume();
        }
        state = 111;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 112;
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
      state = 114;
      date();
      state = 115;
      match(TOKEN_T__5);
      state = 116;
      account();
      state = 117;
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
      state = 119;
      date();
      state = 120;
      match(TOKEN_T__6);
      state = 121;
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
      state = 123;
      date();
      state = 124;
      match(TOKEN_T__7);
      state = 125;
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
      state = 127;
      date();
      state = 128;
      match(TOKEN_T__8);
      state = 129;
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
      state = 131;
      date();
      state = 132;
      match(TOKEN_T__9);
      state = 133;
      currency();
      state = 134;
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
      state = 136;
      date();
      state = 137;
      match(TOKEN_T__10);
      state = 138;
      _localctx.name = quoted_string();
      state = 139;
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
      state = 141;
      date();
      state = 142;
      match(TOKEN_T__11);
      state = 143;
      account();
      state = 144;
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
      state = 146;
      date();
      state = 147;
      match(TOKEN_T__12);
      state = 148;
      account();
      state = 149;
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
      state = 151;
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
      state = 153;
      tr_header();
      state = 154;
      match(TOKEN_NEWLINE);
      state = 160;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_T__4) {
        state = 155;
        tr_comment();
        state = 156;
        match(TOKEN_NEWLINE);
        state = 162;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 170; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 166;
        errorHandler.sync(this);
        switch (interpreter!.adaptivePredict(tokenStream, 7, context)) {
        case 1:
          state = 163;
          posting_spec_account_only();
          break;
        case 2:
          state = 164;
          posting_spec_account_amount();
          break;
        case 3:
          state = 165;
          posting_spec_explicit_per_cost();
          break;
        }
        state = 168;
        match(TOKEN_NEWLINE);
        state = 172; 
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
      state = 174;
      date();
      state = 175;
      match(TOKEN_TR_FLAG);
      state = 176;
      _localctx.narration = quoted_string();
      state = 178;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_STR) {
        state = 177;
        _localctx.payee = quoted_string();
      }

      state = 181;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_TAG) {
        state = 180;
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

  Inline_commentContext inline_comment() {
    dynamic _localctx = Inline_commentContext(context, state);
    enterRule(_localctx, 40, RULE_inline_comment);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 183;
      match(TOKEN_T__4);
      state = 187;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while ((((_la) & ~0x3f) == 0 && ((BigInt.one << _la) & ((BigInt.one << TOKEN_T__0) | (BigInt.one << TOKEN_T__1) | (BigInt.one << TOKEN_T__2) | (BigInt.one << TOKEN_T__3) | (BigInt.one << TOKEN_T__4) | (BigInt.one << TOKEN_T__5) | (BigInt.one << TOKEN_T__6) | (BigInt.one << TOKEN_T__7) | (BigInt.one << TOKEN_T__8) | (BigInt.one << TOKEN_T__9) | (BigInt.one << TOKEN_T__10) | (BigInt.one << TOKEN_T__11) | (BigInt.one << TOKEN_T__12) | (BigInt.one << TOKEN_T__13) | (BigInt.one << TOKEN_DIGIT) | (BigInt.one << TOKEN_YEAR) | (BigInt.one << TOKEN_MONTH) | (BigInt.one << TOKEN_DAY) | (BigInt.one << TOKEN_DATE) | (BigInt.one << TOKEN_NUMBER) | (BigInt.one << TOKEN_TAG) | (BigInt.one << TOKEN_WORD) | (BigInt.one << TOKEN_WHITESPACE) | (BigInt.one << TOKEN_TR_FLAG) | (BigInt.one << TOKEN_STR))) != BigInt.zero)) {
        state = 184;
        _la = tokenStream.LA(1)!;
        if (_la <= 0 || (_la == TOKEN_NEWLINE)) {
        errorHandler.recoverInline(this);
        } else {
          if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
          errorHandler.reportMatch(this);
          consume();
        }
        state = 189;
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
    enterRule(_localctx, 42, RULE_tr_comment);
    try {
      enterOuterAlt(_localctx, 1);
      state = 190;
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
    enterRule(_localctx, 44, RULE_posting_spec_account_only);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 192;
      account();
      state = 194;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_TAG) {
        state = 193;
        tags();
      }

      state = 197;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_T__4) {
        state = 196;
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
    enterRule(_localctx, 46, RULE_posting_spec_account_amount);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 199;
      account();
      state = 200;
      amount();
      state = 202;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_TAG) {
        state = 201;
        tags();
      }

      state = 205;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_T__4) {
        state = 204;
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

  Posting_spec_explicit_per_costContext posting_spec_explicit_per_cost() {
    dynamic _localctx = Posting_spec_explicit_per_costContext(context, state);
    enterRule(_localctx, 48, RULE_posting_spec_explicit_per_cost);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 207;
      account();
      state = 208;
      amount();
      state = 209;
      match(TOKEN_T__13);
      state = 210;
      cost();
      state = 212;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_TAG) {
        state = 211;
        tags();
      }

      state = 215;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_T__4) {
        state = 214;
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

  CostContext cost() {
    dynamic _localctx = CostContext(context, state);
    enterRule(_localctx, 50, RULE_cost);
    try {
      enterOuterAlt(_localctx, 1);
      state = 217;
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
    enterRule(_localctx, 52, RULE_date);
    try {
      enterOuterAlt(_localctx, 1);
      state = 219;
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
    enterRule(_localctx, 54, RULE_quoted_string);
    try {
      enterOuterAlt(_localctx, 1);
      state = 221;
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
    enterRule(_localctx, 56, RULE_tags);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 224; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 223;
        match(TOKEN_TAG);
        state = 226; 
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

  static const List<int> _serializedATN = [
      4,1,26,229,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,6,
      2,7,7,7,2,8,7,8,2,9,7,9,2,10,7,10,2,11,7,11,2,12,7,12,2,13,7,13,2,
      14,7,14,2,15,7,15,2,16,7,16,2,17,7,17,2,18,7,18,2,19,7,19,2,20,7,20,
      2,21,7,21,2,22,7,22,2,23,7,23,2,24,7,24,2,25,7,25,2,26,7,26,2,27,7,
      27,2,28,7,28,1,0,1,0,5,0,61,8,0,10,0,12,0,64,9,0,1,0,1,0,1,1,1,1,1,
      1,1,1,3,1,72,8,1,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,3,2,83,8,2,1,
      2,1,2,1,3,1,3,1,3,4,3,90,8,3,11,3,12,3,91,1,4,1,4,1,5,1,5,1,5,1,6,
      1,6,1,6,1,7,1,7,1,7,1,7,1,8,1,8,5,8,108,8,8,10,8,12,8,111,9,8,1,8,
      1,8,1,9,1,9,1,9,1,9,1,9,1,10,1,10,1,10,1,10,1,11,1,11,1,11,1,11,1,
      12,1,12,1,12,1,12,1,13,1,13,1,13,1,13,1,13,1,14,1,14,1,14,1,14,1,14,
      1,15,1,15,1,15,1,15,1,15,1,16,1,16,1,16,1,16,1,16,1,17,1,17,1,18,1,
      18,1,18,1,18,1,18,5,18,159,8,18,10,18,12,18,162,9,18,1,18,1,18,1,18,
      3,18,167,8,18,1,18,1,18,4,18,171,8,18,11,18,12,18,172,1,19,1,19,1,
      19,1,19,3,19,179,8,19,1,19,3,19,182,8,19,1,20,1,20,5,20,186,8,20,10,
      20,12,20,189,9,20,1,21,1,21,1,22,1,22,3,22,195,8,22,1,22,3,22,198,
      8,22,1,23,1,23,1,23,3,23,203,8,23,1,23,3,23,206,8,23,1,24,1,24,1,24,
      1,24,1,24,3,24,213,8,24,1,24,3,24,216,8,24,1,25,1,25,1,26,1,26,1,27,
      1,27,1,28,4,28,225,8,28,11,28,12,28,226,1,28,0,0,29,0,2,4,6,8,10,12,
      14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,
      0,2,1,0,4,5,1,0,24,24,228,0,62,1,0,0,0,2,71,1,0,0,0,4,82,1,0,0,0,6,
      86,1,0,0,0,8,93,1,0,0,0,10,95,1,0,0,0,12,98,1,0,0,0,14,101,1,0,0,0,
      16,105,1,0,0,0,18,114,1,0,0,0,20,119,1,0,0,0,22,123,1,0,0,0,24,127,
      1,0,0,0,26,131,1,0,0,0,28,136,1,0,0,0,30,141,1,0,0,0,32,146,1,0,0,
      0,34,151,1,0,0,0,36,153,1,0,0,0,38,174,1,0,0,0,40,183,1,0,0,0,42,190,
      1,0,0,0,44,192,1,0,0,0,46,199,1,0,0,0,48,207,1,0,0,0,50,217,1,0,0,
      0,52,219,1,0,0,0,54,221,1,0,0,0,56,224,1,0,0,0,58,61,3,2,1,0,59,61,
      3,34,17,0,60,58,1,0,0,0,60,59,1,0,0,0,61,64,1,0,0,0,62,60,1,0,0,0,
      62,63,1,0,0,0,63,65,1,0,0,0,64,62,1,0,0,0,65,66,5,0,0,1,66,1,1,0,0,
      0,67,72,3,4,2,0,68,72,3,12,6,0,69,72,3,14,7,0,70,72,3,16,8,0,71,67,
      1,0,0,0,71,68,1,0,0,0,71,69,1,0,0,0,71,70,1,0,0,0,72,3,1,0,0,0,73,
      83,3,18,9,0,74,83,3,20,10,0,75,83,3,22,11,0,76,83,3,24,12,0,77,83,
      3,26,13,0,78,83,3,28,14,0,79,83,3,30,15,0,80,83,3,32,16,0,81,83,3,
      36,18,0,82,73,1,0,0,0,82,74,1,0,0,0,82,75,1,0,0,0,82,76,1,0,0,0,82,
      77,1,0,0,0,82,78,1,0,0,0,82,79,1,0,0,0,82,80,1,0,0,0,82,81,1,0,0,0,
      83,84,1,0,0,0,84,85,5,24,0,0,85,5,1,0,0,0,86,89,5,22,0,0,87,88,5,1,
      0,0,88,90,5,22,0,0,89,87,1,0,0,0,90,91,1,0,0,0,91,89,1,0,0,0,91,92,
      1,0,0,0,92,7,1,0,0,0,93,94,5,22,0,0,94,9,1,0,0,0,95,96,5,20,0,0,96,
      97,3,8,4,0,97,11,1,0,0,0,98,99,5,2,0,0,99,100,3,54,27,0,100,13,1,0,
      0,0,101,102,5,3,0,0,102,103,3,54,27,0,103,104,3,54,27,0,104,15,1,0,
      0,0,105,109,7,0,0,0,106,108,8,1,0,0,107,106,1,0,0,0,108,111,1,0,0,
      0,109,107,1,0,0,0,109,110,1,0,0,0,110,112,1,0,0,0,111,109,1,0,0,0,
      112,113,5,24,0,0,113,17,1,0,0,0,114,115,3,52,26,0,115,116,5,6,0,0,
      116,117,3,6,3,0,117,118,3,10,5,0,118,19,1,0,0,0,119,120,3,52,26,0,
      120,121,5,7,0,0,121,122,3,6,3,0,122,21,1,0,0,0,123,124,3,52,26,0,124,
      125,5,8,0,0,125,126,3,6,3,0,126,23,1,0,0,0,127,128,3,52,26,0,128,129,
      5,9,0,0,129,130,3,8,4,0,130,25,1,0,0,0,131,132,3,52,26,0,132,133,5,
      10,0,0,133,134,3,8,4,0,134,135,3,10,5,0,135,27,1,0,0,0,136,137,3,52,
      26,0,137,138,5,11,0,0,138,139,3,54,27,0,139,140,3,54,27,0,140,29,1,
      0,0,0,141,142,3,52,26,0,142,143,5,12,0,0,143,144,3,6,3,0,144,145,3,
      54,27,0,145,31,1,0,0,0,146,147,3,52,26,0,147,148,5,13,0,0,148,149,
      3,6,3,0,149,150,3,54,27,0,150,33,1,0,0,0,151,152,5,24,0,0,152,35,1,
      0,0,0,153,154,3,38,19,0,154,160,5,24,0,0,155,156,3,42,21,0,156,157,
      5,24,0,0,157,159,1,0,0,0,158,155,1,0,0,0,159,162,1,0,0,0,160,158,1,
      0,0,0,160,161,1,0,0,0,161,170,1,0,0,0,162,160,1,0,0,0,163,167,3,44,
      22,0,164,167,3,46,23,0,165,167,3,48,24,0,166,163,1,0,0,0,166,164,1,
      0,0,0,166,165,1,0,0,0,167,168,1,0,0,0,168,169,5,24,0,0,169,171,1,0,
      0,0,170,166,1,0,0,0,171,172,1,0,0,0,172,170,1,0,0,0,172,173,1,0,0,
      0,173,37,1,0,0,0,174,175,3,52,26,0,175,176,5,25,0,0,176,178,3,54,27,
      0,177,179,3,54,27,0,178,177,1,0,0,0,178,179,1,0,0,0,179,181,1,0,0,
      0,180,182,3,56,28,0,181,180,1,0,0,0,181,182,1,0,0,0,182,39,1,0,0,0,
      183,187,5,5,0,0,184,186,8,1,0,0,185,184,1,0,0,0,186,189,1,0,0,0,187,
      185,1,0,0,0,187,188,1,0,0,0,188,41,1,0,0,0,189,187,1,0,0,0,190,191,
      3,40,20,0,191,43,1,0,0,0,192,194,3,6,3,0,193,195,3,56,28,0,194,193,
      1,0,0,0,194,195,1,0,0,0,195,197,1,0,0,0,196,198,3,40,20,0,197,196,
      1,0,0,0,197,198,1,0,0,0,198,45,1,0,0,0,199,200,3,6,3,0,200,202,3,10,
      5,0,201,203,3,56,28,0,202,201,1,0,0,0,202,203,1,0,0,0,203,205,1,0,
      0,0,204,206,3,40,20,0,205,204,1,0,0,0,205,206,1,0,0,0,206,47,1,0,0,
      0,207,208,3,6,3,0,208,209,3,10,5,0,209,210,5,14,0,0,210,212,3,50,25,
      0,211,213,3,56,28,0,212,211,1,0,0,0,212,213,1,0,0,0,213,215,1,0,0,
      0,214,216,3,40,20,0,215,214,1,0,0,0,215,216,1,0,0,0,216,49,1,0,0,0,
      217,218,3,10,5,0,218,51,1,0,0,0,219,220,5,19,0,0,220,53,1,0,0,0,221,
      222,5,26,0,0,222,55,1,0,0,0,223,225,5,21,0,0,224,223,1,0,0,0,225,226,
      1,0,0,0,226,224,1,0,0,0,226,227,1,0,0,0,227,57,1,0,0,0,19,60,62,71,
      82,91,109,160,166,172,178,181,187,194,197,202,205,212,215,226
  ];

  static final ATN _ATN =
      ATNDeserializer().deserialize(_serializedATN);
}
class AllContext extends ParserRuleContext {
  TerminalNode? EOF() => getToken(GringottsParser.TOKEN_EOF, 0);
  List<StatementContext> statements() => getRuleContexts<StatementContext>();
  StatementContext? statement(int i) => getRuleContext<StatementContext>(i);
  List<Empty_lineContext> empty_lines() => getRuleContexts<Empty_lineContext>();
  Empty_lineContext? empty_line(int i) => getRuleContext<Empty_lineContext>(i);
  AllContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_all;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterAll(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitAll(this);
  }
}

class StatementContext extends ParserRuleContext {
  DirectiveContext? directive() => getRuleContext<DirectiveContext>(0);
  IncludeStatementContext? includeStatement() => getRuleContext<IncludeStatementContext>(0);
  OptionStatementContext? optionStatement() => getRuleContext<OptionStatementContext>(0);
  CommentStatementContext? commentStatement() => getRuleContext<CommentStatementContext>(0);
  StatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_statement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitStatement(this);
  }
}

class DirectiveContext extends ParserRuleContext {
  TerminalNode? NEWLINE() => getToken(GringottsParser.TOKEN_NEWLINE, 0);
  BalanceStatementContext? balanceStatement() => getRuleContext<BalanceStatementContext>(0);
  CloseStatementContext? closeStatement() => getRuleContext<CloseStatementContext>(0);
  OpenStatementContext? openStatement() => getRuleContext<OpenStatementContext>(0);
  CommodityStatementContext? commodityStatement() => getRuleContext<CommodityStatementContext>(0);
  PriceStatementContext? priceStatement() => getRuleContext<PriceStatementContext>(0);
  EventStatementContext? eventStatement() => getRuleContext<EventStatementContext>(0);
  DocumentStatementContext? documentStatement() => getRuleContext<DocumentStatementContext>(0);
  NoteStatementContext? noteStatement() => getRuleContext<NoteStatementContext>(0);
  TrStatementContext? trStatement() => getRuleContext<TrStatementContext>(0);
  DirectiveContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_directive;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterDirective(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitDirective(this);
  }
}

class AccountContext extends ParserRuleContext {
  List<TerminalNode> WORDs() => getTokens(GringottsParser.TOKEN_WORD);
  TerminalNode? WORD(int i) => getToken(GringottsParser.TOKEN_WORD, i);
  AccountContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_account;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterAccount(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitAccount(this);
  }
}

class CurrencyContext extends ParserRuleContext {
  TerminalNode? WORD() => getToken(GringottsParser.TOKEN_WORD, 0);
  CurrencyContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_currency;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterCurrency(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitCurrency(this);
  }
}

class AmountContext extends ParserRuleContext {
  TerminalNode? NUMBER() => getToken(GringottsParser.TOKEN_NUMBER, 0);
  CurrencyContext? currency() => getRuleContext<CurrencyContext>(0);
  AmountContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_amount;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterAmount(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitAmount(this);
  }
}

class IncludeStatementContext extends ParserRuleContext {
  Quoted_stringContext? quoted_string() => getRuleContext<Quoted_stringContext>(0);
  IncludeStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_includeStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterIncludeStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitIncludeStatement(this);
  }
}

class OptionStatementContext extends ParserRuleContext {
  Quoted_stringContext? key;
  Quoted_stringContext? value;
  List<Quoted_stringContext> quoted_strings() => getRuleContexts<Quoted_stringContext>();
  Quoted_stringContext? quoted_string(int i) => getRuleContext<Quoted_stringContext>(i);
  OptionStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_optionStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterOptionStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitOptionStatement(this);
  }
}

class CommentStatementContext extends ParserRuleContext {
  List<TerminalNode> NEWLINEs() => getTokens(GringottsParser.TOKEN_NEWLINE);
  TerminalNode? NEWLINE(int i) => getToken(GringottsParser.TOKEN_NEWLINE, i);
  CommentStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_commentStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterCommentStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitCommentStatement(this);
  }
}

class BalanceStatementContext extends ParserRuleContext {
  DateContext? date() => getRuleContext<DateContext>(0);
  AccountContext? account() => getRuleContext<AccountContext>(0);
  AmountContext? amount() => getRuleContext<AmountContext>(0);
  BalanceStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_balanceStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterBalanceStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitBalanceStatement(this);
  }
}

class CloseStatementContext extends ParserRuleContext {
  DateContext? date() => getRuleContext<DateContext>(0);
  AccountContext? account() => getRuleContext<AccountContext>(0);
  CloseStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_closeStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterCloseStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitCloseStatement(this);
  }
}

class OpenStatementContext extends ParserRuleContext {
  DateContext? date() => getRuleContext<DateContext>(0);
  AccountContext? account() => getRuleContext<AccountContext>(0);
  OpenStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_openStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterOpenStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitOpenStatement(this);
  }
}

class CommodityStatementContext extends ParserRuleContext {
  DateContext? date() => getRuleContext<DateContext>(0);
  CurrencyContext? currency() => getRuleContext<CurrencyContext>(0);
  CommodityStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_commodityStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterCommodityStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitCommodityStatement(this);
  }
}

class PriceStatementContext extends ParserRuleContext {
  DateContext? date() => getRuleContext<DateContext>(0);
  CurrencyContext? currency() => getRuleContext<CurrencyContext>(0);
  AmountContext? amount() => getRuleContext<AmountContext>(0);
  PriceStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_priceStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterPriceStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitPriceStatement(this);
  }
}

class EventStatementContext extends ParserRuleContext {
  Quoted_stringContext? name;
  Quoted_stringContext? value;
  DateContext? date() => getRuleContext<DateContext>(0);
  List<Quoted_stringContext> quoted_strings() => getRuleContexts<Quoted_stringContext>();
  Quoted_stringContext? quoted_string(int i) => getRuleContext<Quoted_stringContext>(i);
  EventStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_eventStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterEventStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitEventStatement(this);
  }
}

class DocumentStatementContext extends ParserRuleContext {
  DateContext? date() => getRuleContext<DateContext>(0);
  AccountContext? account() => getRuleContext<AccountContext>(0);
  Quoted_stringContext? quoted_string() => getRuleContext<Quoted_stringContext>(0);
  DocumentStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_documentStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterDocumentStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitDocumentStatement(this);
  }
}

class NoteStatementContext extends ParserRuleContext {
  DateContext? date() => getRuleContext<DateContext>(0);
  AccountContext? account() => getRuleContext<AccountContext>(0);
  Quoted_stringContext? quoted_string() => getRuleContext<Quoted_stringContext>(0);
  NoteStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_noteStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterNoteStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitNoteStatement(this);
  }
}

class Empty_lineContext extends ParserRuleContext {
  TerminalNode? NEWLINE() => getToken(GringottsParser.TOKEN_NEWLINE, 0);
  Empty_lineContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_empty_line;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterEmpty_line(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitEmpty_line(this);
  }
}

class TrStatementContext extends ParserRuleContext {
  Tr_headerContext? tr_header() => getRuleContext<Tr_headerContext>(0);
  List<TerminalNode> NEWLINEs() => getTokens(GringottsParser.TOKEN_NEWLINE);
  TerminalNode? NEWLINE(int i) => getToken(GringottsParser.TOKEN_NEWLINE, i);
  List<Tr_commentContext> tr_comments() => getRuleContexts<Tr_commentContext>();
  Tr_commentContext? tr_comment(int i) => getRuleContext<Tr_commentContext>(i);
  List<Posting_spec_account_onlyContext> posting_spec_account_onlys() => getRuleContexts<Posting_spec_account_onlyContext>();
  Posting_spec_account_onlyContext? posting_spec_account_only(int i) => getRuleContext<Posting_spec_account_onlyContext>(i);
  List<Posting_spec_account_amountContext> posting_spec_account_amounts() => getRuleContexts<Posting_spec_account_amountContext>();
  Posting_spec_account_amountContext? posting_spec_account_amount(int i) => getRuleContext<Posting_spec_account_amountContext>(i);
  List<Posting_spec_explicit_per_costContext> posting_spec_explicit_per_costs() => getRuleContexts<Posting_spec_explicit_per_costContext>();
  Posting_spec_explicit_per_costContext? posting_spec_explicit_per_cost(int i) => getRuleContext<Posting_spec_explicit_per_costContext>(i);
  TrStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_trStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterTrStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitTrStatement(this);
  }
}

class Tr_headerContext extends ParserRuleContext {
  Quoted_stringContext? narration;
  Quoted_stringContext? payee;
  DateContext? date() => getRuleContext<DateContext>(0);
  TerminalNode? TR_FLAG() => getToken(GringottsParser.TOKEN_TR_FLAG, 0);
  List<Quoted_stringContext> quoted_strings() => getRuleContexts<Quoted_stringContext>();
  Quoted_stringContext? quoted_string(int i) => getRuleContext<Quoted_stringContext>(i);
  TagsContext? tags() => getRuleContext<TagsContext>(0);
  Tr_headerContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_tr_header;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterTr_header(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitTr_header(this);
  }
}

class Inline_commentContext extends ParserRuleContext {
  List<TerminalNode> NEWLINEs() => getTokens(GringottsParser.TOKEN_NEWLINE);
  TerminalNode? NEWLINE(int i) => getToken(GringottsParser.TOKEN_NEWLINE, i);
  Inline_commentContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_inline_comment;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterInline_comment(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitInline_comment(this);
  }
}

class Tr_commentContext extends ParserRuleContext {
  Inline_commentContext? inline_comment() => getRuleContext<Inline_commentContext>(0);
  Tr_commentContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_tr_comment;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterTr_comment(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitTr_comment(this);
  }
}

class Posting_spec_account_onlyContext extends ParserRuleContext {
  AccountContext? account() => getRuleContext<AccountContext>(0);
  TagsContext? tags() => getRuleContext<TagsContext>(0);
  Inline_commentContext? inline_comment() => getRuleContext<Inline_commentContext>(0);
  Posting_spec_account_onlyContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_posting_spec_account_only;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterPosting_spec_account_only(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitPosting_spec_account_only(this);
  }
}

class Posting_spec_account_amountContext extends ParserRuleContext {
  AccountContext? account() => getRuleContext<AccountContext>(0);
  AmountContext? amount() => getRuleContext<AmountContext>(0);
  TagsContext? tags() => getRuleContext<TagsContext>(0);
  Inline_commentContext? inline_comment() => getRuleContext<Inline_commentContext>(0);
  Posting_spec_account_amountContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_posting_spec_account_amount;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterPosting_spec_account_amount(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitPosting_spec_account_amount(this);
  }
}

class Posting_spec_explicit_per_costContext extends ParserRuleContext {
  AccountContext? account() => getRuleContext<AccountContext>(0);
  AmountContext? amount() => getRuleContext<AmountContext>(0);
  CostContext? cost() => getRuleContext<CostContext>(0);
  TagsContext? tags() => getRuleContext<TagsContext>(0);
  Inline_commentContext? inline_comment() => getRuleContext<Inline_commentContext>(0);
  Posting_spec_explicit_per_costContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_posting_spec_explicit_per_cost;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterPosting_spec_explicit_per_cost(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitPosting_spec_explicit_per_cost(this);
  }
}

class CostContext extends ParserRuleContext {
  AmountContext? amount() => getRuleContext<AmountContext>(0);
  CostContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_cost;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterCost(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitCost(this);
  }
}

class DateContext extends ParserRuleContext {
  TerminalNode? DATE() => getToken(GringottsParser.TOKEN_DATE, 0);
  DateContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_date;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterDate(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitDate(this);
  }
}

class Quoted_stringContext extends ParserRuleContext {
  TerminalNode? STR() => getToken(GringottsParser.TOKEN_STR, 0);
  Quoted_stringContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_quoted_string;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterQuoted_string(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitQuoted_string(this);
  }
}

class TagsContext extends ParserRuleContext {
  List<TerminalNode> TAGs() => getTokens(GringottsParser.TOKEN_TAG);
  TerminalNode? TAG(int i) => getToken(GringottsParser.TOKEN_TAG, i);
  TagsContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_tags;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterTags(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitTags(this);
  }
}

