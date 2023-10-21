import 'dart:convert';

import 'package:http/http.dart';
import 'package:beany_core/core/transaction.dart';

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

  Future<List<Transaction>> transactions();
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
}

// 1. Manage Git Repos
// 2. OnBoarding a New Repo
// 3. Manage Beany stuff




