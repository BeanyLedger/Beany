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
      state = 25;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while ((((_la) & ~0x3f) == 0 && ((BigInt.one << _la) & ((BigInt.one << TOKEN_T__0) | (BigInt.one << TOKEN_DATE) | (BigInt.one << TOKEN_NEWLINE))) != BigInt.zero)) {
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
        state = 27;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 28;
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
      state = 30;
      match(TOKEN_T__0);
      state = 31;
      _la = tokenStream.LA(1)!;
      if (_la <= 0 || (_la == TOKEN_NEWLINE)) {
      errorHandler.recoverInline(this);
      } else {
        if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
      state = 32;
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
      state = 37;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 2, context)) {
      case 1:
        state = 34;
        balanceStatement();
        break;
      case 2:
        state = 35;
        closeStatement();
        break;
      case 3:
        state = 36;
        openStatement();
        break;
      }
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

  AccountContext account() {
    dynamic _localctx = AccountContext(context, state);
    enterRule(_localctx, 6, RULE_account);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 41;
      match(TOKEN_WORD);

      state = 43; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 42;
        match(TOKEN_T__1);
        state = 45; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while (_la == TOKEN_T__1);
      state = 47;
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
      state = 49;
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
      state = 51;
      match(TOKEN_NUMBER);
      state = 52;
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
      state = 54;
      match(TOKEN_DATE);
      state = 55;
      match(TOKEN_T__2);
      state = 56;
      account();
      state = 57;
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
      state = 59;
      match(TOKEN_DATE);
      state = 60;
      match(TOKEN_T__3);
      state = 61;
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
      state = 63;
      match(TOKEN_DATE);
      state = 64;
      match(TOKEN_T__4);
      state = 65;
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
      state = 67;
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
      4,1,11,70,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,6,
      2,7,7,7,2,8,7,8,2,9,7,9,1,0,1,0,1,0,5,0,24,8,0,10,0,12,0,27,9,0,1,
      0,1,0,1,1,1,1,1,1,1,1,1,2,1,2,1,2,3,2,38,8,2,1,2,1,2,1,3,1,3,4,3,44,
      8,3,11,3,12,3,45,1,3,1,3,1,4,1,4,1,5,1,5,1,5,1,6,1,6,1,6,1,6,1,6,1,
      7,1,7,1,7,1,7,1,8,1,8,1,8,1,8,1,9,1,9,1,9,0,0,10,0,2,4,6,8,10,12,14,
      16,18,0,1,1,0,10,10,65,0,25,1,0,0,0,2,30,1,0,0,0,4,37,1,0,0,0,6,41,
      1,0,0,0,8,49,1,0,0,0,10,51,1,0,0,0,12,54,1,0,0,0,14,59,1,0,0,0,16,
      63,1,0,0,0,18,67,1,0,0,0,20,24,3,4,2,0,21,24,3,2,1,0,22,24,3,18,9,
      0,23,20,1,0,0,0,23,21,1,0,0,0,23,22,1,0,0,0,24,27,1,0,0,0,25,23,1,
      0,0,0,25,26,1,0,0,0,26,28,1,0,0,0,27,25,1,0,0,0,28,29,5,0,0,1,29,1,
      1,0,0,0,30,31,5,1,0,0,31,32,8,0,0,0,32,33,5,10,0,0,33,3,1,0,0,0,34,
      38,3,12,6,0,35,38,3,14,7,0,36,38,3,16,8,0,37,34,1,0,0,0,37,35,1,0,
      0,0,37,36,1,0,0,0,38,39,1,0,0,0,39,40,5,10,0,0,40,5,1,0,0,0,41,43,
      5,8,0,0,42,44,5,2,0,0,43,42,1,0,0,0,44,45,1,0,0,0,45,43,1,0,0,0,45,
      46,1,0,0,0,46,47,1,0,0,0,47,48,5,8,0,0,48,7,1,0,0,0,49,50,5,8,0,0,
      50,9,1,0,0,0,51,52,5,7,0,0,52,53,3,8,4,0,53,11,1,0,0,0,54,55,5,6,0,
      0,55,56,5,3,0,0,56,57,3,6,3,0,57,58,3,10,5,0,58,13,1,0,0,0,59,60,5,
      6,0,0,60,61,5,4,0,0,61,62,3,6,3,0,62,15,1,0,0,0,63,64,5,6,0,0,64,65,
      5,5,0,0,65,66,3,6,3,0,66,17,1,0,0,0,67,68,5,10,0,0,68,19,1,0,0,0,4,
      23,25,37,45
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
  TerminalNode? DATE() => getToken(GringottsParser.TOKEN_DATE, 0);
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
  TerminalNode? DATE() => getToken(GringottsParser.TOKEN_DATE, 0);
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
  TerminalNode? DATE() => getToken(GringottsParser.TOKEN_DATE, 0);
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

