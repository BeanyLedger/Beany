// Generated from Gringotts.g4 by ANTLR 4.10.1
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes
import 'package:antlr4/antlr4.dart';

import 'GringottsListener.dart';
import 'GringottsBaseListener.dart';
const int RULE_all = 0, RULE_comment = 1, RULE_statement = 2, RULE_account = 3, 
          RULE_currency = 4, RULE_amount = 5, RULE_balanceStatement = 6, 
          RULE_closeStatement = 7, RULE_openStatement = 8, RULE_empty_line = 9;
class GringottsParser extends Parser {
  static final checkVersion = () => RuntimeMetaData.checkVersion('4.10.1', RuntimeMetaData.VERSION);
  static const int TOKEN_EOF = IntStream.EOF;

  static final List<DFA> _decisionToDFA = List.generate(
      _ATN.numberOfDecisions, (i) => DFA(_ATN.getDecisionState(i), i));
  static final PredictionContextCache _sharedContextCache = PredictionContextCache();
  static const int TOKEN_T__0 = 1, TOKEN_T__1 = 2, TOKEN_T__2 = 3, TOKEN_T__3 = 4, 
                   TOKEN_T__4 = 5, TOKEN_DATE = 6, TOKEN_NUMBER = 7, TOKEN_WORD = 8, 
                   TOKEN_WHITESPACE = 9, TOKEN_NEWLINE = 10, TOKEN_STRING = 11;

  @override
  final List<String> ruleNames = [
    'all', 'comment', 'statement', 'account', 'currency', 'amount', 'balanceStatement', 
    'closeStatement', 'openStatement', 'empty_line'
  ];

  static final List<String?> _LITERAL_NAMES = [
      null, "'#'", "':'", "'balance'", "'close'", "'open'"
  ];
  static final List<String?> _SYMBOLIC_NAMES = [
      null, null, null, null, null, null, "DATE", "NUMBER", "WORD", "WHITESPACE", 
      "NEWLINE", "STRING"
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
      state = 23; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 23;
        errorHandler.sync(this);
        switch (tokenStream.LA(1)!) {
        case TOKEN_DATE:
          state = 20;
          statement();
          break;
        case TOKEN_T__0:
          state = 21;
          comment();
          break;
        case TOKEN_NEWLINE:
          state = 22;
          empty_line();
          break;
        default:
          throw NoViableAltException(this);
        }
        state = 25; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while ((((_la) & ~0x3f) == 0 && ((BigInt.one << _la) & ((BigInt.one << TOKEN_T__0) | (BigInt.one << TOKEN_DATE) | (BigInt.one << TOKEN_NEWLINE))) != BigInt.zero));
      state = 27;
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
      int _alt;
      enterOuterAlt(_localctx, 1);
      state = 30; 
      errorHandler.sync(this);
      _alt = 1;
      do {
        switch (_alt) {
        case 1:
          state = 29;
          match(TOKEN_T__0);
          break;
        default:
          throw NoViableAltException(this);
        }
        state = 32; 
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 2, context);
      } while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER);
      state = 35; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 34;
        _la = tokenStream.LA(1)!;
        if (_la <= 0 || (_la == TOKEN_NEWLINE)) {
        errorHandler.recoverInline(this);
        } else {
          if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
          errorHandler.reportMatch(this);
          consume();
        }
        state = 37; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while ((((_la) & ~0x3f) == 0 && ((BigInt.one << _la) & ((BigInt.one << TOKEN_T__0) | (BigInt.one << TOKEN_T__1) | (BigInt.one << TOKEN_T__2) | (BigInt.one << TOKEN_T__3) | (BigInt.one << TOKEN_T__4) | (BigInt.one << TOKEN_DATE) | (BigInt.one << TOKEN_NUMBER) | (BigInt.one << TOKEN_WORD) | (BigInt.one << TOKEN_WHITESPACE) | (BigInt.one << TOKEN_STRING))) != BigInt.zero));
      state = 39;
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
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 44; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 44;
        errorHandler.sync(this);
        switch (interpreter!.adaptivePredict(tokenStream, 4, context)) {
        case 1:
          state = 41;
          balanceStatement();
          break;
        case 2:
          state = 42;
          closeStatement();
          break;
        case 3:
          state = 43;
          openStatement();
          break;
        }
        state = 46; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while (_la == TOKEN_DATE);
      state = 48;
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
      int _alt;
      enterOuterAlt(_localctx, 1);
      state = 51; 
      errorHandler.sync(this);
      _alt = 1;
      do {
        switch (_alt) {
        case 1:
          state = 50;
          match(TOKEN_WORD);
          break;
        default:
          throw NoViableAltException(this);
        }
        state = 53; 
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 6, context);
      } while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER);
      state = 63;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_T__1) {
        state = 56; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        do {
          state = 55;
          match(TOKEN_T__1);
          state = 58; 
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
        } while (_la == TOKEN_T__1);
        state = 60;
        match(TOKEN_WORD);
        state = 65;
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

  CurrencyContext currency() {
    dynamic _localctx = CurrencyContext(context, state);
    enterRule(_localctx, 8, RULE_currency);
    try {
      enterOuterAlt(_localctx, 1);
      state = 66;
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
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 69; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 68;
        match(TOKEN_NUMBER);
        state = 71; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while (_la == TOKEN_NUMBER);
      state = 73;
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
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 76; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 75;
        match(TOKEN_DATE);
        state = 78; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while (_la == TOKEN_DATE);
      state = 81; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 80;
        match(TOKEN_T__2);
        state = 83; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while (_la == TOKEN_T__2);
      state = 86; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 85;
        account();
        state = 88; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while (_la == TOKEN_WORD);
      state = 90;
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
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 93; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 92;
        match(TOKEN_DATE);
        state = 95; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while (_la == TOKEN_DATE);
      state = 98; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 97;
        match(TOKEN_T__3);
        state = 100; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while (_la == TOKEN_T__3);
      state = 102;
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
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 105; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 104;
        match(TOKEN_DATE);
        state = 107; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while (_la == TOKEN_DATE);
      state = 110; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 109;
        match(TOKEN_T__4);
        state = 112; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while (_la == TOKEN_T__4);
      state = 114;
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

  Empty_lineContext empty_line() {
    dynamic _localctx = Empty_lineContext(context, state);
    enterRule(_localctx, 18, RULE_empty_line);
    try {
      enterOuterAlt(_localctx, 1);
      state = 116;
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

  static const List<int> _serializedATN = [
      4,1,11,119,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,6,
      2,7,7,7,2,8,7,8,2,9,7,9,1,0,1,0,1,0,4,0,24,8,0,11,0,12,0,25,1,0,1,
      0,1,1,4,1,31,8,1,11,1,12,1,32,1,1,4,1,36,8,1,11,1,12,1,37,1,1,1,1,
      1,2,1,2,1,2,4,2,45,8,2,11,2,12,2,46,1,2,1,2,1,3,4,3,52,8,3,11,3,12,
      3,53,1,3,4,3,57,8,3,11,3,12,3,58,1,3,5,3,62,8,3,10,3,12,3,65,9,3,1,
      4,1,4,1,5,4,5,70,8,5,11,5,12,5,71,1,5,1,5,1,6,4,6,77,8,6,11,6,12,6,
      78,1,6,4,6,82,8,6,11,6,12,6,83,1,6,4,6,87,8,6,11,6,12,6,88,1,6,1,6,
      1,7,4,7,94,8,7,11,7,12,7,95,1,7,4,7,99,8,7,11,7,12,7,100,1,7,1,7,1,
      8,4,8,106,8,8,11,8,12,8,107,1,8,4,8,111,8,8,11,8,12,8,112,1,8,1,8,
      1,9,1,9,1,9,0,0,10,0,2,4,6,8,10,12,14,16,18,0,1,1,0,10,10,127,0,23,
      1,0,0,0,2,30,1,0,0,0,4,44,1,0,0,0,6,51,1,0,0,0,8,66,1,0,0,0,10,69,
      1,0,0,0,12,76,1,0,0,0,14,93,1,0,0,0,16,105,1,0,0,0,18,116,1,0,0,0,
      20,24,3,4,2,0,21,24,3,2,1,0,22,24,3,18,9,0,23,20,1,0,0,0,23,21,1,0,
      0,0,23,22,1,0,0,0,24,25,1,0,0,0,25,23,1,0,0,0,25,26,1,0,0,0,26,27,
      1,0,0,0,27,28,5,0,0,1,28,1,1,0,0,0,29,31,5,1,0,0,30,29,1,0,0,0,31,
      32,1,0,0,0,32,30,1,0,0,0,32,33,1,0,0,0,33,35,1,0,0,0,34,36,8,0,0,0,
      35,34,1,0,0,0,36,37,1,0,0,0,37,35,1,0,0,0,37,38,1,0,0,0,38,39,1,0,
      0,0,39,40,5,10,0,0,40,3,1,0,0,0,41,45,3,12,6,0,42,45,3,14,7,0,43,45,
      3,16,8,0,44,41,1,0,0,0,44,42,1,0,0,0,44,43,1,0,0,0,45,46,1,0,0,0,46,
      44,1,0,0,0,46,47,1,0,0,0,47,48,1,0,0,0,48,49,5,10,0,0,49,5,1,0,0,0,
      50,52,5,8,0,0,51,50,1,0,0,0,52,53,1,0,0,0,53,51,1,0,0,0,53,54,1,0,
      0,0,54,63,1,0,0,0,55,57,5,2,0,0,56,55,1,0,0,0,57,58,1,0,0,0,58,56,
      1,0,0,0,58,59,1,0,0,0,59,60,1,0,0,0,60,62,5,8,0,0,61,56,1,0,0,0,62,
      65,1,0,0,0,63,61,1,0,0,0,63,64,1,0,0,0,64,7,1,0,0,0,65,63,1,0,0,0,
      66,67,5,8,0,0,67,9,1,0,0,0,68,70,5,7,0,0,69,68,1,0,0,0,70,71,1,0,0,
      0,71,69,1,0,0,0,71,72,1,0,0,0,72,73,1,0,0,0,73,74,3,8,4,0,74,11,1,
      0,0,0,75,77,5,6,0,0,76,75,1,0,0,0,77,78,1,0,0,0,78,76,1,0,0,0,78,79,
      1,0,0,0,79,81,1,0,0,0,80,82,5,3,0,0,81,80,1,0,0,0,82,83,1,0,0,0,83,
      81,1,0,0,0,83,84,1,0,0,0,84,86,1,0,0,0,85,87,3,6,3,0,86,85,1,0,0,0,
      87,88,1,0,0,0,88,86,1,0,0,0,88,89,1,0,0,0,89,90,1,0,0,0,90,91,3,10,
      5,0,91,13,1,0,0,0,92,94,5,6,0,0,93,92,1,0,0,0,94,95,1,0,0,0,95,93,
      1,0,0,0,95,96,1,0,0,0,96,98,1,0,0,0,97,99,5,4,0,0,98,97,1,0,0,0,99,
      100,1,0,0,0,100,98,1,0,0,0,100,101,1,0,0,0,101,102,1,0,0,0,102,103,
      3,6,3,0,103,15,1,0,0,0,104,106,5,6,0,0,105,104,1,0,0,0,106,107,1,0,
      0,0,107,105,1,0,0,0,107,108,1,0,0,0,108,110,1,0,0,0,109,111,5,5,0,
      0,110,109,1,0,0,0,111,112,1,0,0,0,112,110,1,0,0,0,112,113,1,0,0,0,
      113,114,1,0,0,0,114,115,3,6,3,0,115,17,1,0,0,0,116,117,5,10,0,0,117,
      19,1,0,0,0,17,23,25,32,37,44,46,53,58,63,71,78,83,88,95,100,107,112
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
  List<BalanceStatementContext> balanceStatements() => getRuleContexts<BalanceStatementContext>();
  BalanceStatementContext? balanceStatement(int i) => getRuleContext<BalanceStatementContext>(i);
  List<CloseStatementContext> closeStatements() => getRuleContexts<CloseStatementContext>();
  CloseStatementContext? closeStatement(int i) => getRuleContext<CloseStatementContext>(i);
  List<OpenStatementContext> openStatements() => getRuleContexts<OpenStatementContext>();
  OpenStatementContext? openStatement(int i) => getRuleContext<OpenStatementContext>(i);
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
  CurrencyContext? currency() => getRuleContext<CurrencyContext>(0);
  List<TerminalNode> NUMBERs() => getTokens(GringottsParser.TOKEN_NUMBER);
  TerminalNode? NUMBER(int i) => getToken(GringottsParser.TOKEN_NUMBER, i);
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
  AmountContext? amount() => getRuleContext<AmountContext>(0);
  List<TerminalNode> DATEs() => getTokens(GringottsParser.TOKEN_DATE);
  TerminalNode? DATE(int i) => getToken(GringottsParser.TOKEN_DATE, i);
  List<AccountContext> accounts() => getRuleContexts<AccountContext>();
  AccountContext? account(int i) => getRuleContext<AccountContext>(i);
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
  AccountContext? account() => getRuleContext<AccountContext>(0);
  List<TerminalNode> DATEs() => getTokens(GringottsParser.TOKEN_DATE);
  TerminalNode? DATE(int i) => getToken(GringottsParser.TOKEN_DATE, i);
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
  AccountContext? account() => getRuleContext<AccountContext>(0);
  List<TerminalNode> DATEs() => getTokens(GringottsParser.TOKEN_DATE);
  TerminalNode? DATE(int i) => getToken(GringottsParser.TOKEN_DATE, i);
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

