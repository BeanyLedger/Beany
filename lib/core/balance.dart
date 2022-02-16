import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:petitparser/petitparser.dart';

import 'account.dart';
import 'common.dart';
import 'core.dart';

class Balance implements Directive {
  final DateTime date;
  final IMap<String, dynamic> meta;

  final Account account;
  final Amount amount;

  final Decimal? tolerance;
  final Amount? diffAmount;

  Balance(
    this.date,
    this.account,
    this.amount, {
    this.tolerance,
    this.diffAmount,
    Map<String, dynamic>? meta,
  }) : meta = IMap(meta);

  String toString() {
    var sb = StringBuffer();
    sb.write(date.toIso8601String().substring(0, 10));
    sb.write(' balance ');
    sb.write(account);
    sb.write('  ');
    sb.write(amount);

    return sb.toString();
  }

  @override
  bool operator ==(Object t) {
    if (t is! Balance) return false;
    return date == t.date &&
        meta == t.meta &&
        account == t.account &&
        amount == t.amount &&
        tolerance == t.tolerance &&
        diffAmount == t.diffAmount;
  }

  static Parser<Balance> get parser {
    return _balanceParser.map((value) {
      return Balance(value[0], value[4], value[7]);
    });
  }
}

final _balanceParser = dateParser &
    spaceParser &
    string('balance') &
    spaceParser &
    Account.parser &
    indent &
    whitespace().star().token() &
    Amount.parser &
    eol;
