import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:petitparser/petitparser.dart';

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

final _quotedString = _quote & pattern('^"\n').star().flatten() & _quote;
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
final accountParser = _account.map((a) => Account(a));

final _indent = _space.times(2).flatten();

final postingAccountOnly = (_indent & accountParser & _eol)
    .token()
    .map((t) => Posting(t.value[1], null));

final _decimal = char('.');
final _number = digit().separatedBy(_decimal).flatten();
final _currency = word().plus().flatten();

final _amount = (_number & char(' ') & _currency)
    .token()
    .map((t) => Amount(Decimal.parse(t.value[0]), t.value[2] as String));

final posting = (_indent & accountParser & _indent & _amount & _eol)
    .token()
    .map((t) => Posting(t.value[1], t.value[3]));

final trComment = (_indent & char(';') & any().plus().flatten().trim() & _eol)
    .token()
    .map((t) => t.value[2])
    .cast<String>()
    .labeled('Comment');

final _eol = _space.star() & (char('\n') | endOfInput());

final _trParser = trHeaderParser &
    trComment.star().token() &
    (posting | postingAccountOnly).plus().token();

final trParser = _trParser.token().map((t) {
  print(t);
  var v = t.value;
  return v[0] as Transaction;
});

class Parser {
  List<Transaction> parse(String data) {
    var transactions = <Transaction>[];

    Transaction? tr;
    print("Here we go");
    LineSplitter.split(data).forEach((line) {
      print("Trying to parse: " + line);

      var trHeaderResult = trHeaderParser.parse(line);
      if (trHeaderResult.isSuccess) {
        if (tr != null) {
          transactions.add(tr!);
        }

        tr = trHeaderResult.value;
        return;
      }

      var postingResult = posting.parse(line);
      if (postingResult.isSuccess) {
        tr!.postings.add(postingResult.value);
        return;
      }

      var postingAccOnlyResult = postingAccountOnly.parse(line);
      if (postingAccOnlyResult.isSuccess) {
        tr!.postings.add(postingAccOnlyResult.value);
        return;
      }

      var commentResult = trComment.parse(line);
      if (commentResult.isSuccess) {
        tr!.comments.add(commentResult.value);
        return;
      }
    });

    if (tr != null) {
      transactions.add(tr!);
    }
    return transactions;
  }
}
