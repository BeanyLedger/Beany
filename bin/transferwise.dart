import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ninja/asymmetric/rsa/encoder/emsaPkcs1v15.dart';

import 'package:ninja/ninja.dart';

void main() async {
  var importer = TransferWiseImporter();

  final p = await importer.profile();

  var startDate = DateTime.now().subtract(Duration(days: 60));
  var endDate = DateTime.now();

  final accounts = await importer.balanceAccount(p);
  for (var ac in accounts) {
    var body = await importer.fetch(p, ac.id, startDate, endDate, ac.currency);
    print("fetched " + body.toString());
  }
}

class _BalanceAccountInfo {
  final String id;
  final String currency;

  _BalanceAccountInfo(this.id, this.currency);
}

class TransferWiseImporter {
  final String token = "d492ee04-007a-4796-99b4-ed2e8b9a4705";

  Future<String> profile() async {
    var url = Uri.parse("https://api.transferwise.com/v2/profiles");
    var data = jsonDecode(await _fetch(url));
    if (data is! List) {
      throw new Exception("Faulty data when asking for profiles");
    }

    final d = data.firstWhere(
      (e) => e["type"] == "PERSONAL",
      orElse: () => null,
    );
    if (d == null) {
      throw new Exception("Transferwise Personal Account not found");
    }
    final id = d["id"];
    if (id == null) {
      throw new Exception("id missing from profile data");
    }
    return id.toString();
  }

  Future<List<String>> availableCurrencies(String profileId) async {
    var url = Uri.parse(
        "https://api.transferwise.com/v2/borderless-accounts-configuration/profiles/${profileId}/available-currencies");

    return jsonDecode(await _fetch(url));
  }

  Future<List<_BalanceAccountInfo>> balanceAccount(String profileId) async {
    var url = Uri.parse(
        "https://api.transferwise.com/v4/profiles/${profileId}/balances?types=STANDARD");
    var data = jsonDecode(await _fetch(url));

    if (data is! List) {
      throw new Exception("Faulty data when asking for balance accounts");
    }

    return data
        .map((e) => _BalanceAccountInfo(e["id"].toString(), e["currency"]))
        .toList();
  }

  Future<String> fetch(
    String profileId,
    String balanceAccountId,
    DateTime startDate,
    DateTime endDate,
    String currency,
  ) async {
    print("fetch $profileId $balanceAccountId $currency");
    if (endDate.isBefore(startDate)) {
      throw Exception("EndDate before Start Date");
    }

    final duration = endDate.difference(startDate);
    if (duration.inDays > 300) {
      throw Exception("Transferwise Duration's must be less than 300 days");
    }

    var url = Uri.parse(
        "https://api.transferwise.com/v3/profiles/$profileId/borderless-accounts/$balanceAccountId/statement.json?currency=$currency&intervalStart=$startDate&intervalEnd=$endDate");

    print(url);
    return _fetch(url);
  }

  Future<String> _fetch(
    Uri url,
  ) async {
    var headers = {
      HttpHeaders.authorizationHeader: 'Bearer ${token}',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var client = http.Client();
    var response = await client.get(url, headers: headers);
    if (response.statusCode != 200 && response.statusCode != 400) {
      print("Wrong status code: ${response.statusCode}");
      print(response.body);

      throw Exception("Wrong status code: ${response.statusCode}");
      // return null;
    }

    var twoFAStatus = response.headers['x-2fa-approval-result'];
    if (twoFAStatus == 'APPROVED') {
      var body = await response.body;
      print("Approved $body");
      print("Approved ${response.headers}");
      client.close();
      return body;
    }

    var twoFAHeader = response.headers['x-2fa-approval'];
    if (twoFAHeader == null) {
      return response.body;
    }

    var s = sign(twoFAHeader);
    headers['X-Signature'] = s;
    headers['x-2fa-approval'] = twoFAHeader;

    response = await client.get(url, headers: headers);

    var body = await response.body;

    print("got body $body");
    client.close();
    return body;
  }
}

String sign(String message) {
  final privateKeyPem = File('private.pem').readAsStringSync();
  final privateKey = RSAPrivateKey.fromPEM(privateKeyPem);

  return privateKey.signSsaPkcs1v15ToBase64(message, hasher: EmsaHasher.sha256);
}
