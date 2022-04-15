import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ninja/asymmetric/rsa/encoder/emsaPkcs1v15.dart';

import 'package:ninja/ninja.dart';

void main() async {
  var body = await fetch();
  print(body);
}

Future<String> fetch() async {
  var startDate = DateTime.now().subtract(Duration(days: 800));
  var endDate = DateTime.now().subtract(Duration(days: 299));

  var start = startDate.toUtc().toIso8601String();
  var end = endDate.toUtc().toIso8601String();

  var profileId = 435036;
  var accountId = 4116133;
  var currency = "EUR";
  var url = Uri.parse(
      "https://api.transferwise.com/v3/profiles/$profileId/borderless-accounts/$accountId/statement.json?currency=$currency&intervalStart=$start&intervalEnd=$end");

  var headers = {
    HttpHeaders.authorizationHeader:
        'Bearer d492ee04-007a-4796-99b4-ed2e8b9a4705',
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  var client = http.Client();
  var response = await client.get(url, headers: headers);

  var twoFAStatus = response.headers['x-2fa-approval-result'];
  if (twoFAStatus == 'APPROVED') {
    var body = await response.body;
    client.close();
    return body;
  }
  var twoFAHeader = response.headers['x-2fa-approval']!;

  var s = sign(twoFAHeader);
  headers['X-Signature'] = s;
  headers['x-2fa-approval'] = twoFAHeader;

  response = await client.get(url, headers: headers);

  var body = await response.body;
  client.close();
  return body;
}

String sign(String message) {
  final privateKeyPem = File('private.pem').readAsStringSync();
  final privateKey = RSAPrivateKey.fromPEM(privateKeyPem);

  return privateKey.signSsaPkcs1v15ToBase64(message, hasher: EmsaHasher.sha256);
}
