import 'package:decimal/decimal.dart';
import 'package:gringotts/core/commodity.dart';
import 'package:gringotts/core/document.dart';
import 'package:gringotts/core/open.dart';
import 'package:petitparser/petitparser.dart';

import 'package:meta/meta.dart';

import 'core/balance.dart';
import 'core/close.dart';
import 'core/core.dart';
import 'core/event.dart';
import 'core/note.dart';
import 'core/price.dart';
import 'core/statements.dart';
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
final quotedStringParser = _quotedString.token().map((t) {
  return t.value[1] as String;
});

final _tag = (char('#') & (word() | char('-')).star().flatten())
    .map((v) => v[1] as String);

final _trHeader = (dateParser &
    _space &
    _flag &
    _space &
    quotedStringParser &
    (_space & quotedStringParser).optional().map((v) => v?[1] ?? "") &
    (_space.star() & _tag & _space.star()).star().token() &
    _eol);

final trHeaderParser = _trHeader.token().map((token) {
  var v = token.value;
  var tagsToken = v[6] as Token<List<List<dynamic>>>;
  var tags = <String>{};
  for (var tagGroup in tagsToken.value) {
    var t = tagGroup[1] as String;
    tags.add(t);
  }
  return Transaction(v[0], v[2], v[4], payee: v[5], tags: tags);
});

final _accountComponent = word().plus();
final _accountSep = char(':');
final _account = _accountComponent.separatedBy(_accountSep).flatten();

@visibleForTesting
final accountParser = _account.map((a) => Account(a));

final _indent = _space.times(2).flatten();

@visibleForTesting
final postingAccountOnly =
    (_indent & accountParser & _postingComment.optional() & _eol)
        .token()
        .map((t) {
  return Posting(t.value[1], null, comment: t.value[2]);
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

final _postingComment =
    (_space.star().token() & char(';') & any().starLazy(_eol).flatten())
        .map((value) {
  var c = value[2] as String;
  return c.trim();
});

@visibleForTesting
final postingAccountWithAmmount = (_indent &
        accountParser &
        _indent &
        whitespace().star().token() &
        _amount &
        _postingComment.optional() &
        _eol)
    .token()
    .map((t) {
  return Posting(t.value[1], t.value[4], comment: t.value[5]);
});

@visibleForTesting
final trComment = (_indent & char(';') & any().starLazy(_eol).flatten() & _eol)
    .token()
    .map((t) => (t.value[2] as String).trim())
    .cast<String>()
    .labeled('Comment');

final _trMetaDataLine = _indent &
    word().star().flatten() &
    char(':') &
    _space.star() &
    quotedStringParser &
    _eol;

final trMetaDataLine = _trMetaDataLine.map((v) => <String>[v[1], v[4]]);
final trMetaData = trMetaDataLine.star().map((v) {
  var map = <String, dynamic>{};
  for (var m in v) {
    map[m[0]] = m[1];
  }
  return map;
});

final _eol = _space.star() & char('\n');

@visibleForTesting
final posting = postingAccountOnly | postingAccountWithAmmount;

final _trParser = trHeaderParser &
    trMetaData &
    trComment.star().token() &
    posting.plus().token();

@visibleForTesting
final trParser = _trParser.token().map((t) {
  var v = t.value;
  var tr = v[0] as Transaction;
  return tr.copyWith(
    meta: v[1],
    comments: (v[2] as Token).value,
    postings: ((v[3] as Token).value as List<dynamic>).cast<Posting>(),
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

final _noteParser = dateParser &
    _space &
    string('note') &
    _space &
    accountParser &
    _space &
    quotedStringParser &
    _eol;

@visibleForTesting
final noteParser = _noteParser.map((value) {
  return Note(value[0], value[4], value[6]);
});

final _eventParser = dateParser &
    _space &
    string('event') &
    _space &
    quotedStringParser &
    _space &
    quotedStringParser &
    _eol;

@visibleForTesting
final eventParser = _eventParser.map((value) {
  return Event(value[0], value[4], value[6]);
});

final _documentParser = dateParser &
    _space &
    string('document') &
    _space &
    accountParser &
    _space &
    quotedStringParser &
    _eol;

@visibleForTesting
final documentParser = _documentParser.map((value) {
  return Document(value[0], value[4], value[6]);
});

final _optionParser = string('option') &
    _space.star() &
    quotedStringParser &
    _space.star() &
    quotedStringParser &
    _eol;
@visibleForTesting
final optionParser = _optionParser.map((v) => Option(v[2], v[4]));

final _includeParser =
    string('include') & _space.star() & quotedStringParser & _eol;
@visibleForTesting
final includeParser = _includeParser.map((v) => Include(v[2]));

final _commentParser = char(';') & any().starLazy(_eol).flatten() & _eol;
final commentParser = _commentParser.map((v) => Comment(v[1].trim()));

final _emptyLine = _space.star() & char('\n');
final _directive = balanceParser |
    priceParser |
    trParser |
    openParser |
    closeParser |
    noteParser |
    commodityParser |
    documentParser |
    eventParser;

final _statement = _directive | optionParser | commentParser | includeParser;

final _parser =
    _emptyLine.star() & (_statement & _emptyLine.star()).star() & endOfInput();
final parser = _parser.map((value) {
  var all = <Statement>[];

  void extract(List<dynamic> list) {
    for (var x in list) {
      if (x is List) {
        extract(x);
      }
      if (x is Statement) {
        all.add(x);
      }
    }
  }

  extract(value);
  return all;
});
