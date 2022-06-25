// Generated from Gringotts.g4 by ANTLR 4.10.1
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes
import 'package:antlr4/antlr4.dart';

import 'GringottsListener.dart';
import 'GringottsBaseListener.dart';
const int RULE_all = 0, RULE_comment = 1, RULE_statement = 2, RULE_account = 3, 
          RULE_currency = 4, RULE_amount = 5, RULE_balanceStatement = 6, 
          RULE_closeStatement = 7, RULE_openStatement = 8, RULE_commodityStatement = 9, 
          RULE_priceStatement = 10, RULE_eventStatement = 11, RULE_documentStatement = 12, 
          RULE_noteStatement = 13, RULE_empty_line = 14, RULE_trStatement = 15, 
          RULE_tr_header = 16, RULE_tr_comment = 17, RULE_inline_comment = 18, 
          RULE_posting_spec_account_only = 19, RULE_posting_spec_account_amount = 20, 
          RULE_date = 21, RULE_quoted_string = 22;
class GringottsParser extends Parser {
  static final checkVersion = () => RuntimeMetaData.checkVersion('4.10.1', RuntimeMetaData.VERSION);
  static const int TOKEN_EOF = IntStream.EOF;

  static final List<DFA> _decisionToDFA = List.generate(
      _ATN.numberOfDecisions, (i) => DFA(_ATN.getDecisionState(i), i));
  static final PredictionContextCache _sharedContextCache = PredictionContextCache();
  static const int TOKEN_T__0 = 1, TOKEN_T__1 = 2, TOKEN_T__2 = 3, TOKEN_T__3 = 4, 
                   TOKEN_T__4 = 5, TOKEN_T__5 = 6, TOKEN_T__6 = 7, TOKEN_T__7 = 8, 
                   TOKEN_T__8 = 9, TOKEN_T__9 = 10, TOKEN_T__10 = 11, TOKEN_DIGIT = 12, 
                   TOKEN_YEAR = 13, TOKEN_MONTH = 14, TOKEN_DAY = 15, TOKEN_DATE = 16, 
                   TOKEN_NUMBER = 17, TOKEN_TAG = 18, TOKEN_WORD = 19, TOKEN_WHITESPACE = 20, 
                   TOKEN_NEWLINE = 21, TOKEN_TR_FLAG = 22, TOKEN_INDENT = 23, 
                   TOKEN_STR = 24;

  @override
  final List<String> ruleNames = [
    'all', 'comment', 'statement', 'account', 'currency', 'amount', 'balanceStatement', 
    'closeStatement', 'openStatement', 'commodityStatement', 'priceStatement', 
    'eventStatement', 'documentStatement', 'noteStatement', 'empty_line', 
    'trStatement', 'tr_header', 'tr_comment', 'inline_comment', 'posting_spec_account_only', 
    'posting_spec_account_amount', 'date', 'quoted_string'
  ];

  static final List<String?> _LITERAL_NAMES = [
      null, "'#'", "';'", "':'", "'balance'", "'close'", "'open'", "'commodity'", 
      "'price'", "'event'", "'document'", "'note'"
  ];
  static final List<String?> _SYMBOLIC_NAMES = [
      null, null, null, null, null, null, null, null, null, null, null, 
      null, "DIGIT", "YEAR", "MONTH", "DAY", "DATE", "NUMBER", "TAG", "WORD", 
      "WHITESPACE", "NEWLINE", "TR_FLAG", "INDENT", "STR"
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
      state = 51;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while ((((_la) & ~0x3f) == 0 && ((BigInt.one << _la) & ((BigInt.one << TOKEN_T__0) | (BigInt.one << TOKEN_T__1) | (BigInt.one << TOKEN_DATE) | (BigInt.one << TOKEN_NEWLINE))) != BigInt.zero)) {
        state = 49;
        errorHandler.sync(this);
        switch (tokenStream.LA(1)!) {
        case TOKEN_DATE:
          state = 46;
          statement();
          break;
        case TOKEN_T__0:
        case TOKEN_T__1:
          state = 47;
          comment();
          break;
        case TOKEN_NEWLINE:
          state = 48;
          empty_line();
          break;
        default:
          throw NoViableAltException(this);
        }
        state = 53;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 54;
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

  CommentContext comment() {
    dynamic _localctx = CommentContext(context, state);
    enterRule(_localctx, 2, RULE_comment);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 56;
      _la = tokenStream.LA(1)!;
      if (!(_la == TOKEN_T__0 || _la == TOKEN_T__1)) {
      errorHandler.recoverInline(this);
      } else {
        if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
      state = 57;
      _la = tokenStream.LA(1)!;
      if (_la <= 0 || (_la == TOKEN_NEWLINE)) {
      errorHandler.recoverInline(this);
      } else {
        if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
      state = 58;
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

  StatementContext statement() {
    dynamic _localctx = StatementContext(context, state);
    enterRule(_localctx, 4, RULE_statement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 69;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 2, context)) {
      case 1:
        state = 60;
        balanceStatement();
        break;
      case 2:
        state = 61;
        closeStatement();
        break;
      case 3:
        state = 62;
        openStatement();
        break;
      case 4:
        state = 63;
        commodityStatement();
        break;
      case 5:
        state = 64;
        priceStatement();
        break;
      case 6:
        state = 65;
        eventStatement();
        break;
      case 7:
        state = 66;
        documentStatement();
        break;
      case 8:
        state = 67;
        noteStatement();
        break;
      case 9:
        state = 68;
        trStatement();
        break;
      }
      state = 71;
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
      state = 73;
      match(TOKEN_WORD);
      state = 76; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 74;
        match(TOKEN_T__2);
        state = 75;
        match(TOKEN_WORD);
        state = 78; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while (_la == TOKEN_T__2);
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
      state = 80;
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
      state = 82;
      match(TOKEN_NUMBER);
      state = 83;
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

  BalanceStatementContext balanceStatement() {
    dynamic _localctx = BalanceStatementContext(context, state);
    enterRule(_localctx, 12, RULE_balanceStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 85;
      date();
      state = 86;
      match(TOKEN_T__3);
      state = 87;
      account();
      state = 88;
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
    enterRule(_localctx, 14, RULE_closeStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 90;
      date();
      state = 91;
      match(TOKEN_T__4);
      state = 92;
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
    enterRule(_localctx, 16, RULE_openStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 94;
      date();
      state = 95;
      match(TOKEN_T__5);
      state = 96;
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
    enterRule(_localctx, 18, RULE_commodityStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 98;
      date();
      state = 99;
      match(TOKEN_T__6);
      state = 100;
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
    enterRule(_localctx, 20, RULE_priceStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 102;
      date();
      state = 103;
      match(TOKEN_T__7);
      state = 104;
      currency();
      state = 105;
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
    enterRule(_localctx, 22, RULE_eventStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 107;
      date();
      state = 108;
      match(TOKEN_T__8);
      state = 109;
      _localctx.name = quoted_string();
      state = 110;
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
    enterRule(_localctx, 24, RULE_documentStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 112;
      date();
      state = 113;
      match(TOKEN_T__9);
      state = 114;
      account();
      state = 115;
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
    enterRule(_localctx, 26, RULE_noteStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 117;
      date();
      state = 118;
      match(TOKEN_T__10);
      state = 119;
      account();
      state = 120;
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
    enterRule(_localctx, 28, RULE_empty_line);
    try {
      enterOuterAlt(_localctx, 1);
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

  TrStatementContext trStatement() {
    dynamic _localctx = TrStatementContext(context, state);
    enterRule(_localctx, 30, RULE_trStatement);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 124;
      tr_header();
      state = 125;
      match(TOKEN_NEWLINE);
      state = 133; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 129;
        errorHandler.sync(this);
        switch (interpreter!.adaptivePredict(tokenStream, 4, context)) {
        case 1:
          state = 126;
          posting_spec_account_only();
          break;
        case 2:
          state = 127;
          posting_spec_account_amount();
          break;
        case 3:
          state = 128;
          inline_comment();
          break;
        }
        state = 131;
        match(TOKEN_NEWLINE);
        state = 135; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while (_la == TOKEN_T__1 || _la == TOKEN_INDENT);
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
    enterRule(_localctx, 32, RULE_tr_header);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 137;
      date();
      state = 138;
      match(TOKEN_TR_FLAG);
      state = 139;
      _localctx.narration = quoted_string();
      state = 141;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_STR) {
        state = 140;
        _localctx.payee = quoted_string();
      }

      state = 144; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 143;
        match(TOKEN_TAG);
        state = 146; 
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

  Tr_commentContext tr_comment() {
    dynamic _localctx = Tr_commentContext(context, state);
    enterRule(_localctx, 34, RULE_tr_comment);
    try {
      enterOuterAlt(_localctx, 1);
      state = 148;
      match(TOKEN_INDENT);
      state = 149;
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

  Inline_commentContext inline_comment() {
    dynamic _localctx = Inline_commentContext(context, state);
    enterRule(_localctx, 36, RULE_inline_comment);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 151;
      match(TOKEN_T__1);
      state = 155;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while ((((_la) & ~0x3f) == 0 && ((BigInt.one << _la) & ((BigInt.one << TOKEN_T__0) | (BigInt.one << TOKEN_T__1) | (BigInt.one << TOKEN_T__2) | (BigInt.one << TOKEN_T__3) | (BigInt.one << TOKEN_T__4) | (BigInt.one << TOKEN_T__5) | (BigInt.one << TOKEN_T__6) | (BigInt.one << TOKEN_T__7) | (BigInt.one << TOKEN_T__8) | (BigInt.one << TOKEN_T__9) | (BigInt.one << TOKEN_T__10) | (BigInt.one << TOKEN_DIGIT) | (BigInt.one << TOKEN_YEAR) | (BigInt.one << TOKEN_MONTH) | (BigInt.one << TOKEN_DAY) | (BigInt.one << TOKEN_DATE) | (BigInt.one << TOKEN_NUMBER) | (BigInt.one << TOKEN_TAG) | (BigInt.one << TOKEN_WORD) | (BigInt.one << TOKEN_WHITESPACE) | (BigInt.one << TOKEN_TR_FLAG) | (BigInt.one << TOKEN_INDENT) | (BigInt.one << TOKEN_STR))) != BigInt.zero)) {
        state = 152;
        _la = tokenStream.LA(1)!;
        if (_la <= 0 || (_la == TOKEN_NEWLINE)) {
        errorHandler.recoverInline(this);
        } else {
          if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
          errorHandler.reportMatch(this);
          consume();
        }
        state = 157;
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

  Posting_spec_account_onlyContext posting_spec_account_only() {
    dynamic _localctx = Posting_spec_account_onlyContext(context, state);
    enterRule(_localctx, 38, RULE_posting_spec_account_only);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 158;
      match(TOKEN_INDENT);
      state = 159;
      account();
      state = 163;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_TAG) {
        state = 160;
        match(TOKEN_TAG);
        state = 165;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 167;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_T__1) {
        state = 166;
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
    enterRule(_localctx, 40, RULE_posting_spec_account_amount);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 169;
      match(TOKEN_INDENT);
      state = 170;
      account();
      state = 171;
      amount();
      state = 173; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 172;
        match(TOKEN_TAG);
        state = 175; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while (_la == TOKEN_TAG);
      state = 178;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_T__1) {
        state = 177;
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
    enterRule(_localctx, 42, RULE_date);
    try {
      enterOuterAlt(_localctx, 1);
      state = 180;
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
    enterRule(_localctx, 44, RULE_quoted_string);
    try {
      enterOuterAlt(_localctx, 1);
      state = 182;
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

  static const List<int> _serializedATN = [
      4,1,24,185,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,6,
      2,7,7,7,2,8,7,8,2,9,7,9,2,10,7,10,2,11,7,11,2,12,7,12,2,13,7,13,2,
      14,7,14,2,15,7,15,2,16,7,16,2,17,7,17,2,18,7,18,2,19,7,19,2,20,7,20,
      2,21,7,21,2,22,7,22,1,0,1,0,1,0,5,0,50,8,0,10,0,12,0,53,9,0,1,0,1,
      0,1,1,1,1,1,1,1,1,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,3,2,70,8,2,1,
      2,1,2,1,3,1,3,1,3,4,3,77,8,3,11,3,12,3,78,1,4,1,4,1,5,1,5,1,5,1,6,
      1,6,1,6,1,6,1,6,1,7,1,7,1,7,1,7,1,8,1,8,1,8,1,8,1,9,1,9,1,9,1,9,1,
      10,1,10,1,10,1,10,1,10,1,11,1,11,1,11,1,11,1,11,1,12,1,12,1,12,1,12,
      1,12,1,13,1,13,1,13,1,13,1,13,1,14,1,14,1,15,1,15,1,15,1,15,1,15,3,
      15,130,8,15,1,15,1,15,4,15,134,8,15,11,15,12,15,135,1,16,1,16,1,16,
      1,16,3,16,142,8,16,1,16,4,16,145,8,16,11,16,12,16,146,1,17,1,17,1,
      17,1,18,1,18,5,18,154,8,18,10,18,12,18,157,9,18,1,19,1,19,1,19,5,19,
      162,8,19,10,19,12,19,165,9,19,1,19,3,19,168,8,19,1,20,1,20,1,20,1,
      20,4,20,174,8,20,11,20,12,20,175,1,20,3,20,179,8,20,1,21,1,21,1,22,
      1,22,1,22,0,0,23,0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,
      36,38,40,42,44,0,2,1,0,1,2,1,0,21,21,183,0,51,1,0,0,0,2,56,1,0,0,0,
      4,69,1,0,0,0,6,73,1,0,0,0,8,80,1,0,0,0,10,82,1,0,0,0,12,85,1,0,0,0,
      14,90,1,0,0,0,16,94,1,0,0,0,18,98,1,0,0,0,20,102,1,0,0,0,22,107,1,
      0,0,0,24,112,1,0,0,0,26,117,1,0,0,0,28,122,1,0,0,0,30,124,1,0,0,0,
      32,137,1,0,0,0,34,148,1,0,0,0,36,151,1,0,0,0,38,158,1,0,0,0,40,169,
      1,0,0,0,42,180,1,0,0,0,44,182,1,0,0,0,46,50,3,4,2,0,47,50,3,2,1,0,
      48,50,3,28,14,0,49,46,1,0,0,0,49,47,1,0,0,0,49,48,1,0,0,0,50,53,1,
      0,0,0,51,49,1,0,0,0,51,52,1,0,0,0,52,54,1,0,0,0,53,51,1,0,0,0,54,55,
      5,0,0,1,55,1,1,0,0,0,56,57,7,0,0,0,57,58,8,1,0,0,58,59,5,21,0,0,59,
      3,1,0,0,0,60,70,3,12,6,0,61,70,3,14,7,0,62,70,3,16,8,0,63,70,3,18,
      9,0,64,70,3,20,10,0,65,70,3,22,11,0,66,70,3,24,12,0,67,70,3,26,13,
      0,68,70,3,30,15,0,69,60,1,0,0,0,69,61,1,0,0,0,69,62,1,0,0,0,69,63,
      1,0,0,0,69,64,1,0,0,0,69,65,1,0,0,0,69,66,1,0,0,0,69,67,1,0,0,0,69,
      68,1,0,0,0,70,71,1,0,0,0,71,72,5,21,0,0,72,5,1,0,0,0,73,76,5,19,0,
      0,74,75,5,3,0,0,75,77,5,19,0,0,76,74,1,0,0,0,77,78,1,0,0,0,78,76,1,
      0,0,0,78,79,1,0,0,0,79,7,1,0,0,0,80,81,5,19,0,0,81,9,1,0,0,0,82,83,
      5,17,0,0,83,84,3,8,4,0,84,11,1,0,0,0,85,86,3,42,21,0,86,87,5,4,0,0,
      87,88,3,6,3,0,88,89,3,10,5,0,89,13,1,0,0,0,90,91,3,42,21,0,91,92,5,
      5,0,0,92,93,3,6,3,0,93,15,1,0,0,0,94,95,3,42,21,0,95,96,5,6,0,0,96,
      97,3,6,3,0,97,17,1,0,0,0,98,99,3,42,21,0,99,100,5,7,0,0,100,101,3,
      8,4,0,101,19,1,0,0,0,102,103,3,42,21,0,103,104,5,8,0,0,104,105,3,8,
      4,0,105,106,3,10,5,0,106,21,1,0,0,0,107,108,3,42,21,0,108,109,5,9,
      0,0,109,110,3,44,22,0,110,111,3,44,22,0,111,23,1,0,0,0,112,113,3,42,
      21,0,113,114,5,10,0,0,114,115,3,6,3,0,115,116,3,44,22,0,116,25,1,0,
      0,0,117,118,3,42,21,0,118,119,5,11,0,0,119,120,3,6,3,0,120,121,3,44,
      22,0,121,27,1,0,0,0,122,123,5,21,0,0,123,29,1,0,0,0,124,125,3,32,16,
      0,125,133,5,21,0,0,126,130,3,38,19,0,127,130,3,40,20,0,128,130,3,36,
      18,0,129,126,1,0,0,0,129,127,1,0,0,0,129,128,1,0,0,0,130,131,1,0,0,
      0,131,132,5,21,0,0,132,134,1,0,0,0,133,129,1,0,0,0,134,135,1,0,0,0,
      135,133,1,0,0,0,135,136,1,0,0,0,136,31,1,0,0,0,137,138,3,42,21,0,138,
      139,5,22,0,0,139,141,3,44,22,0,140,142,3,44,22,0,141,140,1,0,0,0,141,
      142,1,0,0,0,142,144,1,0,0,0,143,145,5,18,0,0,144,143,1,0,0,0,145,146,
      1,0,0,0,146,144,1,0,0,0,146,147,1,0,0,0,147,33,1,0,0,0,148,149,5,23,
      0,0,149,150,3,36,18,0,150,35,1,0,0,0,151,155,5,2,0,0,152,154,8,1,0,
      0,153,152,1,0,0,0,154,157,1,0,0,0,155,153,1,0,0,0,155,156,1,0,0,0,
      156,37,1,0,0,0,157,155,1,0,0,0,158,159,5,23,0,0,159,163,3,6,3,0,160,
      162,5,18,0,0,161,160,1,0,0,0,162,165,1,0,0,0,163,161,1,0,0,0,163,164,
      1,0,0,0,164,167,1,0,0,0,165,163,1,0,0,0,166,168,3,36,18,0,167,166,
      1,0,0,0,167,168,1,0,0,0,168,39,1,0,0,0,169,170,5,23,0,0,170,171,3,
      6,3,0,171,173,3,10,5,0,172,174,5,18,0,0,173,172,1,0,0,0,174,175,1,
      0,0,0,175,173,1,0,0,0,175,176,1,0,0,0,176,178,1,0,0,0,177,179,3,36,
      18,0,178,177,1,0,0,0,178,179,1,0,0,0,179,41,1,0,0,0,180,181,5,16,0,
      0,181,43,1,0,0,0,182,183,5,24,0,0,183,45,1,0,0,0,13,49,51,69,78,129,
      135,141,146,155,163,167,175,178
  ];

  static final ATN _ATN =
      ATNDeserializer().deserialize(_serializedATN);
}
class AllContext extends ParserRuleContext {
  TerminalNode? EOF() => getToken(GringottsParser.TOKEN_EOF, 0);
  List<StatementContext> statements() => getRuleContexts<StatementContext>();
  StatementContext? statement(int i) => getRuleContext<StatementContext>(i);
  List<CommentContext> comments() => getRuleContexts<CommentContext>();
  CommentContext? comment(int i) => getRuleContext<CommentContext>(i);
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

class CommentContext extends ParserRuleContext {
  List<TerminalNode> NEWLINEs() => getTokens(GringottsParser.TOKEN_NEWLINE);
  TerminalNode? NEWLINE(int i) => getToken(GringottsParser.TOKEN_NEWLINE, i);
  CommentContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_comment;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterComment(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitComment(this);
  }
}

class StatementContext extends ParserRuleContext {
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
  List<Inline_commentContext> inline_comments() => getRuleContexts<Inline_commentContext>();
  Inline_commentContext? inline_comment(int i) => getRuleContext<Inline_commentContext>(i);
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
  List<TerminalNode> TAGs() => getTokens(GringottsParser.TOKEN_TAG);
  TerminalNode? TAG(int i) => getToken(GringottsParser.TOKEN_TAG, i);
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

class Tr_commentContext extends ParserRuleContext {
  TerminalNode? INDENT() => getToken(GringottsParser.TOKEN_INDENT, 0);
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

class Posting_spec_account_onlyContext extends ParserRuleContext {
  TerminalNode? INDENT() => getToken(GringottsParser.TOKEN_INDENT, 0);
  AccountContext? account() => getRuleContext<AccountContext>(0);
  List<TerminalNode> TAGs() => getTokens(GringottsParser.TOKEN_TAG);
  TerminalNode? TAG(int i) => getToken(GringottsParser.TOKEN_TAG, i);
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
  TerminalNode? INDENT() => getToken(GringottsParser.TOKEN_INDENT, 0);
  AccountContext? account() => getRuleContext<AccountContext>(0);
  AmountContext? amount() => getRuleContext<AmountContext>(0);
  List<TerminalNode> TAGs() => getTokens(GringottsParser.TOKEN_TAG);
  TerminalNode? TAG(int i) => getToken(GringottsParser.TOKEN_TAG, i);
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

