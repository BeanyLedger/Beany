import 'package:petitparser/petitparser.dart';

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

//final _flag =
//    (char('*') | char('!')).map((f) => TransactionFlag(f)).labeled('Flag');

final _quote = char('"');
final spaceParser = char(' ');

final _quotedString = _quote & any().starLazy(_quote | eol).flatten() & _quote;
final quotedStringParser = _quotedString.token().map((t) {
  return t.value[1] as String;
});

final eol = spaceParser.star() & (char('\n') | endOfInput());

final indent = spaceParser.times(2).flatten();

final currencyParser = word().plus().flatten();
