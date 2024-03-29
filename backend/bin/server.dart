import 'dart:convert';
import 'dart:io';

import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/transaction.dart';
import 'package:beany_core/engine/account_inventory_map.dart';
import 'package:beany_core/engine/cumulative.dart';
import 'package:beany_core/engine/ledger.dart';
import 'package:beany_core/misc/date.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'qr.dart';

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..get('/metadata', _metadataHandler)
  ..get('/transactions', _transactionsHandler)
  ..get('/balance/<account>', _balanceHandler);

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "GET, POST, delete, OPTIONS",
  "Access-Control-Allow-Headers": "*",
};

Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Response _metadataHandler(Request req) {
  return Response.ok(jsonEncode(ledger.metaData.toJson()), headers: {
    'content-type': 'application/json',
  });
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
    ...corsHeaders,
  });
}

Response _balanceHandler(Request req) {
  var accountName = req.params['account'];
  if (accountName == null) {
    return Response.badRequest(body: {'error': 'Account name is required'});
  }
  var lastDate = ledger.metaData.latestDate;

  var queryParameters = req.url.queryParameters;

  var startDateStr = queryParameters['startDate'];
  var startDate =
      startDateStr != null ? Date.fromIso8601String(startDateStr) : null;

  var endDateStr = queryParameters['endDate'];
  var endDate = endDateStr != null ? Date.fromIso8601String(endDateStr) : null;

  late final AccountInventoryMap balances;
  if (startDate == null && endDate == null) {
    balances = lastDate != null
        ? ledger.inventoryAtEndOfDate(lastDate)!
        : AccountInventoryMap();
  } else if (startDate != null && endDate != null) {
    var startBal = ledger.inventoryAtStartOfDate(startDate);
    if (startBal == null) {
      return Response.badRequest(
          body: jsonEncode({'error': 'No balance for stateDate: $startDate'}));
    }

    var endBal = ledger.inventoryAtStartOfDate(endDate);
    if (endBal == null) {
      return Response.badRequest(
          body: jsonEncode({'error': 'No balance for endDate: $endDate'}));
    }

    balances = endBal - startBal;
  } else if (startDate == null) {
    var bal = ledger.inventoryAtEndOfDate(endDate!);
    if (bal == null) {
      return Response.badRequest(
          body: jsonEncode({'error': 'No balance for endDate: $endDate'}));
    }
    balances = bal;
  } else {
    var bal = ledger.inventoryAtStartOfDate(startDate);
    if (bal == null) {
      return Response.badRequest(
          body: jsonEncode({'error': 'No balance for startDate: $startDate'}));
    }
    balances = bal;
  }

  var balanceTree = calculateCummulativeBalance(balances);
  var node = balanceTree.find(Account(accountName));
  if (node == null) {
    return Response.badRequest(
        body: jsonEncode({'error': 'Account not found'}));
  }

  return Response.ok(jsonEncode(node.val), headers: {
    'content-type': 'application/json',
    ...corsHeaders,
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

  final port = int.parse(Platform.environment['PORT'] ?? '8080');

  var addresses = <InternetAddress>[];
  for (var interface in await NetworkInterface.list()) {
    addresses.addAll(interface.addresses);
  }

  var data = {
    'name': 'beany',
    'interfaces': addresses.map((e) => "http://${e.address}:$port").toList(),
  };
  print(data);

  var out = printQr(jsonEncode(data));
  print(out);

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
