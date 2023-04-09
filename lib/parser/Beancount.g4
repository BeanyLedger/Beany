grammar Beancount;

/*
 * Parser Rules
 */

all: (statement | emptyLine)* EOF;

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
currency: CURRENCY;

amount: number currency;
account: ACCOUNT;

includeStatement: 'include' quoted_string;
optionStatement:
	'option' key = quoted_string value = quoted_string;
commentStatement: comment NEWLINE;

balanceStatement: date 'balance' account amount;
closeStatement: date 'close' account;
openStatement: date 'open' account;
commodityStatement: date 'commodity' currency;
priceStatement: date 'price' currency amount;
eventStatement:
	date 'event' name = quoted_string value = quoted_string;
documentStatement: date 'document' account quoted_string;
noteStatement: date 'note' account quoted_string;

emptyLine: NEWLINE;

trStatement:
	trHeader NEWLINE (comment NEWLINE)* metadata (
		(
			postingSpecAccountOnly
			| postingSpecAccountAmount
			| postingSpecWithPrice
		) NEWLINE
	)+;
trHeader:
	date trFlag narration = quoted_string payee = quoted_string? tags?;

trFlag: TR_FLAG;
comment: COMMENT;

postingSpecAccountOnly: account tags? comment?;
postingSpecAccountAmount: account amount tags? comment?;
postingSpecWithPrice: account amount priceSpec tags? comment?;

priceSpec: priceSpecPer | priceSpecTotal;
priceSpecPer: '@' amountSpec;
priceSpecTotal: '@@' amountSpec;
amountSpec: number? currency?;

date: DATE;
// quoted_string: '"' (.)? '"';
quoted_string: STR;
tags: TAG+;

metadata: (metadataKey metadataValue NEWLINE)*;
metadataKey: METAKEY_WITH_COLON;
metadataValue: quoted_string | TAG | number | amount | account;

number: MINUS? INTEGER (COMMA INTEGER)* (DECIMAL INTEGER)?;

/*
 * Lexer Rules
 */
fragment DIGIT: [0-9];
fragment YEAR: DIGIT DIGIT DIGIT DIGIT;
fragment MONTH: DIGIT DIGIT;
fragment DAY: DIGIT DIGIT;
DATE: YEAR [-] MONTH [-] DAY;

INTEGER: DIGIT+;
DECIMAL: '.';
COMMA: ',';
MINUS: '-';

fragment METAKEY: [a-z][A-Za-z0-9\\-_]*;
METAKEY_WITH_COLON: METAKEY ':';

COMMENT: ';' ~('\n')*;
TAG: [#]WORD;

CURRENCY: [A-Z][A-Z'.\\-_]+ [A-Z0-9]; // max 24

fragment WORD: [\p{Alnum}\-_]+;
ACCOUNT: WORD (':' WORD)+;

// characters long
WHITESPACE: (' ' | '\t')+ -> skip;
NEWLINE: ('\r'? '\n') | '\r';
// NOT_NEWLINE: ~('\r' | '\n' | '\r\n');

TR_FLAG: 'txn' | '!' | '*';
STR: '"' (~[\\"] | '\\' [\\"()])* '"';
