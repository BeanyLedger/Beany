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
          RULE_date = 24, RULE_quoted_string = 25, RULE_tags = 26;
class GringottsParser extends Parser {
  static final checkVersion = () => RuntimeMetaData.checkVersion('4.10.1', RuntimeMetaData.VERSION);
  static const int TOKEN_EOF = IntStream.EOF;

  static final List<DFA> _decisionToDFA = List.generate(
      _ATN.numberOfDecisions, (i) => DFA(_ATN.getDecisionState(i), i));
  static final PredictionContextCache _sharedContextCache = PredictionContextCache();
  static const int TOKEN_T__0 = 1, TOKEN_T__1 = 2, TOKEN_T__2 = 3, TOKEN_T__3 = 4, 
                   TOKEN_T__4 = 5, TOKEN_T__5 = 6, TOKEN_T__6 = 7, TOKEN_T__7 = 8, 
                   TOKEN_T__8 = 9, TOKEN_T__9 = 10, TOKEN_T__10 = 11, TOKEN_T__11 = 12, 
                   TOKEN_T__12 = 13, TOKEN_DIGIT = 14, TOKEN_YEAR = 15, 
                   TOKEN_MONTH = 16, TOKEN_DAY = 17, TOKEN_DATE = 18, TOKEN_NUMBER = 19, 
                   TOKEN_TAG = 20, TOKEN_WORD = 21, TOKEN_WHITESPACE = 22, 
                   TOKEN_NEWLINE = 23, TOKEN_TR_FLAG = 24, TOKEN_STR = 25;

  @override
  final List<String> ruleNames = [
    'all', 'statement', 'directive', 'account', 'currency', 'amount', 'includeStatement', 
    'optionStatement', 'commentStatement', 'balanceStatement', 'closeStatement', 
    'openStatement', 'commodityStatement', 'priceStatement', 'eventStatement', 
    'documentStatement', 'noteStatement', 'empty_line', 'trStatement', 'tr_header', 
    'inline_comment', 'tr_comment', 'posting_spec_account_only', 'posting_spec_account_amount', 
    'date', 'quoted_string', 'tags'
  ];

  static final List<String?> _LITERAL_NAMES = [
      null, "':'", "'include'", "'option'", "'#'", "';'", "'balance'", "'close'", 
      "'open'", "'commodity'", "'price'", "'event'", "'document'", "'note'"
  ];
  static final List<String?> _SYMBOLIC_NAMES = [
      null, null, null, null, null, null, null, null, null, null, null, 
      null, null, null, "DIGIT", "YEAR", "MONTH", "DAY", "DATE", "NUMBER", 
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
      state = 58;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while ((((_la) & ~0x3f) == 0 && ((BigInt.one << _la) & ((BigInt.one << TOKEN_T__1) | (BigInt.one << TOKEN_T__2) | (BigInt.one << TOKEN_T__3) | (BigInt.one << TOKEN_T__4) | (BigInt.one << TOKEN_DATE) | (BigInt.one << TOKEN_NEWLINE))) != BigInt.zero)) {
        state = 56;
        errorHandler.sync(this);
        switch (tokenStream.LA(1)!) {
        case TOKEN_T__1:
        case TOKEN_T__2:
        case TOKEN_T__3:
        case TOKEN_T__4:
        case TOKEN_DATE:
          state = 54;
          statement();
          break;
        case TOKEN_NEWLINE:
          state = 55;
          empty_line();
          break;
        default:
          throw NoViableAltException(this);
        }
        state = 60;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 61;
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
      state = 67;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_DATE:
        enterOuterAlt(_localctx, 1);
        state = 63;
        directive();
        break;
      case TOKEN_T__1:
        enterOuterAlt(_localctx, 2);
        state = 64;
        includeStatement();
        break;
      case TOKEN_T__2:
        enterOuterAlt(_localctx, 3);
        state = 65;
        optionStatement();
        break;
      case TOKEN_T__3:
      case TOKEN_T__4:
        enterOuterAlt(_localctx, 4);
        state = 66;
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
      state = 78;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 3, context)) {
      case 1:
        state = 69;
        balanceStatement();
        break;
      case 2:
        state = 70;
        closeStatement();
        break;
      case 3:
        state = 71;
        openStatement();
        break;
      case 4:
        state = 72;
        commodityStatement();
        break;
      case 5:
        state = 73;
        priceStatement();
        break;
      case 6:
        state = 74;
        eventStatement();
        break;
      case 7:
        state = 75;
        documentStatement();
        break;
      case 8:
        state = 76;
        noteStatement();
        break;
      case 9:
        state = 77;
        trStatement();
        break;
      }
      state = 80;
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
      state = 82;
      match(TOKEN_WORD);
      state = 85; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 83;
        match(TOKEN_T__0);
        state = 84;
        match(TOKEN_WORD);
        state = 87; 
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
      state = 89;
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
      state = 91;
      match(TOKEN_NUMBER);
      state = 92;
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
      state = 94;
      match(TOKEN_T__1);
      state = 95;
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
      state = 97;
      match(TOKEN_T__2);
      state = 98;
      _localctx.key = quoted_string();
      state = 99;
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
      state = 101;
      _la = tokenStream.LA(1)!;
      if (!(_la == TOKEN_T__3 || _la == TOKEN_T__4)) {
      errorHandler.recoverInline(this);
      } else {
        if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
      state = 105;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while ((((_la) & ~0x3f) == 0 && ((BigInt.one << _la) & ((BigInt.one << TOKEN_T__0) | (BigInt.one << TOKEN_T__1) | (BigInt.one << TOKEN_T__2) | (BigInt.one << TOKEN_T__3) | (BigInt.one << TOKEN_T__4) | (BigInt.one << TOKEN_T__5) | (BigInt.one << TOKEN_T__6) | (BigInt.one << TOKEN_T__7) | (BigInt.one << TOKEN_T__8) | (BigInt.one << TOKEN_T__9) | (BigInt.one << TOKEN_T__10) | (BigInt.one << TOKEN_T__11) | (BigInt.one << TOKEN_T__12) | (BigInt.one << TOKEN_DIGIT) | (BigInt.one << TOKEN_YEAR) | (BigInt.one << TOKEN_MONTH) | (BigInt.one << TOKEN_DAY) | (BigInt.one << TOKEN_DATE) | (BigInt.one << TOKEN_NUMBER) | (BigInt.one << TOKEN_TAG) | (BigInt.one << TOKEN_WORD) | (BigInt.one << TOKEN_WHITESPACE) | (BigInt.one << TOKEN_TR_FLAG) | (BigInt.one << TOKEN_STR))) != BigInt.zero)) {
        state = 102;
        _la = tokenStream.LA(1)!;
        if (_la <= 0 || (_la == TOKEN_NEWLINE)) {
        errorHandler.recoverInline(this);
        } else {
          if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
          errorHandler.reportMatch(this);
          consume();
        }
        state = 107;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 108;
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
      state = 110;
      date();
      state = 111;
      match(TOKEN_T__5);
      state = 112;
      account();
      state = 113;
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
      state = 115;
      date();
      state = 116;
      match(TOKEN_T__6);
      state = 117;
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
      state = 119;
      date();
      state = 120;
      match(TOKEN_T__7);
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

  CommodityStatementContext commodityStatement() {
    dynamic _localctx = CommodityStatementContext(context, state);
    enterRule(_localctx, 24, RULE_commodityStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 123;
      date();
      state = 124;
      match(TOKEN_T__8);
      state = 125;
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
      state = 127;
      date();
      state = 128;
      match(TOKEN_T__9);
      state = 129;
      currency();
      state = 130;
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
      state = 132;
      date();
      state = 133;
      match(TOKEN_T__10);
      state = 134;
      _localctx.name = quoted_string();
      state = 135;
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
      state = 137;
      date();
      state = 138;
      match(TOKEN_T__11);
      state = 139;
      account();
      state = 140;
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
      state = 142;
      date();
      state = 143;
      match(TOKEN_T__12);
      state = 144;
      account();
      state = 145;
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
      state = 147;
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
      state = 149;
      tr_header();
      state = 150;
      match(TOKEN_NEWLINE);
      state = 158; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 154;
        errorHandler.sync(this);
        switch (interpreter!.adaptivePredict(tokenStream, 6, context)) {
        case 1:
          state = 151;
          posting_spec_account_only();
          break;
        case 2:
          state = 152;
          posting_spec_account_amount();
          break;
        case 3:
          state = 153;
          tr_comment();
          break;
        }
        state = 156;
        match(TOKEN_NEWLINE);
        state = 160; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while (_la == TOKEN_T__4 || _la == TOKEN_WORD);
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
      state = 162;
      date();
      state = 163;
      match(TOKEN_TR_FLAG);
      state = 164;
      _localctx.narration = quoted_string();
      state = 166;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_STR) {
        state = 165;
        _localctx.payee = quoted_string();
      }

      state = 169;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_TAG) {
        state = 168;
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
      state = 171;
      match(TOKEN_T__4);
      state = 175;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while ((((_la) & ~0x3f) == 0 && ((BigInt.one << _la) & ((BigInt.one << TOKEN_T__0) | (BigInt.one << TOKEN_T__1) | (BigInt.one << TOKEN_T__2) | (BigInt.one << TOKEN_T__3) | (BigInt.one << TOKEN_T__4) | (BigInt.one << TOKEN_T__5) | (BigInt.one << TOKEN_T__6) | (BigInt.one << TOKEN_T__7) | (BigInt.one << TOKEN_T__8) | (BigInt.one << TOKEN_T__9) | (BigInt.one << TOKEN_T__10) | (BigInt.one << TOKEN_T__11) | (BigInt.one << TOKEN_T__12) | (BigInt.one << TOKEN_DIGIT) | (BigInt.one << TOKEN_YEAR) | (BigInt.one << TOKEN_MONTH) | (BigInt.one << TOKEN_DAY) | (BigInt.one << TOKEN_DATE) | (BigInt.one << TOKEN_NUMBER) | (BigInt.one << TOKEN_TAG) | (BigInt.one << TOKEN_WORD) | (BigInt.one << TOKEN_WHITESPACE) | (BigInt.one << TOKEN_TR_FLAG) | (BigInt.one << TOKEN_STR))) != BigInt.zero)) {
        state = 172;
        _la = tokenStream.LA(1)!;
        if (_la <= 0 || (_la == TOKEN_NEWLINE)) {
        errorHandler.recoverInline(this);
        } else {
          if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
          errorHandler.reportMatch(this);
          consume();
        }
        state = 177;
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
      state = 178;
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
      state = 180;
      account();
      state = 182;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_TAG) {
        state = 181;
        tags();
      }

      state = 185;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_T__4) {
        state = 184;
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
      state = 187;
      account();
      state = 188;
      amount();
      state = 190;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_TAG) {
        state = 189;
        tags();
      }

      state = 193;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_T__4) {
        state = 192;
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

  DateContext date() {
    dynamic _localctx = DateContext(context, state);
    enterRule(_localctx, 48, RULE_date);
    try {
      enterOuterAlt(_localctx, 1);
      state = 195;
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
    enterRule(_localctx, 50, RULE_quoted_string);
    try {
      enterOuterAlt(_localctx, 1);
      state = 197;
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
    enterRule(_localctx, 52, RULE_tags);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 200; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 199;
        match(TOKEN_TAG);
        state = 202; 
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
      4,1,25,205,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,6,
      2,7,7,7,2,8,7,8,2,9,7,9,2,10,7,10,2,11,7,11,2,12,7,12,2,13,7,13,2,
      14,7,14,2,15,7,15,2,16,7,16,2,17,7,17,2,18,7,18,2,19,7,19,2,20,7,20,
      2,21,7,21,2,22,7,22,2,23,7,23,2,24,7,24,2,25,7,25,2,26,7,26,1,0,1,
      0,5,0,57,8,0,10,0,12,0,60,9,0,1,0,1,0,1,1,1,1,1,1,1,1,3,1,68,8,1,1,
      2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,3,2,79,8,2,1,2,1,2,1,3,1,3,1,3,4,
      3,86,8,3,11,3,12,3,87,1,4,1,4,1,5,1,5,1,5,1,6,1,6,1,6,1,7,1,7,1,7,
      1,7,1,8,1,8,5,8,104,8,8,10,8,12,8,107,9,8,1,8,1,8,1,9,1,9,1,9,1,9,
      1,9,1,10,1,10,1,10,1,10,1,11,1,11,1,11,1,11,1,12,1,12,1,12,1,12,1,
      13,1,13,1,13,1,13,1,13,1,14,1,14,1,14,1,14,1,14,1,15,1,15,1,15,1,15,
      1,15,1,16,1,16,1,16,1,16,1,16,1,17,1,17,1,18,1,18,1,18,1,18,1,18,3,
      18,155,8,18,1,18,1,18,4,18,159,8,18,11,18,12,18,160,1,19,1,19,1,19,
      1,19,3,19,167,8,19,1,19,3,19,170,8,19,1,20,1,20,5,20,174,8,20,10,20,
      12,20,177,9,20,1,21,1,21,1,22,1,22,3,22,183,8,22,1,22,3,22,186,8,22,
      1,23,1,23,1,23,3,23,191,8,23,1,23,3,23,194,8,23,1,24,1,24,1,25,1,25,
      1,26,4,26,201,8,26,11,26,12,26,202,1,26,0,0,27,0,2,4,6,8,10,12,14,
      16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,0,2,1,0,4,
      5,1,0,23,23,203,0,58,1,0,0,0,2,67,1,0,0,0,4,78,1,0,0,0,6,82,1,0,0,
      0,8,89,1,0,0,0,10,91,1,0,0,0,12,94,1,0,0,0,14,97,1,0,0,0,16,101,1,
      0,0,0,18,110,1,0,0,0,20,115,1,0,0,0,22,119,1,0,0,0,24,123,1,0,0,0,
      26,127,1,0,0,0,28,132,1,0,0,0,30,137,1,0,0,0,32,142,1,0,0,0,34,147,
      1,0,0,0,36,149,1,0,0,0,38,162,1,0,0,0,40,171,1,0,0,0,42,178,1,0,0,
      0,44,180,1,0,0,0,46,187,1,0,0,0,48,195,1,0,0,0,50,197,1,0,0,0,52,200,
      1,0,0,0,54,57,3,2,1,0,55,57,3,34,17,0,56,54,1,0,0,0,56,55,1,0,0,0,
      57,60,1,0,0,0,58,56,1,0,0,0,58,59,1,0,0,0,59,61,1,0,0,0,60,58,1,0,
      0,0,61,62,5,0,0,1,62,1,1,0,0,0,63,68,3,4,2,0,64,68,3,12,6,0,65,68,
      3,14,7,0,66,68,3,16,8,0,67,63,1,0,0,0,67,64,1,0,0,0,67,65,1,0,0,0,
      67,66,1,0,0,0,68,3,1,0,0,0,69,79,3,18,9,0,70,79,3,20,10,0,71,79,3,
      22,11,0,72,79,3,24,12,0,73,79,3,26,13,0,74,79,3,28,14,0,75,79,3,30,
      15,0,76,79,3,32,16,0,77,79,3,36,18,0,78,69,1,0,0,0,78,70,1,0,0,0,78,
      71,1,0,0,0,78,72,1,0,0,0,78,73,1,0,0,0,78,74,1,0,0,0,78,75,1,0,0,0,
      78,76,1,0,0,0,78,77,1,0,0,0,79,80,1,0,0,0,80,81,5,23,0,0,81,5,1,0,
      0,0,82,85,5,21,0,0,83,84,5,1,0,0,84,86,5,21,0,0,85,83,1,0,0,0,86,87,
      1,0,0,0,87,85,1,0,0,0,87,88,1,0,0,0,88,7,1,0,0,0,89,90,5,21,0,0,90,
      9,1,0,0,0,91,92,5,19,0,0,92,93,3,8,4,0,93,11,1,0,0,0,94,95,5,2,0,0,
      95,96,3,50,25,0,96,13,1,0,0,0,97,98,5,3,0,0,98,99,3,50,25,0,99,100,
      3,50,25,0,100,15,1,0,0,0,101,105,7,0,0,0,102,104,8,1,0,0,103,102,1,
      0,0,0,104,107,1,0,0,0,105,103,1,0,0,0,105,106,1,0,0,0,106,108,1,0,
      0,0,107,105,1,0,0,0,108,109,5,23,0,0,109,17,1,0,0,0,110,111,3,48,24,
      0,111,112,5,6,0,0,112,113,3,6,3,0,113,114,3,10,5,0,114,19,1,0,0,0,
      115,116,3,48,24,0,116,117,5,7,0,0,117,118,3,6,3,0,118,21,1,0,0,0,119,
      120,3,48,24,0,120,121,5,8,0,0,121,122,3,6,3,0,122,23,1,0,0,0,123,124,
      3,48,24,0,124,125,5,9,0,0,125,126,3,8,4,0,126,25,1,0,0,0,127,128,3,
      48,24,0,128,129,5,10,0,0,129,130,3,8,4,0,130,131,3,10,5,0,131,27,1,
      0,0,0,132,133,3,48,24,0,133,134,5,11,0,0,134,135,3,50,25,0,135,136,
      3,50,25,0,136,29,1,0,0,0,137,138,3,48,24,0,138,139,5,12,0,0,139,140,
      3,6,3,0,140,141,3,50,25,0,141,31,1,0,0,0,142,143,3,48,24,0,143,144,
      5,13,0,0,144,145,3,6,3,0,145,146,3,50,25,0,146,33,1,0,0,0,147,148,
      5,23,0,0,148,35,1,0,0,0,149,150,3,38,19,0,150,158,5,23,0,0,151,155,
      3,44,22,0,152,155,3,46,23,0,153,155,3,42,21,0,154,151,1,0,0,0,154,
      152,1,0,0,0,154,153,1,0,0,0,155,156,1,0,0,0,156,157,5,23,0,0,157,159,
      1,0,0,0,158,154,1,0,0,0,159,160,1,0,0,0,160,158,1,0,0,0,160,161,1,
      0,0,0,161,37,1,0,0,0,162,163,3,48,24,0,163,164,5,24,0,0,164,166,3,
      50,25,0,165,167,3,50,25,0,166,165,1,0,0,0,166,167,1,0,0,0,167,169,
      1,0,0,0,168,170,3,52,26,0,169,168,1,0,0,0,169,170,1,0,0,0,170,39,1,
      0,0,0,171,175,5,5,0,0,172,174,8,1,0,0,173,172,1,0,0,0,174,177,1,0,
      0,0,175,173,1,0,0,0,175,176,1,0,0,0,176,41,1,0,0,0,177,175,1,0,0,0,
      178,179,3,40,20,0,179,43,1,0,0,0,180,182,3,6,3,0,181,183,3,52,26,0,
      182,181,1,0,0,0,182,183,1,0,0,0,183,185,1,0,0,0,184,186,3,40,20,0,
      185,184,1,0,0,0,185,186,1,0,0,0,186,45,1,0,0,0,187,188,3,6,3,0,188,
      190,3,10,5,0,189,191,3,52,26,0,190,189,1,0,0,0,190,191,1,0,0,0,191,
      193,1,0,0,0,192,194,3,40,20,0,193,192,1,0,0,0,193,194,1,0,0,0,194,
      47,1,0,0,0,195,196,5,18,0,0,196,49,1,0,0,0,197,198,5,25,0,0,198,51,
      1,0,0,0,199,201,5,20,0,0,200,199,1,0,0,0,201,202,1,0,0,0,202,200,1,
      0,0,0,202,203,1,0,0,0,203,53,1,0,0,0,16,56,58,67,78,87,105,154,160,
      166,169,175,182,185,190,193,202
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
  List<Posting_spec_account_onlyContext> posting_spec_account_onlys() => getRuleContexts<Posting_spec_account_onlyContext>();
  Posting_spec_account_onlyContext? posting_spec_account_only(int i) => getRuleContext<Posting_spec_account_onlyContext>(i);
  List<Posting_spec_account_amountContext> posting_spec_account_amounts() => getRuleContexts<Posting_spec_account_amountContext>();
  Posting_spec_account_amountContext? posting_spec_account_amount(int i) => getRuleContext<Posting_spec_account_amountContext>(i);
  List<Tr_commentContext> tr_comments() => getRuleContexts<Tr_commentContext>();
  Tr_commentContext? tr_comment(int i) => getRuleContext<Tr_commentContext>(i);
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

