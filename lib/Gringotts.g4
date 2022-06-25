grammar Gringotts;

/*
 * Parser Rules
 */

account: WORD+ (':'+ WORD)*;
currency: WORD;

amount: NUMBER+ WHITESPACE+ currency;

date: YEAR+ '-'+ MONTH+ '-'+ DAY;

balanceStatement:
	date+ WHITESPACE+ 'balance'+ WHITESPACE+ account+ WHITESPACE+ amount;
closeStatement: date+ WHITESPACE+ 'close'+ WHITESPACE+ account;
openStatement: date+ WHITESPACE+ 'open'+ WHITESPACE+ account;

statement: balanceStatement | closeStatement | openStatement;

/*
 * Lexer Rules
 */

YEAR: [0-9][0-9][0-9][0-9];
MONTH: [0-9][0-9];
DAY: [0-9][0-9];

NUMBER: [0-9]+ ([.][0-9]+)?;
WORD: [A-Za-z0-9]+;
WHITESPACE: (' ' | '\t');
