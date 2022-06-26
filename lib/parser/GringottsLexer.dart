// Generated from Gringotts.g4 by ANTLR 4.10.1
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes
import 'package:antlr4/antlr4.dart';


class GringottsLexer extends Lexer {
  static final checkVersion = () => RuntimeMetaData.checkVersion('4.10.1', RuntimeMetaData.VERSION);

  static final List<DFA> _decisionToDFA = List.generate(
        _ATN.numberOfDecisions, (i) => DFA(_ATN.getDecisionState(i), i));
  static final PredictionContextCache _sharedContextCache = PredictionContextCache();
  static const int
    TOKEN_T__0 = 1, TOKEN_T__1 = 2, TOKEN_T__2 = 3, TOKEN_T__3 = 4, TOKEN_T__4 = 5, 
    TOKEN_T__5 = 6, TOKEN_T__6 = 7, TOKEN_T__7 = 8, TOKEN_T__8 = 9, TOKEN_T__9 = 10, 
    TOKEN_T__10 = 11, TOKEN_T__11 = 12, TOKEN_T__12 = 13, TOKEN_DIGIT = 14, 
    TOKEN_YEAR = 15, TOKEN_MONTH = 16, TOKEN_DAY = 17, TOKEN_DATE = 18, 
    TOKEN_NUMBER = 19, TOKEN_TAG = 20, TOKEN_WORD = 21, TOKEN_WHITESPACE = 22, 
    TOKEN_NEWLINE = 23, TOKEN_TR_FLAG = 24, TOKEN_INDENT = 25, TOKEN_STR = 26;
  @override
  final List<String> channelNames = [
    'DEFAULT_TOKEN_CHANNEL', 'HIDDEN'
  ];

  @override
  final List<String> modeNames = [
    'DEFAULT_MODE'
  ];

  @override
  final List<String> ruleNames = [
    'T__0', 'T__1', 'T__2', 'T__3', 'T__4', 'T__5', 'T__6', 'T__7', 'T__8', 
    'T__9', 'T__10', 'T__11', 'T__12', 'DIGIT', 'YEAR', 'MONTH', 'DAY', 
    'DATE', 'NUMBER', 'TAG', 'WORD', 'WHITESPACE', 'NEWLINE', 'TR_FLAG', 
    'INDENT', 'STR'
  ];

  static final List<String?> _LITERAL_NAMES = [
      null, "':'", "'include'", "'option'", "'#'", "';'", "'balance'", "'close'", 
      "'open'", "'commodity'", "'price'", "'event'", "'document'", "'note'"
  ];
  static final List<String?> _SYMBOLIC_NAMES = [
      null, null, null, null, null, null, null, null, null, null, null, 
      null, null, null, "DIGIT", "YEAR", "MONTH", "DAY", "DATE", "NUMBER", 
      "TAG", "WORD", "WHITESPACE", "NEWLINE", "TR_FLAG", "INDENT", "STR"
  ];
  static final Vocabulary VOCABULARY = VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

  @override
  Vocabulary get vocabulary {
    return VOCABULARY;
  }


  GringottsLexer(CharStream input) : super(input) {
    interpreter = LexerATNSimulator(_ATN, _decisionToDFA, _sharedContextCache, recog: this);
  }

  @override
  List<int> get serializedATN => _serializedATN;

  @override
  String get grammarFileName => 'Gringotts.g4';

  @override
  ATN getATN() { return _ATN; }

  static const List<int> _serializedATN = [
      4,0,26,200,6,-1,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,
      6,7,6,2,7,7,7,2,8,7,8,2,9,7,9,2,10,7,10,2,11,7,11,2,12,7,12,2,13,7,
      13,2,14,7,14,2,15,7,15,2,16,7,16,2,17,7,17,2,18,7,18,2,19,7,19,2,20,
      7,20,2,21,7,21,2,22,7,22,2,23,7,23,2,24,7,24,2,25,7,25,1,0,1,0,1,1,
      1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,3,1,3,1,
      4,1,4,1,5,1,5,1,5,1,5,1,5,1,5,1,5,1,5,1,6,1,6,1,6,1,6,1,6,1,6,1,7,
      1,7,1,7,1,7,1,7,1,8,1,8,1,8,1,8,1,8,1,8,1,8,1,8,1,8,1,8,1,9,1,9,1,
      9,1,9,1,9,1,9,1,10,1,10,1,10,1,10,1,10,1,10,1,11,1,11,1,11,1,11,1,
      11,1,11,1,11,1,11,1,11,1,12,1,12,1,12,1,12,1,12,1,13,1,13,1,14,1,14,
      1,14,1,14,1,14,1,15,1,15,1,15,1,16,1,16,1,16,1,17,1,17,1,17,1,17,1,
      17,1,17,1,18,4,18,150,8,18,11,18,12,18,151,1,18,1,18,4,18,156,8,18,
      11,18,12,18,157,3,18,160,8,18,1,19,1,19,1,19,1,20,4,20,166,8,20,11,
      20,12,20,167,1,21,1,21,1,21,1,21,1,22,3,22,175,8,22,1,22,1,22,4,22,
      179,8,22,11,22,12,22,180,1,23,1,23,1,24,4,24,186,8,24,11,24,12,24,
      187,1,25,1,25,1,25,1,25,5,25,194,8,25,10,25,12,25,197,9,25,1,25,1,
      25,0,0,26,1,1,3,2,5,3,7,4,9,5,11,6,13,7,15,8,17,9,19,10,21,11,23,12,
      25,13,27,14,29,15,31,16,33,17,35,18,37,19,39,20,41,21,43,22,45,23,
      47,24,49,25,51,26,1,0,9,1,0,48,57,1,0,45,45,1,0,46,46,1,0,35,35,5,
      0,45,45,48,57,65,90,92,92,97,122,2,0,9,9,32,32,2,0,33,33,42,42,2,0,
      34,34,92,92,3,0,34,34,40,41,92,92,209,0,1,1,0,0,0,0,3,1,0,0,0,0,5,
      1,0,0,0,0,7,1,0,0,0,0,9,1,0,0,0,0,11,1,0,0,0,0,13,1,0,0,0,0,15,1,0,
      0,0,0,17,1,0,0,0,0,19,1,0,0,0,0,21,1,0,0,0,0,23,1,0,0,0,0,25,1,0,0,
      0,0,27,1,0,0,0,0,29,1,0,0,0,0,31,1,0,0,0,0,33,1,0,0,0,0,35,1,0,0,0,
      0,37,1,0,0,0,0,39,1,0,0,0,0,41,1,0,0,0,0,43,1,0,0,0,0,45,1,0,0,0,0,
      47,1,0,0,0,0,49,1,0,0,0,0,51,1,0,0,0,1,53,1,0,0,0,3,55,1,0,0,0,5,63,
      1,0,0,0,7,70,1,0,0,0,9,72,1,0,0,0,11,74,1,0,0,0,13,82,1,0,0,0,15,88,
      1,0,0,0,17,93,1,0,0,0,19,103,1,0,0,0,21,109,1,0,0,0,23,115,1,0,0,0,
      25,124,1,0,0,0,27,129,1,0,0,0,29,131,1,0,0,0,31,136,1,0,0,0,33,139,
      1,0,0,0,35,142,1,0,0,0,37,149,1,0,0,0,39,161,1,0,0,0,41,165,1,0,0,
      0,43,169,1,0,0,0,45,178,1,0,0,0,47,182,1,0,0,0,49,185,1,0,0,0,51,189,
      1,0,0,0,53,54,5,58,0,0,54,2,1,0,0,0,55,56,5,105,0,0,56,57,5,110,0,
      0,57,58,5,99,0,0,58,59,5,108,0,0,59,60,5,117,0,0,60,61,5,100,0,0,61,
      62,5,101,0,0,62,4,1,0,0,0,63,64,5,111,0,0,64,65,5,112,0,0,65,66,5,
      116,0,0,66,67,5,105,0,0,67,68,5,111,0,0,68,69,5,110,0,0,69,6,1,0,0,
      0,70,71,5,35,0,0,71,8,1,0,0,0,72,73,5,59,0,0,73,10,1,0,0,0,74,75,5,
      98,0,0,75,76,5,97,0,0,76,77,5,108,0,0,77,78,5,97,0,0,78,79,5,110,0,
      0,79,80,5,99,0,0,80,81,5,101,0,0,81,12,1,0,0,0,82,83,5,99,0,0,83,84,
      5,108,0,0,84,85,5,111,0,0,85,86,5,115,0,0,86,87,5,101,0,0,87,14,1,
      0,0,0,88,89,5,111,0,0,89,90,5,112,0,0,90,91,5,101,0,0,91,92,5,110,
      0,0,92,16,1,0,0,0,93,94,5,99,0,0,94,95,5,111,0,0,95,96,5,109,0,0,96,
      97,5,109,0,0,97,98,5,111,0,0,98,99,5,100,0,0,99,100,5,105,0,0,100,
      101,5,116,0,0,101,102,5,121,0,0,102,18,1,0,0,0,103,104,5,112,0,0,104,
      105,5,114,0,0,105,106,5,105,0,0,106,107,5,99,0,0,107,108,5,101,0,0,
      108,20,1,0,0,0,109,110,5,101,0,0,110,111,5,118,0,0,111,112,5,101,0,
      0,112,113,5,110,0,0,113,114,5,116,0,0,114,22,1,0,0,0,115,116,5,100,
      0,0,116,117,5,111,0,0,117,118,5,99,0,0,118,119,5,117,0,0,119,120,5,
      109,0,0,120,121,5,101,0,0,121,122,5,110,0,0,122,123,5,116,0,0,123,
      24,1,0,0,0,124,125,5,110,0,0,125,126,5,111,0,0,126,127,5,116,0,0,127,
      128,5,101,0,0,128,26,1,0,0,0,129,130,7,0,0,0,130,28,1,0,0,0,131,132,
      3,27,13,0,132,133,3,27,13,0,133,134,3,27,13,0,134,135,3,27,13,0,135,
      30,1,0,0,0,136,137,3,27,13,0,137,138,3,27,13,0,138,32,1,0,0,0,139,
      140,3,27,13,0,140,141,3,27,13,0,141,34,1,0,0,0,142,143,3,29,14,0,143,
      144,7,1,0,0,144,145,3,31,15,0,145,146,7,1,0,0,146,147,3,33,16,0,147,
      36,1,0,0,0,148,150,3,27,13,0,149,148,1,0,0,0,150,151,1,0,0,0,151,149,
      1,0,0,0,151,152,1,0,0,0,152,159,1,0,0,0,153,155,7,2,0,0,154,156,3,
      27,13,0,155,154,1,0,0,0,156,157,1,0,0,0,157,155,1,0,0,0,157,158,1,
      0,0,0,158,160,1,0,0,0,159,153,1,0,0,0,159,160,1,0,0,0,160,38,1,0,0,
      0,161,162,7,3,0,0,162,163,3,41,20,0,163,40,1,0,0,0,164,166,7,4,0,0,
      165,164,1,0,0,0,166,167,1,0,0,0,167,165,1,0,0,0,167,168,1,0,0,0,168,
      42,1,0,0,0,169,170,7,5,0,0,170,171,1,0,0,0,171,172,6,21,0,0,172,44,
      1,0,0,0,173,175,5,13,0,0,174,173,1,0,0,0,174,175,1,0,0,0,175,176,1,
      0,0,0,176,179,5,10,0,0,177,179,5,13,0,0,178,174,1,0,0,0,178,177,1,
      0,0,0,179,180,1,0,0,0,180,178,1,0,0,0,180,181,1,0,0,0,181,46,1,0,0,
      0,182,183,7,6,0,0,183,48,1,0,0,0,184,186,3,43,21,0,185,184,1,0,0,0,
      186,187,1,0,0,0,187,185,1,0,0,0,187,188,1,0,0,0,188,50,1,0,0,0,189,
      195,5,34,0,0,190,194,8,7,0,0,191,192,5,92,0,0,192,194,7,8,0,0,193,
      190,1,0,0,0,193,191,1,0,0,0,194,197,1,0,0,0,195,193,1,0,0,0,195,196,
      1,0,0,0,196,198,1,0,0,0,197,195,1,0,0,0,198,199,5,34,0,0,199,52,1,
      0,0,0,11,0,151,157,159,167,174,178,180,187,193,195,1,6,0,0
  ];

  static final ATN _ATN =
      ATNDeserializer().deserialize(_serializedATN);
}