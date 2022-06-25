grammar Gringotts;

/*
 * Parser Rules
 */

all: (statement | comment | empty_line)* EOF;
comment: '#' ~NEWLINE NEWLINE;

statement: (balanceStatement | closeStatement | openStatement) NEWLINE;

account: WORD (':'+ WORD);
currency: WORD;

amount: NUMBER currency;

balanceStatement: DATE 'balance' account amount;
closeStatement: DATE 'close' account;
openStatement: DATE 'open' account;

empty_line: NEWLINE;

/*
 * Lexer Rules
 */

fragment DIGIT: [0-9];
fragment YEAR: DIGIT DIGIT DIGIT DIGIT;
fragment MONTH: DIGIT DIGIT;
fragment DAY: DIGIT DIGIT;
DATE: YEAR [\-] MONTH [\-] DAY;

NUMBER: DIGIT+ ([.] DIGIT+)?;

WORD: [A-Za-z0-9]+;
WHITESPACE: (' ' | '\t') -> skip;
NEWLINE: ('\r'? '\n' | '\r')+;

STRING: ["][^"]* ["];
