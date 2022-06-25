// Generated from Gringotts.g4 by ANTLR 4.10.1
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes
import 'package:antlr4/antlr4.dart';

import 'GringottsListener.dart';
import 'GringottsBaseListener.dart';
const int RULE_all = 0, RULE_comment = 1, RULE_statement = 2, RULE_account = 3, 
          RULE_currency = 4, RULE_amount = 5, RULE_balanceStatement = 6, 
          RULE_closeStatement = 7, RULE_openStatement = 8, RULE_commodityStatement = 9, 
          RULE_priceStatement = 10, RULE_eventStatement = 11, RULE_documentStatement = 12, 
          RULE_noteStatement = 13, RULE_empty_line = 14, RULE_tr_statement = 15, 
          RULE_tr_header = 16, RULE_tr_comment = 17, RULE_inline_comment = 18, 
          RULE_posting_spec_account_only = 19, RULE_posting_spec_account_amount = 20, 
          RULE_date = 21;
class GringottsParser extends Parser {
  static final checkVersion = () => RuntimeMetaData.checkVersion('4.10.1', RuntimeMetaData.VERSION);
  static const int TOKEN_EOF = IntStream.EOF;

  static final List<DFA> _decisionToDFA = List.generate(
      _ATN.numberOfDecisions, (i) => DFA(_ATN.getDecisionState(i), i));
  static final PredictionContextCache _sharedContextCache = PredictionContextCache();
  static const int TOKEN_T__0 = 1, TOKEN_T__1 = 2, TOKEN_T__2 = 3, TOKEN_T__3 = 4, 
                   TOKEN_T__4 = 5, TOKEN_T__5 = 6, TOKEN_T__6 = 7, TOKEN_T__7 = 8, 
                   TOKEN_T__8 = 9, TOKEN_T__9 = 10, TOKEN_DIGIT = 11, TOKEN_YEAR = 12, 
                   TOKEN_MONTH = 13, TOKEN_DAY = 14, TOKEN_DATE = 15, TOKEN_NUMBER = 16, 
                   TOKEN_TAG = 17, TOKEN_WORD = 18, TOKEN_WHITESPACE = 19, 
                   TOKEN_NEWLINE = 20, TOKEN_STRING = 21, TOKEN_TR_FLAG = 22, 
                   TOKEN_INDENT = 23;

  @override
  final List<String> ruleNames = [
    'all', 'comment', 'statement', 'account', 'currency', 'amount', 'balanceStatement', 
    'closeStatement', 'openStatement', 'commodityStatement', 'priceStatement', 
    'eventStatement', 'documentStatement', 'noteStatement', 'empty_line', 
    'tr_statement', 'tr_header', 'tr_comment', 'inline_comment', 'posting_spec_account_only', 
    'posting_spec_account_amount', 'date'
  ];

  static final List<String?> _LITERAL_NAMES = [
      null, "'#'", "';'", "':'", "'balance'", "'close'", "'open'", "'commodity'", 
      "'price'", "'event'", "'document'"
  ];
  static final List<String?> _SYMBOLIC_NAMES = [
      null, null, null, null, null, null, null, null, null, null, null, 
      "DIGIT", "YEAR", "MONTH", "DAY", "DATE", "NUMBER", "TAG", "WORD", 
      "WHITESPACE", "NEWLINE", "STRING", "TR_FLAG", "INDENT"
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
      state = 49;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while ((((_la) & ~0x3f) == 0 && ((BigInt.one << _la) & ((BigInt.one << TOKEN_T__0) | (BigInt.one << TOKEN_T__1) | (BigInt.one << TOKEN_DATE) | (BigInt.one << TOKEN_NEWLINE))) != BigInt.zero)) {
        state = 47;
        errorHandler.sync(this);
        switch (tokenStream.LA(1)!) {
        case TOKEN_DATE:
          state = 44;
          statement();
          break;
        case TOKEN_T__0:
        case TOKEN_T__1:
          state = 45;
          comment();
          break;
        case TOKEN_NEWLINE:
          state = 46;
          empty_line();
          break;
        default:
          throw NoViableAltException(this);
        }
        state = 51;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 52;
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
      state = 54;
      _la = tokenStream.LA(1)!;
      if (!(_la == TOKEN_T__0 || _la == TOKEN_T__1)) {
      errorHandler.recoverInline(this);
      } else {
        if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
      state = 55;
      _la = tokenStream.LA(1)!;
      if (_la <= 0 || (_la == TOKEN_NEWLINE)) {
      errorHandler.recoverInline(this);
      } else {
        if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
      state = 56;
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
      state = 67;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 2, context)) {
      case 1:
        state = 58;
        balanceStatement();
        break;
      case 2:
        state = 59;
        closeStatement();
        break;
      case 3:
        state = 60;
        openStatement();
        break;
      case 4:
        state = 61;
        commodityStatement();
        break;
      case 5:
        state = 62;
        priceStatement();
        break;
      case 6:
        state = 63;
        eventStatement();
        break;
      case 7:
        state = 64;
        documentStatement();
        break;
      case 8:
        state = 65;
        noteStatement();
        break;
      case 9:
        state = 66;
        tr_statement();
        break;
      }
      state = 69;
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
      state = 71;
      match(TOKEN_WORD);

      state = 73; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 72;
        match(TOKEN_T__2);
        state = 75; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while (_la == TOKEN_T__2);
      state = 77;
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

  CurrencyContext currency() {
    dynamic _localctx = CurrencyContext(context, state);
    enterRule(_localctx, 8, RULE_currency);
    try {
      enterOuterAlt(_localctx, 1);
      state = 79;
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
      state = 81;
      match(TOKEN_NUMBER);
      state = 82;
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
      state = 84;
      date();
      state = 85;
      match(TOKEN_T__3);
      state = 86;
      account();
      state = 87;
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
      state = 89;
      date();
      state = 90;
      match(TOKEN_T__4);
      state = 91;
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
      state = 93;
      date();
      state = 94;
      match(TOKEN_T__5);
      state = 95;
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
      state = 97;
      date();
      state = 98;
      match(TOKEN_T__6);
      state = 99;
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
      state = 101;
      date();
      state = 102;
      match(TOKEN_T__7);
      state = 103;
      currency();
      state = 104;
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
      state = 106;
      date();
      state = 107;
      match(TOKEN_T__8);
      state = 108;
      _localctx.name = match(TOKEN_STRING);
      state = 109;
      _localctx.value = match(TOKEN_STRING);
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
      state = 111;
      date();
      state = 112;
      match(TOKEN_T__9);
      state = 113;
      account();
      state = 114;
      match(TOKEN_STRING);
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
      state = 116;
      date();
      state = 117;
      match(TOKEN_T__9);
      state = 118;
      account();
      state = 119;
      match(TOKEN_STRING);
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
      state = 121;
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

  Tr_statementContext tr_statement() {
    dynamic _localctx = Tr_statementContext(context, state);
    enterRule(_localctx, 30, RULE_tr_statement);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 123;
      tr_header();
      state = 124;
      match(TOKEN_NEWLINE);
      state = 132; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 128;
        errorHandler.sync(this);
        switch (interpreter!.adaptivePredict(tokenStream, 4, context)) {
        case 1:
          state = 125;
          posting_spec_account_only();
          break;
        case 2:
          state = 126;
          posting_spec_account_amount();
          break;
        case 3:
          state = 127;
          inline_comment();
          break;
        }
        state = 130;
        match(TOKEN_NEWLINE);
        state = 134; 
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
      state = 136;
      date();
      state = 137;
      match(TOKEN_TR_FLAG);
      state = 138;
      _localctx.narration = match(TOKEN_STRING);
      state = 140;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_STRING) {
        state = 139;
        _localctx.payee = match(TOKEN_STRING);
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
    enterRule(_localctx, 34, RULE_tr_comment);
    try {
      enterOuterAlt(_localctx, 1);
      state = 142;
      match(TOKEN_INDENT);
      state = 143;
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
      state = 145;
      match(TOKEN_T__1);
      state = 149;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while ((((_la) & ~0x3f) == 0 && ((BigInt.one << _la) & ((BigInt.one << TOKEN_T__0) | (BigInt.one << TOKEN_T__1) | (BigInt.one << TOKEN_T__2) | (BigInt.one << TOKEN_T__3) | (BigInt.one << TOKEN_T__4) | (BigInt.one << TOKEN_T__5) | (BigInt.one << TOKEN_T__6) | (BigInt.one << TOKEN_T__7) | (BigInt.one << TOKEN_T__8) | (BigInt.one << TOKEN_T__9) | (BigInt.one << TOKEN_DIGIT) | (BigInt.one << TOKEN_YEAR) | (BigInt.one << TOKEN_MONTH) | (BigInt.one << TOKEN_DAY) | (BigInt.one << TOKEN_DATE) | (BigInt.one << TOKEN_NUMBER) | (BigInt.one << TOKEN_TAG) | (BigInt.one << TOKEN_WORD) | (BigInt.one << TOKEN_WHITESPACE) | (BigInt.one << TOKEN_STRING) | (BigInt.one << TOKEN_TR_FLAG) | (BigInt.one << TOKEN_INDENT))) != BigInt.zero)) {
        state = 146;
        _la = tokenStream.LA(1)!;
        if (_la <= 0 || (_la == TOKEN_NEWLINE)) {
        errorHandler.recoverInline(this);
        } else {
          if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
          errorHandler.reportMatch(this);
          consume();
        }
        state = 151;
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
      state = 152;
      match(TOKEN_INDENT);
      state = 153;
      account();
      state = 155; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 154;
        match(TOKEN_TAG);
        state = 157; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while (_la == TOKEN_TAG);
      state = 160;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_T__1) {
        state = 159;
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
      state = 162;
      match(TOKEN_INDENT);
      state = 163;
      account();
      state = 164;
      amount();
      state = 166; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 165;
        match(TOKEN_TAG);
        state = 168; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while (_la == TOKEN_TAG);
      state = 171;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_T__1) {
        state = 170;
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
      state = 173;
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

  static const List<int> _serializedATN = [
      4,1,23,176,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,6,
      2,7,7,7,2,8,7,8,2,9,7,9,2,10,7,10,2,11,7,11,2,12,7,12,2,13,7,13,2,
      14,7,14,2,15,7,15,2,16,7,16,2,17,7,17,2,18,7,18,2,19,7,19,2,20,7,20,
      2,21,7,21,1,0,1,0,1,0,5,0,48,8,0,10,0,12,0,51,9,0,1,0,1,0,1,1,1,1,
      1,1,1,1,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,3,2,68,8,2,1,2,1,2,1,3,
      1,3,4,3,74,8,3,11,3,12,3,75,1,3,1,3,1,4,1,4,1,5,1,5,1,5,1,6,1,6,1,
      6,1,6,1,6,1,7,1,7,1,7,1,7,1,8,1,8,1,8,1,8,1,9,1,9,1,9,1,9,1,10,1,10,
      1,10,1,10,1,10,1,11,1,11,1,11,1,11,1,11,1,12,1,12,1,12,1,12,1,12,1,
      13,1,13,1,13,1,13,1,13,1,14,1,14,1,15,1,15,1,15,1,15,1,15,3,15,129,
      8,15,1,15,1,15,4,15,133,8,15,11,15,12,15,134,1,16,1,16,1,16,1,16,3,
      16,141,8,16,1,17,1,17,1,17,1,18,1,18,5,18,148,8,18,10,18,12,18,151,
      9,18,1,19,1,19,1,19,4,19,156,8,19,11,19,12,19,157,1,19,3,19,161,8,
      19,1,20,1,20,1,20,1,20,4,20,167,8,20,11,20,12,20,168,1,20,3,20,172,
      8,20,1,21,1,21,1,21,0,0,22,0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,
      30,32,34,36,38,40,42,0,2,1,0,1,2,1,0,20,20,174,0,49,1,0,0,0,2,54,1,
      0,0,0,4,67,1,0,0,0,6,71,1,0,0,0,8,79,1,0,0,0,10,81,1,0,0,0,12,84,1,
      0,0,0,14,89,1,0,0,0,16,93,1,0,0,0,18,97,1,0,0,0,20,101,1,0,0,0,22,
      106,1,0,0,0,24,111,1,0,0,0,26,116,1,0,0,0,28,121,1,0,0,0,30,123,1,
      0,0,0,32,136,1,0,0,0,34,142,1,0,0,0,36,145,1,0,0,0,38,152,1,0,0,0,
      40,162,1,0,0,0,42,173,1,0,0,0,44,48,3,4,2,0,45,48,3,2,1,0,46,48,3,
      28,14,0,47,44,1,0,0,0,47,45,1,0,0,0,47,46,1,0,0,0,48,51,1,0,0,0,49,
      47,1,0,0,0,49,50,1,0,0,0,50,52,1,0,0,0,51,49,1,0,0,0,52,53,5,0,0,1,
      53,1,1,0,0,0,54,55,7,0,0,0,55,56,8,1,0,0,56,57,5,20,0,0,57,3,1,0,0,
      0,58,68,3,12,6,0,59,68,3,14,7,0,60,68,3,16,8,0,61,68,3,18,9,0,62,68,
      3,20,10,0,63,68,3,22,11,0,64,68,3,24,12,0,65,68,3,26,13,0,66,68,3,
      30,15,0,67,58,1,0,0,0,67,59,1,0,0,0,67,60,1,0,0,0,67,61,1,0,0,0,67,
      62,1,0,0,0,67,63,1,0,0,0,67,64,1,0,0,0,67,65,1,0,0,0,67,66,1,0,0,0,
      68,69,1,0,0,0,69,70,5,20,0,0,70,5,1,0,0,0,71,73,5,18,0,0,72,74,5,3,
      0,0,73,72,1,0,0,0,74,75,1,0,0,0,75,73,1,0,0,0,75,76,1,0,0,0,76,77,
      1,0,0,0,77,78,5,18,0,0,78,7,1,0,0,0,79,80,5,18,0,0,80,9,1,0,0,0,81,
      82,5,16,0,0,82,83,3,8,4,0,83,11,1,0,0,0,84,85,3,42,21,0,85,86,5,4,
      0,0,86,87,3,6,3,0,87,88,3,10,5,0,88,13,1,0,0,0,89,90,3,42,21,0,90,
      91,5,5,0,0,91,92,3,6,3,0,92,15,1,0,0,0,93,94,3,42,21,0,94,95,5,6,0,
      0,95,96,3,6,3,0,96,17,1,0,0,0,97,98,3,42,21,0,98,99,5,7,0,0,99,100,
      3,8,4,0,100,19,1,0,0,0,101,102,3,42,21,0,102,103,5,8,0,0,103,104,3,
      8,4,0,104,105,3,10,5,0,105,21,1,0,0,0,106,107,3,42,21,0,107,108,5,
      9,0,0,108,109,5,21,0,0,109,110,5,21,0,0,110,23,1,0,0,0,111,112,3,42,
      21,0,112,113,5,10,0,0,113,114,3,6,3,0,114,115,5,21,0,0,115,25,1,0,
      0,0,116,117,3,42,21,0,117,118,5,10,0,0,118,119,3,6,3,0,119,120,5,21,
      0,0,120,27,1,0,0,0,121,122,5,20,0,0,122,29,1,0,0,0,123,124,3,32,16,
      0,124,132,5,20,0,0,125,129,3,38,19,0,126,129,3,40,20,0,127,129,3,36,
      18,0,128,125,1,0,0,0,128,126,1,0,0,0,128,127,1,0,0,0,129,130,1,0,0,
      0,130,131,5,20,0,0,131,133,1,0,0,0,132,128,1,0,0,0,133,134,1,0,0,0,
      134,132,1,0,0,0,134,135,1,0,0,0,135,31,1,0,0,0,136,137,3,42,21,0,137,
      138,5,22,0,0,138,140,5,21,0,0,139,141,5,21,0,0,140,139,1,0,0,0,140,
      141,1,0,0,0,141,33,1,0,0,0,142,143,5,23,0,0,143,144,3,36,18,0,144,
      35,1,0,0,0,145,149,5,2,0,0,146,148,8,1,0,0,147,146,1,0,0,0,148,151,
      1,0,0,0,149,147,1,0,0,0,149,150,1,0,0,0,150,37,1,0,0,0,151,149,1,0,
      0,0,152,153,5,23,0,0,153,155,3,6,3,0,154,156,5,17,0,0,155,154,1,0,
      0,0,156,157,1,0,0,0,157,155,1,0,0,0,157,158,1,0,0,0,158,160,1,0,0,
      0,159,161,3,36,18,0,160,159,1,0,0,0,160,161,1,0,0,0,161,39,1,0,0,0,
      162,163,5,23,0,0,163,164,3,6,3,0,164,166,3,10,5,0,165,167,5,17,0,0,
      166,165,1,0,0,0,167,168,1,0,0,0,168,166,1,0,0,0,168,169,1,0,0,0,169,
      171,1,0,0,0,170,172,3,36,18,0,171,170,1,0,0,0,171,172,1,0,0,0,172,
      41,1,0,0,0,173,174,5,15,0,0,174,43,1,0,0,0,12,47,49,67,75,128,134,
      140,149,157,160,168,171
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
  Tr_statementContext? tr_statement() => getRuleContext<Tr_statementContext>(0);
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
  Token? name;
  Token? value;
  DateContext? date() => getRuleContext<DateContext>(0);
  List<TerminalNode> STRINGs() => getTokens(GringottsParser.TOKEN_STRING);
  TerminalNode? STRING(int i) => getToken(GringottsParser.TOKEN_STRING, i);
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
  TerminalNode? STRING() => getToken(GringottsParser.TOKEN_STRING, 0);
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
  TerminalNode? STRING() => getToken(GringottsParser.TOKEN_STRING, 0);
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

class Tr_statementContext extends ParserRuleContext {
  Tr_headerContext? tr_header() => getRuleContext<Tr_headerContext>(0);
  List<TerminalNode> NEWLINEs() => getTokens(GringottsParser.TOKEN_NEWLINE);
  TerminalNode? NEWLINE(int i) => getToken(GringottsParser.TOKEN_NEWLINE, i);
  List<Posting_spec_account_onlyContext> posting_spec_account_onlys() => getRuleContexts<Posting_spec_account_onlyContext>();
  Posting_spec_account_onlyContext? posting_spec_account_only(int i) => getRuleContext<Posting_spec_account_onlyContext>(i);
  List<Posting_spec_account_amountContext> posting_spec_account_amounts() => getRuleContexts<Posting_spec_account_amountContext>();
  Posting_spec_account_amountContext? posting_spec_account_amount(int i) => getRuleContext<Posting_spec_account_amountContext>(i);
  List<Inline_commentContext> inline_comments() => getRuleContexts<Inline_commentContext>();
  Inline_commentContext? inline_comment(int i) => getRuleContext<Inline_commentContext>(i);
  Tr_statementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_tr_statement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterTr_statement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitTr_statement(this);
  }
}

class Tr_headerContext extends ParserRuleContext {
  Token? narration;
  Token? payee;
  DateContext? date() => getRuleContext<DateContext>(0);
  TerminalNode? TR_FLAG() => getToken(GringottsParser.TOKEN_TR_FLAG, 0);
  List<TerminalNode> STRINGs() => getTokens(GringottsParser.TOKEN_STRING);
  TerminalNode? STRING(int i) => getToken(GringottsParser.TOKEN_STRING, i);
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

