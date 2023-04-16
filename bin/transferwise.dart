import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ninja/asymmetric/rsa/encoder/emsaPkcs1v15.dart';
import 'package:ninja/ninja.dart';
import 'package:path/path.dart' as p;

void main(List<String> argv) async {
  if (argv.isEmpty) {
    print("Usage: transferwise <token> <optional-output-dir>");
    exit(1);
  }
  final token = argv[0];
  final outputDir = argv.length == 2 ? argv[1] : null;

  final privateKeyPem = File('private.pem').readAsStringSync();

  var importer = TransferWiseImporter(
    token: token,
    certificatePEM: privateKeyPem,
  );

  final profile = await importer.profile();

  var startDate = DateTime.now().subtract(Duration(days: 60));
  var endDate = DateTime.now();

  final accounts = await importer.balanceAccount(profile);
  for (var ac in accounts) {
    var body = await importer.statement(
        profile, ac.id, startDate, endDate, ac.currency);

    var startDateOnly = startDate.toIso8601String().substring(0, 10);
    var endDateOnly = endDate.toIso8601String().substring(0, 10);
    var fileName = "$startDateOnly.$endDateOnly.${ac.currency}.json";
    var outputPath = fileName;
    if (outputDir != null) {
      outputPath = p.join(outputDir, fileName);
    }

    File(outputPath).writeAsStringSync(body);

    print(outputPath);
  }

  exit(0);
}

class _BalanceAccountInfo {
  final String id;
  final String currency;

  _BalanceAccountInfo(this.id, this.currency);

  @override
  String toString() {
    return "_BalanceAccountInfo{id: $id, currency: $currency}";
  }
}

class TransferWiseImporter {
  final String token;
  final String certificatePEM;
  final bool useProduction = true;

  TransferWiseImporter({required this.token, required this.certificatePEM});

  Future<String> profile() async {
    var url = "/v2/profiles";
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
    var url =
        "/v2/borderless-accounts-configuration/profiles/${profileId}/available-currencies";

    return jsonDecode(await _fetch(url));
  }

  Future<List<_BalanceAccountInfo>> balanceAccount(String profileId) async {
    var url = "/v4/profiles/${profileId}/balances?types=STANDARD";
    var data = jsonDecode(await _fetch(url));

    if (data is! List) {
      throw new Exception("Faulty data when asking for balance accounts");
    }

    return data
        .map((e) => _BalanceAccountInfo(e["id"].toString(), e["currency"]))
        .toList();
  }

  Future<String> statement(
    String profileId,
    String balanceAccountId,
    DateTime startDate,
    DateTime endDate,
    String currency,
  ) async {
    if (endDate.isBefore(startDate)) {
      throw Exception("EndDate before Start Date");
    }

    final duration = endDate.difference(startDate);
    if (duration.inDays > 300) {
      throw Exception("Transferwise Duration's must be less than 300 days");
    }

    final sd = startDate.toUtc().toIso8601String();
    final ed = endDate.toUtc().toIso8601String();
    var url =
        "/v1/profiles/$profileId/balance-statements/$balanceAccountId/statement.json?currency=$currency&intervalStart=$sd&intervalEnd=$ed&type=COMPACT";
    return _fetch(url);
  }

  Future<String> _fetch(String uri) async {
    final baseUrl = useProduction
        ? "https://api.transferwise.com"
        : "https://api.sandbox.transferwise.tech";
    final url = Uri.parse(baseUrl + uri);
    var headers = {
      HttpHeaders.authorizationHeader: 'Bearer ${token}',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var client = http.Client();
    var response = await client.get(url, headers: headers);
    var code = response.statusCode;
    if (code != 200 && code != 403) {
      // print("Wrong status code: $code");
      // print(response.body);

      throw Exception("Wrong status code: ${response.statusCode}");
      // return null;
    }

    var twoFAStatus = response.headers['x-2fa-approval-result'];
    if (twoFAStatus == 'APPROVED') {
      var body = await response.body;
      // print("Approved $body");
      // print("Approved ${response.headers}");
      client.close();
      return body;
    }

    var twoFAHeader = response.headers['x-2fa-approval'];
    if (twoFAHeader == null) {
      return response.body;
    }

    var s = _sign(twoFAHeader, certificatePEM);
    headers['X-Signature'] = s;
    headers['x-2fa-approval'] = twoFAHeader;

    response = await client.get(url, headers: headers);

    var body = await response.body;

    client.close();
    return body;
  }
}

String _sign(String message, String pemCertificate) {
  final privateKey = RSAPrivateKey.fromPEM(pemCertificate);
  return privateKey.signSsaPkcs1v15ToBase64(message, hasher: EmsaHasher.sha256);
}
