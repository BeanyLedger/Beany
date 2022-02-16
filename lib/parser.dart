import 'package:gringotts/core/balance.dart';
import 'package:gringotts/core/commodity.dart';
import 'package:gringotts/core/document.dart';
import 'package:gringotts/core/open.dart';
import 'package:petitparser/petitparser.dart';

import 'core/common.dart';
import 'core/close.dart';
import 'core/core.dart';
import 'core/event.dart';
import 'core/note.dart';
import 'core/price.dart';
import 'core/statements.dart';
import 'core/transaction.dart';

// Check if the DateTime contains a valid date!

final _emptyLine = spaceParser.star() & char('\n');
final _directive = Balance.parser |
    Price.parser |
    Transaction.parser |
    Open.parser |
    Close.parser |
    Note.parser |
    Commodity.parser |
    Document.parser |
    Event.parser;

final _statement = _directive | Option.parser | Comment.parser | Include.parser;

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
