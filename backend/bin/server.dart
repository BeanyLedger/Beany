import 'dart:convert';
import 'dart:io';

import 'package:beany_core/core/transaction.dart';
import 'package:beany_core/engine/ledger.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..get('/transactions', _transactionsHandler);

Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

// Have some standard way to filter all API end-points
// -> by time
// -> by accounts
// -> via full text search
// -> by file
Response _transactionsHandler(Request request) {
  var transactions = ledger.statements.whereType<TransactionSpec>();
  var jsonList = transactions.map((e) => e.resolve().toJson());

  return Response.ok(jsonEncode(jsonList.toList().reversed.toList()), headers: {
    'content-type': 'application/json',
  });
}

late final Ledger ledger;

void main(List<String> args) async {
  if (args.length != 1) {
    print('usage: file');
    exit(1);
  }

  try {
    ledger = await Ledger.loadRootFile(args.first);
    print("Found: ${ledger.statements.length} statements");
  } catch (e, stackTrace) {
    print(e);
    print(stackTrace);
    exit(1);
  }

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
