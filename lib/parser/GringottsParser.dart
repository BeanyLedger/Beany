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
          RULE_posting_spec_explicit_per_price = 24, RULE_posting_spec_explicit_total_price = 25, 
          RULE_price = 26, RULE_date = 27, RULE_quoted_string = 28, RULE_tags = 29;
class GringottsParser extends Parser {
  static final checkVersion = () => RuntimeMetaData.checkVersion('4.10.1', RuntimeMetaData.VERSION);
  static const int TOKEN_EOF = IntStream.EOF;

  static final List<DFA> _decisionToDFA = List.generate(
      _ATN.numberOfDecisions, (i) => DFA(_ATN.getDecisionState(i), i));
  static final PredictionContextCache _sharedContextCache = PredictionContextCache();
  static const int TOKEN_T__0 = 1, TOKEN_T__1 = 2, TOKEN_T__2 = 3, TOKEN_T__3 = 4, 
                   TOKEN_T__4 = 5, TOKEN_T__5 = 6, TOKEN_T__6 = 7, TOKEN_T__7 = 8, 
                   TOKEN_T__8 = 9, TOKEN_T__9 = 10, TOKEN_T__10 = 11, TOKEN_T__11 = 12, 
                   TOKEN_T__12 = 13, TOKEN_T__13 = 14, TOKEN_T__14 = 15, 
                   TOKEN_DIGIT = 16, TOKEN_YEAR = 17, TOKEN_MONTH = 18, 
                   TOKEN_DAY = 19, TOKEN_DATE = 20, TOKEN_NUMBER = 21, TOKEN_TAG = 22, 
                   TOKEN_WORD = 23, TOKEN_WHITESPACE = 24, TOKEN_NEWLINE = 25, 
                   TOKEN_TR_FLAG = 26, TOKEN_STR = 27;

  @override
  final List<String> ruleNames = [
    'all', 'statement', 'directive', 'account', 'currency', 'amount', 'includeStatement', 
    'optionStatement', 'commentStatement', 'balanceStatement', 'closeStatement', 
    'openStatement', 'commodityStatement', 'priceStatement', 'eventStatement', 
    'documentStatement', 'noteStatement', 'empty_line', 'trStatement', 'tr_header', 
    'inline_comment', 'tr_comment', 'posting_spec_account_only', 'posting_spec_account_amount', 
    'posting_spec_explicit_per_price', 'posting_spec_explicit_total_price', 
    'price', 'date', 'quoted_string', 'tags'
  ];

  static final List<String?> _LITERAL_NAMES = [
      null, "':'", "'include'", "'option'", "'#'", "';'", "'balance'", "'close'", 
      "'open'", "'commodity'", "'price'", "'event'", "'document'", "'note'", 
      "'@'", "'@@'"
  ];
  static final List<String?> _SYMBOLIC_NAMES = [
      null, null, null, null, null, null, null, null, null, null, null, 
      null, null, null, null, null, "DIGIT", "YEAR", "MONTH", "DAY", "DATE", 
      "NUMBER", "TAG", "WORD", "WHITESPACE", "NEWLINE", "TR_FLAG", "STR"
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
      state = 64;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while ((((_la) & ~0x3f) == 0 && ((BigInt.one << _la) & ((BigInt.one << TOKEN_T__1) | (BigInt.one << TOKEN_T__2) | (BigInt.one << TOKEN_T__3) | (BigInt.one << TOKEN_T__4) | (BigInt.one << TOKEN_DATE) | (BigInt.one << TOKEN_NEWLINE))) != BigInt.zero)) {
        state = 62;
        errorHandler.sync(this);
        switch (tokenStream.LA(1)!) {
        case TOKEN_T__1:
        case TOKEN_T__2:
        case TOKEN_T__3:
        case TOKEN_T__4:
        case TOKEN_DATE:
          state = 60;
          statement();
          break;
        case TOKEN_NEWLINE:
          state = 61;
          empty_line();
          break;
        default:
          throw NoViableAltException(this);
        }
        state = 66;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 67;
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
      state = 73;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_DATE:
        enterOuterAlt(_localctx, 1);
        state = 69;
        directive();
        break;
      case TOKEN_T__1:
        enterOuterAlt(_localctx, 2);
        state = 70;
        includeStatement();
        break;
      case TOKEN_T__2:
        enterOuterAlt(_localctx, 3);
        state = 71;
        optionStatement();
        break;
      case TOKEN_T__3:
      case TOKEN_T__4:
        enterOuterAlt(_localctx, 4);
        state = 72;
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
      state = 84;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 3, context)) {
      case 1:
        state = 75;
        balanceStatement();
        break;
      case 2:
        state = 76;
        closeStatement();
        break;
      case 3:
        state = 77;
        openStatement();
        break;
      case 4:
        state = 78;
        commodityStatement();
        break;
      case 5:
        state = 79;
        priceStatement();
        break;
      case 6:
        state = 80;
        eventStatement();
        break;
      case 7:
        state = 81;
        documentStatement();
        break;
      case 8:
        state = 82;
        noteStatement();
        break;
      case 9:
        state = 83;
        trStatement();
        break;
      }
      state = 86;
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
      state = 88;
      match(TOKEN_WORD);
      state = 91; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 89;
        match(TOKEN_T__0);
        state = 90;
        match(TOKEN_WORD);
        state = 93; 
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
      state = 95;
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
      state = 97;
      match(TOKEN_NUMBER);
      state = 98;
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
      state = 100;
      match(TOKEN_T__1);
      state = 101;
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
      state = 103;
      match(TOKEN_T__2);
      state = 104;
      _localctx.key = quoted_string();
      state = 105;
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
      state = 107;
      _la = tokenStream.LA(1)!;
      if (!(_la == TOKEN_T__3 || _la == TOKEN_T__4)) {
      errorHandler.recoverInline(this);
      } else {
        if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
      state = 111;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while ((((_la) & ~0x3f) == 0 && ((BigInt.one << _la) & ((BigInt.one << TOKEN_T__0) | (BigInt.one << TOKEN_T__1) | (BigInt.one << TOKEN_T__2) | (BigInt.one << TOKEN_T__3) | (BigInt.one << TOKEN_T__4) | (BigInt.one << TOKEN_T__5) | (BigInt.one << TOKEN_T__6) | (BigInt.one << TOKEN_T__7) | (BigInt.one << TOKEN_T__8) | (BigInt.one << TOKEN_T__9) | (BigInt.one << TOKEN_T__10) | (BigInt.one << TOKEN_T__11) | (BigInt.one << TOKEN_T__12) | (BigInt.one << TOKEN_T__13) | (BigInt.one << TOKEN_T__14) | (BigInt.one << TOKEN_DIGIT) | (BigInt.one << TOKEN_YEAR) | (BigInt.one << TOKEN_MONTH) | (BigInt.one << TOKEN_DAY) | (BigInt.one << TOKEN_DATE) | (BigInt.one << TOKEN_NUMBER) | (BigInt.one << TOKEN_TAG) | (BigInt.one << TOKEN_WORD) | (BigInt.one << TOKEN_WHITESPACE) | (BigInt.one << TOKEN_TR_FLAG) | (BigInt.one << TOKEN_STR))) != BigInt.zero)) {
        state = 108;
        _la = tokenStream.LA(1)!;
        if (_la <= 0 || (_la == TOKEN_NEWLINE)) {
        errorHandler.recoverInline(this);
        } else {
          if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
          errorHandler.reportMatch(this);
          consume();
        }
        state = 113;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 114;
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
      state = 116;
      date();
      state = 117;
      match(TOKEN_T__5);
      state = 118;
      account();
      state = 119;
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
      state = 121;
      date();
      state = 122;
      match(TOKEN_T__6);
      state = 123;
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
      state = 125;
      date();
      state = 126;
      match(TOKEN_T__7);
      state = 127;
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
      state = 129;
      date();
      state = 130;
      match(TOKEN_T__8);
      state = 131;
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
      state = 133;
      date();
      state = 134;
      match(TOKEN_T__9);
      state = 135;
      currency();
      state = 136;
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
      state = 138;
      date();
      state = 139;
      match(TOKEN_T__10);
      state = 140;
      _localctx.name = quoted_string();
      state = 141;
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
      state = 143;
      date();
      state = 144;
      match(TOKEN_T__11);
      state = 145;
      account();
      state = 146;
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
      state = 148;
      date();
      state = 149;
      match(TOKEN_T__12);
      state = 150;
      account();
      state = 151;
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
      state = 153;
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
      state = 155;
      tr_header();
      state = 156;
      match(TOKEN_NEWLINE);
      state = 162;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_T__4) {
        state = 157;
        tr_comment();
        state = 158;
        match(TOKEN_NEWLINE);
        state = 164;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 173; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 169;
        errorHandler.sync(this);
        switch (interpreter!.adaptivePredict(tokenStream, 7, context)) {
        case 1:
          state = 165;
          posting_spec_account_only();
          break;
        case 2:
          state = 166;
          posting_spec_account_amount();
          break;
        case 3:
          state = 167;
          posting_spec_explicit_per_price();
          break;
        case 4:
          state = 168;
          posting_spec_explicit_total_price();
          break;
        }
        state = 171;
        match(TOKEN_NEWLINE);
        state = 175; 
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
      state = 177;
      date();
      state = 178;
      match(TOKEN_TR_FLAG);
      state = 179;
      _localctx.narration = quoted_string();
      state = 181;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_STR) {
        state = 180;
        _localctx.payee = quoted_string();
      }

      state = 184;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_TAG) {
        state = 183;
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
      state = 186;
      match(TOKEN_T__4);
      state = 190;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while ((((_la) & ~0x3f) == 0 && ((BigInt.one << _la) & ((BigInt.one << TOKEN_T__0) | (BigInt.one << TOKEN_T__1) | (BigInt.one << TOKEN_T__2) | (BigInt.one << TOKEN_T__3) | (BigInt.one << TOKEN_T__4) | (BigInt.one << TOKEN_T__5) | (BigInt.one << TOKEN_T__6) | (BigInt.one << TOKEN_T__7) | (BigInt.one << TOKEN_T__8) | (BigInt.one << TOKEN_T__9) | (BigInt.one << TOKEN_T__10) | (BigInt.one << TOKEN_T__11) | (BigInt.one << TOKEN_T__12) | (BigInt.one << TOKEN_T__13) | (BigInt.one << TOKEN_T__14) | (BigInt.one << TOKEN_DIGIT) | (BigInt.one << TOKEN_YEAR) | (BigInt.one << TOKEN_MONTH) | (BigInt.one << TOKEN_DAY) | (BigInt.one << TOKEN_DATE) | (BigInt.one << TOKEN_NUMBER) | (BigInt.one << TOKEN_TAG) | (BigInt.one << TOKEN_WORD) | (BigInt.one << TOKEN_WHITESPACE) | (BigInt.one << TOKEN_TR_FLAG) | (BigInt.one << TOKEN_STR))) != BigInt.zero)) {
        state = 187;
        _la = tokenStream.LA(1)!;
        if (_la <= 0 || (_la == TOKEN_NEWLINE)) {
        errorHandler.recoverInline(this);
        } else {
          if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
          errorHandler.reportMatch(this);
          consume();
        }
        state = 192;
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
      state = 193;
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
      state = 195;
      account();
      state = 197;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_TAG) {
        state = 196;
        tags();
      }

      state = 200;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_T__4) {
        state = 199;
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
      state = 202;
      account();
      state = 203;
      amount();
      state = 205;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_TAG) {
        state = 204;
        tags();
      }

      state = 208;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_T__4) {
        state = 207;
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
    enterRule(_localctx, 48, RULE_posting_spec_explicit_per_price);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 210;
      account();
      state = 211;
      amount();
      state = 212;
      match(TOKEN_T__13);
      state = 213;
      price();
      state = 215;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_TAG) {
        state = 214;
        tags();
      }

      state = 218;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_T__4) {
        state = 217;
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
    dynamic _localctx = Posting_spec_explicit_total_priceContext(context, state);
    enterRule(_localctx, 50, RULE_posting_spec_explicit_total_price);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 220;
      account();
      state = 221;
      amount();
      state = 222;
      match(TOKEN_T__14);
      state = 223;
      price();
      state = 225;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_TAG) {
        state = 224;
        tags();
      }

      state = 228;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_T__4) {
        state = 227;
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
    enterRule(_localctx, 52, RULE_price);
    try {
      enterOuterAlt(_localctx, 1);
      state = 230;
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
    enterRule(_localctx, 54, RULE_date);
    try {
      enterOuterAlt(_localctx, 1);
      state = 232;
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
    enterRule(_localctx, 56, RULE_quoted_string);
    try {
      enterOuterAlt(_localctx, 1);
      state = 234;
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
    enterRule(_localctx, 58, RULE_tags);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 237; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 236;
        match(TOKEN_TAG);
        state = 239; 
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
      4,1,27,242,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,6,
      2,7,7,7,2,8,7,8,2,9,7,9,2,10,7,10,2,11,7,11,2,12,7,12,2,13,7,13,2,
      14,7,14,2,15,7,15,2,16,7,16,2,17,7,17,2,18,7,18,2,19,7,19,2,20,7,20,
      2,21,7,21,2,22,7,22,2,23,7,23,2,24,7,24,2,25,7,25,2,26,7,26,2,27,7,
      27,2,28,7,28,2,29,7,29,1,0,1,0,5,0,63,8,0,10,0,12,0,66,9,0,1,0,1,0,
      1,1,1,1,1,1,1,1,3,1,74,8,1,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,3,2,
      85,8,2,1,2,1,2,1,3,1,3,1,3,4,3,92,8,3,11,3,12,3,93,1,4,1,4,1,5,1,5,
      1,5,1,6,1,6,1,6,1,7,1,7,1,7,1,7,1,8,1,8,5,8,110,8,8,10,8,12,8,113,
      9,8,1,8,1,8,1,9,1,9,1,9,1,9,1,9,1,10,1,10,1,10,1,10,1,11,1,11,1,11,
      1,11,1,12,1,12,1,12,1,12,1,13,1,13,1,13,1,13,1,13,1,14,1,14,1,14,1,
      14,1,14,1,15,1,15,1,15,1,15,1,15,1,16,1,16,1,16,1,16,1,16,1,17,1,17,
      1,18,1,18,1,18,1,18,1,18,5,18,161,8,18,10,18,12,18,164,9,18,1,18,1,
      18,1,18,1,18,3,18,170,8,18,1,18,1,18,4,18,174,8,18,11,18,12,18,175,
      1,19,1,19,1,19,1,19,3,19,182,8,19,1,19,3,19,185,8,19,1,20,1,20,5,20,
      189,8,20,10,20,12,20,192,9,20,1,21,1,21,1,22,1,22,3,22,198,8,22,1,
      22,3,22,201,8,22,1,23,1,23,1,23,3,23,206,8,23,1,23,3,23,209,8,23,1,
      24,1,24,1,24,1,24,1,24,3,24,216,8,24,1,24,3,24,219,8,24,1,25,1,25,
      1,25,1,25,1,25,3,25,226,8,25,1,25,3,25,229,8,25,1,26,1,26,1,27,1,27,
      1,28,1,28,1,29,4,29,238,8,29,11,29,12,29,239,1,29,0,0,30,0,2,4,6,8,
      10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,
      54,56,58,0,2,1,0,4,5,1,0,25,25,243,0,64,1,0,0,0,2,73,1,0,0,0,4,84,
      1,0,0,0,6,88,1,0,0,0,8,95,1,0,0,0,10,97,1,0,0,0,12,100,1,0,0,0,14,
      103,1,0,0,0,16,107,1,0,0,0,18,116,1,0,0,0,20,121,1,0,0,0,22,125,1,
      0,0,0,24,129,1,0,0,0,26,133,1,0,0,0,28,138,1,0,0,0,30,143,1,0,0,0,
      32,148,1,0,0,0,34,153,1,0,0,0,36,155,1,0,0,0,38,177,1,0,0,0,40,186,
      1,0,0,0,42,193,1,0,0,0,44,195,1,0,0,0,46,202,1,0,0,0,48,210,1,0,0,
      0,50,220,1,0,0,0,52,230,1,0,0,0,54,232,1,0,0,0,56,234,1,0,0,0,58,237,
      1,0,0,0,60,63,3,2,1,0,61,63,3,34,17,0,62,60,1,0,0,0,62,61,1,0,0,0,
      63,66,1,0,0,0,64,62,1,0,0,0,64,65,1,0,0,0,65,67,1,0,0,0,66,64,1,0,
      0,0,67,68,5,0,0,1,68,1,1,0,0,0,69,74,3,4,2,0,70,74,3,12,6,0,71,74,
      3,14,7,0,72,74,3,16,8,0,73,69,1,0,0,0,73,70,1,0,0,0,73,71,1,0,0,0,
      73,72,1,0,0,0,74,3,1,0,0,0,75,85,3,18,9,0,76,85,3,20,10,0,77,85,3,
      22,11,0,78,85,3,24,12,0,79,85,3,26,13,0,80,85,3,28,14,0,81,85,3,30,
      15,0,82,85,3,32,16,0,83,85,3,36,18,0,84,75,1,0,0,0,84,76,1,0,0,0,84,
      77,1,0,0,0,84,78,1,0,0,0,84,79,1,0,0,0,84,80,1,0,0,0,84,81,1,0,0,0,
      84,82,1,0,0,0,84,83,1,0,0,0,85,86,1,0,0,0,86,87,5,25,0,0,87,5,1,0,
      0,0,88,91,5,23,0,0,89,90,5,1,0,0,90,92,5,23,0,0,91,89,1,0,0,0,92,93,
      1,0,0,0,93,91,1,0,0,0,93,94,1,0,0,0,94,7,1,0,0,0,95,96,5,23,0,0,96,
      9,1,0,0,0,97,98,5,21,0,0,98,99,3,8,4,0,99,11,1,0,0,0,100,101,5,2,0,
      0,101,102,3,56,28,0,102,13,1,0,0,0,103,104,5,3,0,0,104,105,3,56,28,
      0,105,106,3,56,28,0,106,15,1,0,0,0,107,111,7,0,0,0,108,110,8,1,0,0,
      109,108,1,0,0,0,110,113,1,0,0,0,111,109,1,0,0,0,111,112,1,0,0,0,112,
      114,1,0,0,0,113,111,1,0,0,0,114,115,5,25,0,0,115,17,1,0,0,0,116,117,
      3,54,27,0,117,118,5,6,0,0,118,119,3,6,3,0,119,120,3,10,5,0,120,19,
      1,0,0,0,121,122,3,54,27,0,122,123,5,7,0,0,123,124,3,6,3,0,124,21,1,
      0,0,0,125,126,3,54,27,0,126,127,5,8,0,0,127,128,3,6,3,0,128,23,1,0,
      0,0,129,130,3,54,27,0,130,131,5,9,0,0,131,132,3,8,4,0,132,25,1,0,0,
      0,133,134,3,54,27,0,134,135,5,10,0,0,135,136,3,8,4,0,136,137,3,10,
      5,0,137,27,1,0,0,0,138,139,3,54,27,0,139,140,5,11,0,0,140,141,3,56,
      28,0,141,142,3,56,28,0,142,29,1,0,0,0,143,144,3,54,27,0,144,145,5,
      12,0,0,145,146,3,6,3,0,146,147,3,56,28,0,147,31,1,0,0,0,148,149,3,
      54,27,0,149,150,5,13,0,0,150,151,3,6,3,0,151,152,3,56,28,0,152,33,
      1,0,0,0,153,154,5,25,0,0,154,35,1,0,0,0,155,156,3,38,19,0,156,162,
      5,25,0,0,157,158,3,42,21,0,158,159,5,25,0,0,159,161,1,0,0,0,160,157,
      1,0,0,0,161,164,1,0,0,0,162,160,1,0,0,0,162,163,1,0,0,0,163,173,1,
      0,0,0,164,162,1,0,0,0,165,170,3,44,22,0,166,170,3,46,23,0,167,170,
      3,48,24,0,168,170,3,50,25,0,169,165,1,0,0,0,169,166,1,0,0,0,169,167,
      1,0,0,0,169,168,1,0,0,0,170,171,1,0,0,0,171,172,5,25,0,0,172,174,1,
      0,0,0,173,169,1,0,0,0,174,175,1,0,0,0,175,173,1,0,0,0,175,176,1,0,
      0,0,176,37,1,0,0,0,177,178,3,54,27,0,178,179,5,26,0,0,179,181,3,56,
      28,0,180,182,3,56,28,0,181,180,1,0,0,0,181,182,1,0,0,0,182,184,1,0,
      0,0,183,185,3,58,29,0,184,183,1,0,0,0,184,185,1,0,0,0,185,39,1,0,0,
      0,186,190,5,5,0,0,187,189,8,1,0,0,188,187,1,0,0,0,189,192,1,0,0,0,
      190,188,1,0,0,0,190,191,1,0,0,0,191,41,1,0,0,0,192,190,1,0,0,0,193,
      194,3,40,20,0,194,43,1,0,0,0,195,197,3,6,3,0,196,198,3,58,29,0,197,
      196,1,0,0,0,197,198,1,0,0,0,198,200,1,0,0,0,199,201,3,40,20,0,200,
      199,1,0,0,0,200,201,1,0,0,0,201,45,1,0,0,0,202,203,3,6,3,0,203,205,
      3,10,5,0,204,206,3,58,29,0,205,204,1,0,0,0,205,206,1,0,0,0,206,208,
      1,0,0,0,207,209,3,40,20,0,208,207,1,0,0,0,208,209,1,0,0,0,209,47,1,
      0,0,0,210,211,3,6,3,0,211,212,3,10,5,0,212,213,5,14,0,0,213,215,3,
      52,26,0,214,216,3,58,29,0,215,214,1,0,0,0,215,216,1,0,0,0,216,218,
      1,0,0,0,217,219,3,40,20,0,218,217,1,0,0,0,218,219,1,0,0,0,219,49,1,
      0,0,0,220,221,3,6,3,0,221,222,3,10,5,0,222,223,5,15,0,0,223,225,3,
      52,26,0,224,226,3,58,29,0,225,224,1,0,0,0,225,226,1,0,0,0,226,228,
      1,0,0,0,227,229,3,40,20,0,228,227,1,0,0,0,228,229,1,0,0,0,229,51,1,
      0,0,0,230,231,3,10,5,0,231,53,1,0,0,0,232,233,5,20,0,0,233,55,1,0,
      0,0,234,235,5,27,0,0,235,57,1,0,0,0,236,238,5,22,0,0,237,236,1,0,0,
      0,238,239,1,0,0,0,239,237,1,0,0,0,239,240,1,0,0,0,240,59,1,0,0,0,21,
      62,64,73,84,93,111,162,169,175,181,184,190,197,200,205,208,215,218,
      225,228,239
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
  List<Posting_spec_explicit_per_priceContext> posting_spec_explicit_per_prices() => getRuleContexts<Posting_spec_explicit_per_priceContext>();
  Posting_spec_explicit_per_priceContext? posting_spec_explicit_per_price(int i) => getRuleContext<Posting_spec_explicit_per_priceContext>(i);
  List<Posting_spec_explicit_total_priceContext> posting_spec_explicit_total_prices() => getRuleContexts<Posting_spec_explicit_total_priceContext>();
  Posting_spec_explicit_total_priceContext? posting_spec_explicit_total_price(int i) => getRuleContext<Posting_spec_explicit_total_priceContext>(i);
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

class Posting_spec_explicit_per_priceContext extends ParserRuleContext {
  AccountContext? account() => getRuleContext<AccountContext>(0);
  AmountContext? amount() => getRuleContext<AmountContext>(0);
  PriceContext? price() => getRuleContext<PriceContext>(0);
  TagsContext? tags() => getRuleContext<TagsContext>(0);
  Inline_commentContext? inline_comment() => getRuleContext<Inline_commentContext>(0);
  Posting_spec_explicit_per_priceContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_posting_spec_explicit_per_price;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterPosting_spec_explicit_per_price(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitPosting_spec_explicit_per_price(this);
  }
}

class Posting_spec_explicit_total_priceContext extends ParserRuleContext {
  AccountContext? account() => getRuleContext<AccountContext>(0);
  AmountContext? amount() => getRuleContext<AmountContext>(0);
  PriceContext? price() => getRuleContext<PriceContext>(0);
  TagsContext? tags() => getRuleContext<TagsContext>(0);
  Inline_commentContext? inline_comment() => getRuleContext<Inline_commentContext>(0);
  Posting_spec_explicit_total_priceContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_posting_spec_explicit_total_price;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterPosting_spec_explicit_total_price(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitPosting_spec_explicit_total_price(this);
  }
}

class PriceContext extends ParserRuleContext {
  AmountContext? amount() => getRuleContext<AmountContext>(0);
  PriceContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_price;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.enterPrice(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is GringottsListener) listener.exitPrice(this);
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
