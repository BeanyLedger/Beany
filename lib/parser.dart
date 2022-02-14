import 'package:decimal/decimal.dart';
import 'package:gringotts/core/commodity.dart';
import 'package:gringotts/core/open.dart';
import 'package:petitparser/petitparser.dart';

import 'package:meta/meta.dart';

import 'core/balance.dart';
import 'core/close.dart';
import 'core/core.dart';
import 'core/price.dart';
import 'core/transactions.dart';

final _year = digit().times(4).flatten().map(int.parse);
final _month = digit().times(2).flatten().map(int.parse);
final _day = digit().times(2).flatten().map(int.parse);
final _dateSep = char('-');
final _date = _year & _dateSep & _month & _dateSep & _day;
final dateParser = _date.token().map((t) {
  var val = t.value;
  return DateTime(val[0], val[2], val[4]);
}).labeled('date');

// Check if the DateTime contains a valid date!

final _flag =
    (char('*') | char('!')).map((f) => TransactionFlag(f)).labeled('Flag');

final _quote = char('"');
final _space = char(' ');

final _quotedString = _quote & any().starLazy(_quote | _eol).flatten() & _quote;
@visibleForTesting
final quotedStringParser = _quotedString.token().map((t) => t.value[1]);

final _trHeader = (dateParser &
    _space &
    _flag &
    _space &
    quotedStringParser &
    (_space & quotedStringParser).optional().map((v) => v?[1] ?? "") &
    _eol);

final trHeaderParser = _trHeader.token().map((token) {
  var v = token.value;
  return Transaction(v[0], v[2], v[4], payee: v[5]);
});

final _accountComponent = word().plus();
final _accountSep = char(':');
final _account = _accountComponent.separatedBy(_accountSep).flatten();

@visibleForTesting
final accountParser = _account.map((a) => Account(a));

final _indent = _space.times(2).flatten();

@visibleForTesting
final postingAccountOnly = (_indent & accountParser & _eol).token().map((t) {
  return Posting(t.value[1], null);
});

final _decimal = char('.');
final _number = char('-').optional() &
    digit().star() &
    (_decimal & digit().plus()).optional();

@visibleForTesting
final numberParser = _number.flatten().map((value) {
  assert(value.isNotEmpty);
  try {
    return Decimal.parse(value);
  } catch (ex) {
    throw Exception("Failed to parse '$value' as Decimal");
  }
});

final _currency = word().plus().flatten();

final _amount = (numberParser & char(' ') & _currency)
    .token()
    .map((t) => Amount(t.value[0], t.value[2] as String));

@visibleForTesting
final posting = (_indent &
        accountParser &
        _indent &
        whitespace().star().token() &
        _amount &
        _eol)
    .token()
    .map((t) {
  return Posting(t.value[1], t.value[4]);
});

@visibleForTesting
final trComment = (_indent & char(';') & any().starLazy(_eol).flatten() & _eol)
    .token()
    .map((t) => (t.value[2] as String).trim())
    .cast<String>()
    .labeled('Comment');

final _eol = _space.star() & char('\n');

final _trParser = trHeaderParser &
    trComment.star().token() &
    (posting | postingAccountOnly).plus().token();

@visibleForTesting
final trParser = _trParser.token().map((t) {
  var v = t.value;
  var tr = v[0] as Transaction;
  return tr.copyWith(
    comments: (v[1] as Token).value,
    postings: ((v[2] as Token).value as List<dynamic>).cast<Posting>(),
  );
});

final _balanceParser = dateParser &
    _space &
    string('balance') &
    _space &
    accountParser &
    _indent &
    whitespace().star().token() &
    _amount &
    _eol;

final balanceParser = _balanceParser.map((value) {
  return Balance(value[0], value[4], value[7]);
});

final _priceParser = dateParser &
    _space &
    string('price').labeled('price keyword') &
    _space &
    _currency &
    _indent &
    whitespace().star().token() &
    _amount &
    _eol;

final priceParser = _priceParser.map((value) {
  return Price(value[0], value[4], value[7]);
});

final _openParser =
    dateParser & _space & string('open') & _space & accountParser & _eol;

final openParser = _openParser.map((value) {
  return Open(value[0], value[4]);
});

final _closeParser =
    dateParser & _space & string('close') & _space & accountParser & _eol;

final closeParser = _closeParser.map((value) {
  return Close(value[0], value[4]);
});

final _commodityParser =
    dateParser & _space & string('commodity') & _space & _currency & _eol;

final commodityParser = _commodityParser.map((value) {
  return Commodity(value[0], value[4]);
});

final _emptyLine = _space.star() & char('\n');
final _directive = balanceParser |
    priceParser |
    trParser |
    openParser |
    closeParser |
    commodityParser;

final _parser =
    _emptyLine.star() & (_directive & _emptyLine.star()).star() & endOfInput();
final parser = _parser.map((value) {
  var all = <Directive>[];

  void extract(List<dynamic> list) {
    for (var x in list) {
      if (x is List) {
        extract(x);
      }
      if (x is Directive) {
        all.add(x);
      }
    }
  }

  extract(value);
  return all;
});
