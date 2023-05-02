import 'dart:convert';

import 'package:beany/core/account.dart';
import 'package:beany/core/transaction.dart';

class SimpleCategorizer {
  Map<String, Account> rules = {};

  SimpleCategorizer(String rulesContent) {
    var map = jsonDecode(rulesContent);
    if (map is! Map) {
      throw Exception("Rules must be a map");
    }

    for (var accountName in map.keys) {
      if (accountName is! String) {
        throw Exception("Rules must be a map of string");
      }

      var account = Account(accountName);
      var keywords = map[accountName];
      if (keywords is! List) {
        throw Exception("Rules must be a map of string to list");
      }

      for (var keyword in keywords) {
        if (keyword is! String) {
          throw Exception("Rules must be a map of string to list of string");
        }

        rules[keyword] = account;
      }
    }
  }

  Account? classify(Transaction t) {
    var narration = t.narration.toLowerCase();
    for (var rule in rules.keys) {
      if (narration.contains(rule)) {
        return rules[rule]!;
      }
    }

    return null;
  }
}
