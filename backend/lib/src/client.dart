import 'dart:convert';

import 'package:beany_core/core/account.dart';
import 'package:beany_core/engine/account_balance_node.dart';
import 'package:beany_core/engine/ledger_meta_data.dart';
import 'package:beany_core/misc/date.dart';
import 'package:http/http.dart';
import 'package:beany_core/core/transaction.dart';

class FilterOptions {
  final Date? startDate;

  /// Includes this date
  final Date? endDate;

  /// An empty list means all accounts
  final List<Account> accounts;

  FilterOptions({
    this.startDate,
    this.endDate,
    this.accounts = const [],
  });

  // We aren't using JsonSerializable here as we need a Map<String, String>
  // and not Map<String, dynamic>
  factory FilterOptions.fromJson(Map<String, String> json) {
    return FilterOptions(
      startDate: json['startDate'] == null
          ? null
          : Date.fromIso8601String(json['startDate']!),
      endDate: json['endDate'] == null
          ? null
          : Date.fromIso8601String(json['endDate']!),
      accounts: json['accounts'] == null
          ? []
          : _accountsfromJsonStringList(
              json['accounts']!.split(',').map((e) => e.trim()).toList()),
    );
  }

  Map<String, String> toJson() {
    return {
      if (startDate != null) 'startDate': startDate!.toIso8601String(),
      if (endDate != null) 'endDate': endDate!.toIso8601String(),
      if (accounts.isNotEmpty)
        'accounts': _accountsToJsonStringList(accounts).join(','),
    };
  }

  static List<String> _accountsToJsonStringList(List<Account> accounts) {
    return accounts.map((e) => e.value).toList();
  }

  static List<Account> _accountsfromJsonStringList(List<dynamic> json) {
    return json.map((e) => Account(e as String)).toList();
  }
}

abstract class BeanyClient {
  /*
  // Repos
  Future<String> repoIds();
  Future<String> repo(String id);
  Future<String> repoCreate(String name);
  Future<String> repoDelete(String id);

  // Accounts
  Future<String> account(String repoId);
  */

  Future<LedgerMetaData> metaData();
  Future<List<Transaction>> transactions();
  Future<AccountBalanceNode> balance(Account account, {FilterOptions? filter});
}

class BeanyHttpClient implements BeanyClient {
  final String host;

  BeanyHttpClient(this.host);

  @override
  Future<List<Transaction>> transactions() async {
    final response = await get(Uri.parse('$host/transactions'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load transactions');
    }

    final json = response.body;
    final list = jsonDecode(json) as List<dynamic>;
    return list.map((e) => Transaction.fromJson(e)).toList();
  }

  @override
  Future<AccountBalanceNode> balance(
    Account account, {
    FilterOptions? filter,
  }) async {
    var uri = Uri.parse('$host/balance/${account.value}');
    if (filter != null) {
      uri = uri.replace(queryParameters: filter.toJson());
    }
    final response = await get(uri);
    if (response.statusCode != 200) {
      throw Exception('Failed to load balance');
    }

    final json = response.body;
    return AccountBalanceNode.fromJson(jsonDecode(json));
  }

  @override
  Future<LedgerMetaData> metaData() async {
    final response = await get(Uri.parse('$host/metadata'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load metaadata');
    }

    return LedgerMetaData.fromJson(jsonDecode(response.body));
  }
}

// 1. Manage Git Repos
// 2. OnBoarding a New Repo
// 3. Manage Beany stuff




