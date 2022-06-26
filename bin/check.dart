// import 'dart:convert';
// import 'dart:io';

// import 'package:gringotts/parser.dart';

int main(List<String> args) {
  if (args.length != 1) {
    print('usage: file');
    return 1;
  }

  // var input = File(args.first).readAsStringSync();
  // var pResult = parser.parse(input);
  // if (pResult.isFailure) {
  //   print('Failure: $pResult');
  //   var remaining = pResult.buffer.substring(pResult.position);
  //   var lines = LineSplitter.split(remaining).toList();
  //   print(lines[0]);
  //   return 1;
  // }

  return 0;
}
