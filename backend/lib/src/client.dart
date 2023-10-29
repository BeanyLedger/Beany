import 'dart:convert';

import 'package:beany_core/core/account.dart';
import 'package:beany_core/engine/account_balance_node.dart';
import 'package:beany_core/engine/ledger_meta_data.dart';
import 'package:beany_core/misc/date.dart';
import 'package:http/http.dart';
import 'package:beany_core/core/transaction.dart';

class DateRange {
  final Date? startDate;

  /// Includes this date
  final Date? endDate;

  DateRange({
    this.startDate,
    this.endDate,
  });

  // We aren't using JsonSerializable here as we need a Map<String, String>
  // and not Map<String, dynamic>
  factory DateRange.fromJson(Map<String, String> json) {
    return DateRange(
      startDate: json['startDate'] == null
          ? null
          : Date.fromIso8601String(json['startDate']!),
      endDate: json['endDate'] == null
          ? null
          : Date.fromIso8601String(json['endDate']!),
    );
  }

  Map<String, String> toJson() {
    return {
      if (startDate != null) 'startDate': startDate!.toIso8601String(),
      if (endDate != null) 'endDate': endDate!.toIso8601String(),
    };
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
  Future<AccountBalanceNode> balance(Account account, {DateRange? dateRange});
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
    DateRange? dateRange,
  }) async {
    var uri = Uri.parse('$host/balance/${account.value}');
    if (dateRange != null) {
      uri = uri.replace(queryParameters: dateRange.toJson());
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




