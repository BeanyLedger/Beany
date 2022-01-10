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
});

// Check if the DateTime contains a valid date!

final _flag = (char('*') | char('!')).map((f) => TransactionFlag(f));

final _quote = char('"');
final _space = char(' ');

final _quotedString = _quote & pattern('^"').star().flatten() & _quote;
final quotedStringParser = _quotedString.token().map((t) => t.value[1]);

final _trHeader = (dateParser & _space & _flag & _space & quotedStringParser);
final trHeaderParser = _trHeader.token().map((token) {
  var v = token.value;
  return Transaction(v[0], v[2], v[4]);
});

final _accountComponent = word().plus();
final _accountSep = char(':');
final _account = _accountComponent.separatedBy(_accountSep).flatten();
final accountParser = _account.map((a) => Account(a));

final _indent = _space.times(2).flatten();
final _postingAccountOnly = ((_indent & accountParser).end())
    .token()
    .map((t) => Posting(t.value[1] as Account, null));

final _decimal = char('.');
final _number = digit().separatedBy(_decimal).flatten();
final _currency = word().plus().flatten();

final _amount = (_number & char(' ') & _currency)
    .token()
    .map((t) => Amount(Decimal.parse(t.value[0]), t.value[2] as String));

final _posting = (_indent & accountParser & _indent & _amount)
    .end()
    .token()
    .map((t) => Posting(t.value[1], t.value[3]));

final _trComment = (_indent & char(';') & any().plus().flatten().trim())
    .end()
    .token()
    .map((t) => t.value[2])
    .cast<String>();

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

      var postingResult = _posting.parse(line);
      if (postingResult.isSuccess) {
        tr!.postings.add(postingResult.value);
        return;
      }

      var postingAccOnlyResult = _postingAccountOnly.parse(line);
      if (postingAccOnlyResult.isSuccess) {
        tr!.postings.add(postingAccOnlyResult.value);
        return;
      }

      var commentResult = _trComment.parse(line);
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
