import 'package:petitparser/petitparser.dart';

class Account {
  final String value;
  Account(this.value);

  String toString() {
    return value;
  }

  @override
  bool operator ==(Object t) => t is Account && t.value == value;

  static Parser<Account> get parser {
    var accountComponent = word().plus();
    var accountSep = char(':');
    var account = accountComponent.separatedBy(accountSep).flatten();

    return account.map((a) => Account(a));
  }
}
