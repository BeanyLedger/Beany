import 'package:decimal/decimal.dart';
import 'package:petitparser/petitparser.dart';

import 'package:meta/meta.dart';

import './core.dart';

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

final _trHeader =
    (dateParser & _space & _flag & _space & quotedStringParser & _eol);
final trHeaderParser = _trHeader.token().map((token) {
  var v = token.value;
  return Transaction(v[0], v[2], v[4]);
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
    (_decimal & digit().star()).optional();

@visibleForTesting
final numberParser = _number.flatten().map((value) {
  return Decimal.parse(value);
});

final _currency = word().plus().flatten();

final _amount = (numberParser & char(' ') & _currency)
    .token()
    .map((t) => Amount(t.value[0], t.value[2] as String));

@visibleForTesting
final posting =
    (_indent & accountParser & _indent & _amount & _eol).token().map((t) {
  return Posting(t.value[1], t.value[3]);
});

@visibleForTesting
final trComment =
    (_indent & char(';') & (word() | _space).starLazy(_eol).flatten() & _eol)
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
  tr.comments = (v[1] as Token).value as List<String>;
  tr.postings = ((v[2] as Token).value as List<dynamic>).cast<Posting>();
  return tr;
});

final _emptyLine = _space.star() & char('\n');

final _parser = (trParser & _emptyLine.star()).star() & endOfInput();
final parser = _parser.map((value) {
  var trAll = <Transaction>[];

  void extract(List<dynamic> list) {
    for (var x in list) {
      if (x is List) {
        extract(x);
      }
      if (x is Transaction) {
        trAll.add(x);
      }
    }
  }

  extract(value);
  return trAll;
});
