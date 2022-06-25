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
    TOKEN_DATE = 6, TOKEN_NUMBER = 7, TOKEN_WORD = 8, TOKEN_WHITESPACE = 9, 
    TOKEN_NEWLINE = 10, TOKEN_STRING = 11;
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
    'T__0', 'T__1', 'T__2', 'T__3', 'T__4', 'DIGIT', 'YEAR', 'MONTH', 'DAY', 
    'DATE', 'NUMBER', 'WORD', 'WHITESPACE', 'NEWLINE', 'STRING'
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
      4,0,11,113,6,-1,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,
      6,7,6,2,7,7,7,2,8,7,8,2,9,7,9,2,10,7,10,2,11,7,11,2,12,7,12,2,13,7,
      13,2,14,7,14,1,0,1,0,1,1,1,1,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,3,1,
      3,1,3,1,3,1,3,1,3,1,4,1,4,1,4,1,4,1,4,1,5,1,5,1,6,1,6,1,6,1,6,1,6,
      1,7,1,7,1,7,1,8,1,8,1,8,1,9,1,9,1,9,1,9,1,9,1,9,1,10,4,10,75,8,10,
      11,10,12,10,76,1,10,1,10,4,10,81,8,10,11,10,12,10,82,3,10,85,8,10,
      1,11,4,11,88,8,11,11,11,12,11,89,1,12,1,12,1,12,1,12,1,13,3,13,97,
      8,13,1,13,1,13,4,13,101,8,13,11,13,12,13,102,1,14,1,14,5,14,107,8,
      14,10,14,12,14,110,9,14,1,14,1,14,0,0,15,1,1,3,2,5,3,7,4,9,5,11,0,
      13,0,15,0,17,0,19,6,21,7,23,8,25,9,27,10,29,11,1,0,7,1,0,48,57,1,0,
      45,45,1,0,46,46,3,0,48,57,65,90,97,122,2,0,9,9,32,32,1,0,34,34,2,0,
      34,34,94,94,116,0,1,1,0,0,0,0,3,1,0,0,0,0,5,1,0,0,0,0,7,1,0,0,0,0,
      9,1,0,0,0,0,19,1,0,0,0,0,21,1,0,0,0,0,23,1,0,0,0,0,25,1,0,0,0,0,27,
      1,0,0,0,0,29,1,0,0,0,1,31,1,0,0,0,3,33,1,0,0,0,5,35,1,0,0,0,7,43,1,
      0,0,0,9,49,1,0,0,0,11,54,1,0,0,0,13,56,1,0,0,0,15,61,1,0,0,0,17,64,
      1,0,0,0,19,67,1,0,0,0,21,74,1,0,0,0,23,87,1,0,0,0,25,91,1,0,0,0,27,
      100,1,0,0,0,29,104,1,0,0,0,31,32,5,35,0,0,32,2,1,0,0,0,33,34,5,58,
      0,0,34,4,1,0,0,0,35,36,5,98,0,0,36,37,5,97,0,0,37,38,5,108,0,0,38,
      39,5,97,0,0,39,40,5,110,0,0,40,41,5,99,0,0,41,42,5,101,0,0,42,6,1,
      0,0,0,43,44,5,99,0,0,44,45,5,108,0,0,45,46,5,111,0,0,46,47,5,115,0,
      0,47,48,5,101,0,0,48,8,1,0,0,0,49,50,5,111,0,0,50,51,5,112,0,0,51,
      52,5,101,0,0,52,53,5,110,0,0,53,10,1,0,0,0,54,55,7,0,0,0,55,12,1,0,
      0,0,56,57,3,11,5,0,57,58,3,11,5,0,58,59,3,11,5,0,59,60,3,11,5,0,60,
      14,1,0,0,0,61,62,3,11,5,0,62,63,3,11,5,0,63,16,1,0,0,0,64,65,3,11,
      5,0,65,66,3,11,5,0,66,18,1,0,0,0,67,68,3,13,6,0,68,69,7,1,0,0,69,70,
      3,15,7,0,70,71,7,1,0,0,71,72,3,17,8,0,72,20,1,0,0,0,73,75,3,11,5,0,
      74,73,1,0,0,0,75,76,1,0,0,0,76,74,1,0,0,0,76,77,1,0,0,0,77,84,1,0,
      0,0,78,80,7,2,0,0,79,81,3,11,5,0,80,79,1,0,0,0,81,82,1,0,0,0,82,80,
      1,0,0,0,82,83,1,0,0,0,83,85,1,0,0,0,84,78,1,0,0,0,84,85,1,0,0,0,85,
      22,1,0,0,0,86,88,7,3,0,0,87,86,1,0,0,0,88,89,1,0,0,0,89,87,1,0,0,0,
      89,90,1,0,0,0,90,24,1,0,0,0,91,92,7,4,0,0,92,93,1,0,0,0,93,94,6,12,
      0,0,94,26,1,0,0,0,95,97,5,13,0,0,96,95,1,0,0,0,96,97,1,0,0,0,97,98,
      1,0,0,0,98,101,5,10,0,0,99,101,5,13,0,0,100,96,1,0,0,0,100,99,1,0,
      0,0,101,102,1,0,0,0,102,100,1,0,0,0,102,103,1,0,0,0,103,28,1,0,0,0,
      104,108,7,5,0,0,105,107,7,6,0,0,106,105,1,0,0,0,107,110,1,0,0,0,108,
      106,1,0,0,0,108,109,1,0,0,0,109,111,1,0,0,0,110,108,1,0,0,0,111,112,
      7,5,0,0,112,30,1,0,0,0,9,0,76,82,84,89,96,100,102,108,1,6,0,0
  ];

  static final ATN _ATN =
      ATNDeserializer().deserialize(_serializedATN);
}