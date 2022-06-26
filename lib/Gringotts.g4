grammar Gringotts;

/*
 * Parser Rules
 */

all: (statement | empty_line)* EOF;

statement:
	directive
	| includeStatement
	| optionStatement
	| commentStatement;

directive: (
		balanceStatement
		| closeStatement
		| openStatement
		| commodityStatement
		| priceStatement
		| eventStatement
		| documentStatement
		| noteStatement
		| trStatement
	) NEWLINE;

account: WORD (':' WORD)+;
currency: WORD;

amount: NUMBER currency;

includeStatement: 'include' quoted_string;
optionStatement:
	'option' key = quoted_string value = quoted_string;
commentStatement: ('#' | ';') (~NEWLINE)* NEWLINE;

balanceStatement: date 'balance' account amount;
closeStatement: date 'close' account;
openStatement: date 'open' account;
commodityStatement: date 'commodity' currency;
priceStatement: date 'price' currency amount;
eventStatement:
	date 'event' name = quoted_string value = quoted_string;
documentStatement: date 'document' account quoted_string;
noteStatement: date 'note' account quoted_string;

empty_line: NEWLINE;

trStatement:
	tr_header NEWLINE (tr_comment NEWLINE)* (
		(posting_spec_account_only | posting_spec_account_amount) NEWLINE
	)+;
tr_header:
	date TR_FLAG narration = quoted_string payee = quoted_string? tags?;

inline_comment: ';' (~NEWLINE)*;

tr_comment: inline_comment;
posting_spec_account_only: account tags? inline_comment?;
posting_spec_account_amount:
	account amount tags? inline_comment?;

date: DATE;
// quoted_string: '"' (.)? '"';
quoted_string: STR;
tags: TAG+;

/*
 * Lexer Rules
 */
DIGIT: [0-9];
YEAR: DIGIT DIGIT DIGIT DIGIT;
MONTH: DIGIT DIGIT;
DAY: DIGIT DIGIT;
DATE: YEAR [-] MONTH [-] DAY;

NUMBER: [-]? DIGIT+ ([.] DIGIT+)?;

TAG: [#]WORD;
WORD: [A-Za-z0-9\\-]+;
WHITESPACE: (' ' | '\t')+ -> skip;
NEWLINE: ('\r'? '\n' | '\r')+;
// NOT_NEWLINE: ~('\r' | '\n' | '\r\n');

TR_FLAG: '!' | '*';
STR: '"' (~[\\"] | '\\' [\\"()])* '"';
