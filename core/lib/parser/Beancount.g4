grammar Beancount;

/*
 * Parser Rules
 */

all: (statement | emptyLine)* EOF;

statement:
	directive
	| includeStatement
	| optionStatement
	| pluginStatement
	| commentStatement;

directive: (
		(
			balanceStatement
			| closeStatement
			| openStatement
			| commodityStatement
			| priceStatement
			| queryStatement
			| eventStatement
			| documentStatement
			| noteStatement
			| customStatement
		) EOL
	)
	| trStatement; // trStatement has a newline requirement inside it

currency: CURRENCY;

amount: number currency;
account: ACCOUNT;

includeStatement: INCLUDE string;
optionStatement: OPTION key = string value = string;
pluginStatement: PLUGIN name = string (value = string)?;
commentStatement: comment EOL;

// pushTagStatement: PUSHTAG TAG c = COMMENT? EOL;

// popTagStatement: POPTAG TAG c = COMMENT? EOL;

balanceStatement:
	date BALANCE account amount comment? EOL metadata;
closeStatement: date CLOSE account;
openStatement: date OPEN account;
commodityStatement: date COMMODITY currency;
priceStatement: date PRICE currency amount;
queryStatement: date QUERY name = string value = string;
eventStatement: date EVENT name = string value = string;
documentStatement: date DOCUMENT account string;
noteStatement: date NOTE account string;
customStatement: date CUSTOM string+;
// padStatement: date PAD sourceAccount = account targetAccount = account;

emptyLine: EOL;

trStatement: trHeader EOL metadata postingSpecWithComments+;
trHeader: date trFlag narration = string payee = string? tags?;

trFlag: TR_FLAG;
comment: COMMENT;

postingSpecWithComments: (comment EOL)* postingSpec EOL;
postingSpec:
	postingSpecAccountOnly
	| postingSpecAccountAmount
	| postingSpecWithPrice
	| postingSpecWithCost
	| postingSpecWithCostAndPrice;

postingSpecAccountOnly: account tags? comment?;
postingSpecAccountAmount: account amount tags? comment?;
postingSpecWithPrice: account amount priceSpec tags? comment?;
postingSpecWithCost: account amount costSpec tags? comment?;
postingSpecWithCostAndPrice:
	account amount costSpec priceSpec tags? comment?;

priceSpec: priceSpecPer | priceSpecTotal;
priceSpecPer: AT amountSpec;
priceSpecTotal: ATAT amountSpec;
amountSpec: number? currency?;

costSpec: costSpecPer | costSpecTotal;
costSpecPer: LCURL costSpecExpr RCURL;
costSpecTotal: LCURLLCURL costSpecExpr RCURLRCURL;

costSpecExpr: costSpecExprPart (COMMA costSpecExprPart)*;
costSpecExprPart: amount | date | string;

date: DATE;
string: STRING;
tags: TAG+;

metadata: (metadataKey metadataValue EOL)*;
metadataKey: METAKEY_WITH_COLON;
metadataValue: string | TAG | number | amount | account | date;

number: MINUS? INTEGER (COMMA INTEGER)* (DOT INTEGER)?;

/*
 * Lexer Rules
 */

INCLUDE: 'include';
// PUSHTAG: 'pushtag'; POPTAG: 'poptag'; PUSHMETA: 'pushmeta'; POPMETA: 'popmeta';
OPTION: 'option';
// OPTIONS: 'options';
PLUGIN: 'plugin';
// TXN: 'txn';
BALANCE: 'balance';
OPEN: 'open';
CLOSE: 'close';
COMMODITY: 'commodity';
// PAD: 'pad';
EVENT: 'event';
PRICE: 'price';
NOTE: 'note';
DOCUMENT: 'document';
QUERY: 'query';
CUSTOM: 'custom';
// PIPE: '|';
ATAT: '@@';
AT: '@';
LCURLLCURL: '{{';
RCURLRCURL: '}}';
LCURL: '{';
RCURL: '}';
COMMA: ',';
// TILDE: '~'; HASH: '#'; ASTERISK: '*'; SLASH: '/'; COLON: ':'; PLUS: '+';
MINUS: '-';
// LPAREN: '('; RPAREN: ')'; SEMICOLON: ';';
DOT: '.';
// FLAG: '!' | '&' | '#' | '?' | '%';

EOL: ('\r' '\n' | '\n' | '\r') ' '*;

fragment DIGIT: [0-9];
fragment YEAR: DIGIT DIGIT DIGIT DIGIT;
fragment MONTH: DIGIT DIGIT;
fragment DAY: DIGIT DIGIT;
DATE: YEAR [-] MONTH [-] DAY;

INTEGER: DIGIT+;

fragment METAKEY: [a-z][A-Za-z0-9\\-_]*;
METAKEY_WITH_COLON: METAKEY ':';

COMMENT: ';' ~('\n')*;
TAG: [#]WORD;

CURRENCY: [A-Z][A-Z0-9'.\\-_]+ [A-Z0-9]; // max 24

fragment WORD: [\p{Alnum}\-_]+;
ACCOUNT: WORD (':' WORD)+;

WHITESPACE: (' ' | '\t')+ -> skip;

TR_FLAG: 'txn' | '!' | '*';
STRING: '"' (~[\\"] | '\\' .)* '"';