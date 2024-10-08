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
		) NEWLINE
	)
	| trStatement; // trStatement has a newline requirement inside it

currency: CURRENCY;

amount: number currency;
account: ACCOUNT;

includeStatement: 'include' string;
optionStatement: 'option' key = string value = string;
pluginStatement: 'plugin' name = string (value = string)?;
commentStatement: comment NEWLINE;

balanceStatement: date 'balance' account amount;
closeStatement: date 'close' account;
openStatement: date 'open' account;
commodityStatement: date 'commodity' currency;
priceStatement: date 'price' currency amount;
queryStatement: date 'query' name = string value = string;
eventStatement: date 'event' name = string value = string;
documentStatement: date 'document' account string;
noteStatement: date 'note' account string;
customStatement: date 'custom' string+;

emptyLine: NEWLINE;

trStatement: trHeader NEWLINE metadata postingSpecWithComments+;
trHeader: date trFlag narration = string payee = string? tags?;

trFlag: TR_FLAG;
comment: COMMENT;

postingSpecWithComments: (comment NEWLINE)* postingSpec NEWLINE;
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
priceSpecPer: '@' amountSpec;
priceSpecTotal: '@@' amountSpec;
amountSpec: number? currency?;

costSpec: costSpecPer | costSpecTotal;
costSpecPer: '{' costSpecExpr '}';
costSpecTotal: '{{' costSpecExpr '}}';

costSpecExpr: costSpecExprPart (',' costSpecExprPart)*;
costSpecExprPart: amount | date | string;

date: DATE;
string: STRING;
tags: TAG+;

metadata: (metadataKey metadataValue NEWLINE)*;
metadataKey: METAKEY_WITH_COLON;
metadataValue: string | TAG | number | amount | account | date;

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

CURRENCY: [A-Z][A-Z0-9'.\\-_]+ [A-Z0-9]; // max 24

fragment WORD: [\p{Alnum}\-_]+;
ACCOUNT: WORD (':' WORD)+;

WHITESPACE: (' ' | '\t')+ -> skip;
NEWLINE: ('\r'? '\n') | '\r';

TR_FLAG: 'txn' | '!' | '*';
STRING: '"' (~[\\"] | '\\' .)* '"';