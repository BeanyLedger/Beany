grammar Gringotts;

/*
 * Parser Rules
 */

all: (statement | comment | empty_line)* EOF;
comment: ('#' | ';') ~NEWLINE NEWLINE;

statement: (
		balanceStatement
		| closeStatement
		| openStatement
		| commodityStatement
		| priceStatement
		| eventStatement
		| documentStatement
		| noteStatement
		| tr_statement
	) NEWLINE;

account: WORD (':'+ WORD);
currency: WORD;

amount: NUMBER currency;

balanceStatement: date 'balance' account amount;
closeStatement: date 'close' account;
openStatement: date 'open' account;
commodityStatement: date 'commodity' currency;
priceStatement: date 'price' currency amount;
eventStatement: date 'event' name = STRING value = STRING;
documentStatement: date 'document' account STRING;
noteStatement: date 'document' account STRING;

empty_line: NEWLINE;

tr_statement:
	tr_header NEWLINE (
		(
			posting_spec_account_only
			| posting_spec_account_amount
			| inline_comment
		) NEWLINE
	)+;
tr_header: date TR_FLAG narration = STRING payee = STRING?;
tr_comment: INDENT inline_comment;

inline_comment: ';' ~NEWLINE*;
posting_spec_account_only: INDENT account TAG+ inline_comment?;
posting_spec_account_amount:
	INDENT account amount TAG+ inline_comment?;

date: DATE;

/*
 * Lexer Rules
 */
DIGIT: [0-9];
YEAR: DIGIT DIGIT DIGIT DIGIT;
MONTH: DIGIT DIGIT;
DAY: DIGIT DIGIT;
DATE: YEAR [-] MONTH [-] DAY;

NUMBER: DIGIT+ ([.] DIGIT+)?;

TAG: [#]WORD;
WORD: [A-Za-z0-9]+;
WHITESPACE: (' ' | '\t') -> skip;
NEWLINE: ('\r'? '\n' | '\r')+;

STRING: ["][^"]* ["];
TR_FLAG: [!] | [*];
INDENT: WHITESPACE+;
