import 'package:gringotts/core/balance.dart';
import 'package:gringotts/core/commodity.dart';
import 'package:gringotts/core/document.dart';
import 'package:gringotts/core/open.dart';
import 'package:petitparser/petitparser.dart';

import 'package:meta/meta.dart';

import 'core/common.dart';
import 'core/close.dart';
import 'core/core.dart';
import 'core/event.dart';
import 'core/note.dart';
import 'core/price.dart';
import 'core/statements.dart';
import 'core/transactions.dart';

// Check if the DateTime contains a valid date!

final _flag =
    (char('*') | char('!')).map((f) => TransactionFlag(f)).labeled('Flag');

final _tag = (char('#') & (word() | char('-')).star().flatten())
    .map((v) => v[1] as String);

final _trHeader = (dateParser &
    spaceParser &
    _flag &
    spaceParser &
    quotedStringParser &
    (spaceParser & quotedStringParser).optional().map((v) => v?[1] ?? "") &
    (spaceParser.star() & _tag & spaceParser.star()).star().token() &
    eol);

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

@visibleForTesting
final postingAccountOnly =
    (indent & Account.parser & _postingComment.optional() & eol)
        .token()
        .map((t) {
  return Posting(t.value[1], null, comment: t.value[2]);
});

final _postingComment =
    (spaceParser.star().token() & char(';') & any().starLazy(eol).flatten())
        .map((value) {
  var c = value[2] as String;
  return c.trim();
});

@visibleForTesting
final postingAccountWithAmmount = (indent &
        Account.parser &
        indent &
        whitespace().star().token() &
        Amount.parser &
        _postingComment.optional() &
        eol)
    .token()
    .map((t) {
  return Posting(t.value[1], t.value[4], comment: t.value[5]);
});

@visibleForTesting
final trComment = (indent & char(';') & any().starLazy(eol).flatten() & eol)
    .token()
    .map((t) => (t.value[2] as String).trim())
    .cast<String>()
    .labeled('Comment');

final _trMetaDataLine = indent &
    word().star().flatten() &
    char(':') &
    spaceParser.star() &
    quotedStringParser &
    eol;

final trMetaDataLine = _trMetaDataLine.map((v) => <String>[v[1], v[4]]);
final trMetaData = trMetaDataLine.star().map((v) {
  var map = <String, dynamic>{};
  for (var m in v) {
    map[m[0]] = m[1];
  }
  return map;
});

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

final _priceParser = dateParser &
    spaceParser &
    string('price').labeled('price keyword') &
    spaceParser &
    currencyParser &
    indent &
    whitespace().star().token() &
    Amount.parser &
    eol;

final priceParser = _priceParser.map((value) {
  return Price(value[0], value[4], value[7]);
});

final _openParser = dateParser &
    spaceParser &
    string('open') &
    spaceParser &
    Account.parser &
    eol;

final openParser = _openParser.map((value) {
  return Open(value[0], value[4]);
});

final _closeParser = dateParser &
    spaceParser &
    string('close') &
    spaceParser &
    Account.parser &
    eol;

final closeParser = _closeParser.map((value) {
  return Close(value[0], value[4]);
});

final _commodityParser = dateParser &
    spaceParser &
    string('commodity') &
    spaceParser &
    currencyParser &
    eol;

final commodityParser = _commodityParser.map((value) {
  return Commodity(value[0], value[4]);
});

final _noteParser = dateParser &
    spaceParser &
    string('note') &
    spaceParser &
    Account.parser &
    spaceParser &
    quotedStringParser &
    eol;

@visibleForTesting
final noteParser = _noteParser.map((value) {
  return Note(value[0], value[4], value[6]);
});

final _eventParser = dateParser &
    spaceParser &
    string('event') &
    spaceParser &
    quotedStringParser &
    spaceParser &
    quotedStringParser &
    eol;

@visibleForTesting
final eventParser = _eventParser.map((value) {
  return Event(value[0], value[4], value[6]);
});

final _documentParser = dateParser &
    spaceParser &
    string('document') &
    spaceParser &
    Account.parser &
    spaceParser &
    quotedStringParser &
    eol;

@visibleForTesting
final documentParser = _documentParser.map((value) {
  return Document(value[0], value[4], value[6]);
});

final _optionParser = string('option') &
    spaceParser.star() &
    quotedStringParser &
    spaceParser.star() &
    quotedStringParser &
    eol;
@visibleForTesting
final optionParser = _optionParser.map((v) => Option(v[2], v[4]));

final _includeParser =
    string('include') & spaceParser.star() & quotedStringParser & eol;
@visibleForTesting
final includeParser = _includeParser.map((v) => Include(v[2]));

final _commentParser = char(';') & any().starLazy(eol).flatten() & eol;
final commentParser = _commentParser.map((v) => Comment(v[1].trim()));

final _emptyLine = spaceParser.star() & char('\n');
final _directive = Balance.parser |
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
