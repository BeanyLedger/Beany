grammar Beancount;

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

// FIXME: Make this more strict?
account: WORD (':' WORD)+;
currency: WORD;

amount: NUMBER currency;

includeStatement: 'include' quoted_string;
optionStatement:
	'option' key = quoted_string value = quoted_string;
commentStatement: ('#' | ';') ~(NEWLINE)* NEWLINE;

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
	tr_header NEWLINE (tr_comment NEWLINE)* metadata (
		(
			posting_spec_account_only
			| posting_spec_account_amount
			| posting_spec_with_cost
		) NEWLINE
	)+;
tr_header:
	date tr_flag narration = quoted_string payee = quoted_string? tags?;

tr_flag: TR_FLAG;
inline_comment: ';' ~(NEWLINE)*;

tr_comment: inline_comment;
posting_spec_account_only: account tags? inline_comment?;
posting_spec_account_amount:
	account amount tags? inline_comment?;
posting_spec_with_cost:
	account amount cost_spec tags? inline_comment?;

cost_spec: cost_spec_per | cost_spec_total;
cost_spec_per: '@' amount_spec;
cost_spec_total: '@@' amount_spec;
amount_spec: NUMBER? currency?;

date: DATE;
// quoted_string: '"' (.)? '"';
quoted_string: STR;
tags: TAG+;

metadata: (metadata_key ':' metadata_value NEWLINE)*;
metadata_key: WORD;
metadata_value: quoted_string | TAG | NUMBER | amount | account;

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
WORD: [\p{Alnum}\-_]+;
// CURRENCY: [A-Z][A-Z'.\\-_]* [A-Z0-9]; // max 24 characters long CURRENCY: WORD; // max 24
// characters long
WHITESPACE: (' ' | '\t')+ -> skip;
NEWLINE: ('\r'? '\n' | '\r')+;
// NOT_NEWLINE: ~('\r' | '\n' | '\r\n');

TR_FLAG: 'txn' | '!' | '*';
STR: '"' (~[\\"] | '\\' [\\"()])* '"';
