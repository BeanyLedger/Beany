// For the date one
// -> try every field which looks like a date
//    -> we can have some kind of date heuristic
//    -> keep a list of some 10-20 date formats
//    -> keep trying via each of them until you find one that works
//
// For narration and payee look for exact matches
//     if not found look for matches after trimming the sides

// Same for metadata

// For numbers, it'll be a bit special
// -> Check if it looks like a number
// -> check if it matches exactly
// -> check if the sign needs to be flipped (I would prefer flipping it over using abs or neg)
// I think we should also have a special currency one, which also accepts ISIN formats

// Every part of this seems to be quite clear
// Step 1:
// -> build all the heuristics,
// -> add a simple transformation chain builder when given a csv input, and output (with type)

// Step 2:
// -> Parse the existing transaction and see what all values are non-null
// -> Also do this for the postings

import 'package:beany_core/misc/date.dart';
import 'package:beany_importer/src/csv_importer.dart';
import 'package:decimal/decimal.dart';

Transformer<String, Date>? buildDateTransformer(String s, Date expectedValue) {
  // Check for excel format
  var d = double.tryParse(s);
  if (d != null) {
    var tr = DateTransformerExcel();
    if (tr.transform(s) == expectedValue) {
      return tr;
    }
    return null;
  }

  var formats = [
    "yyyy-MM-dd",
    "dd-MM-yyyy",
    "dd/MM/yyyy",
    "dd-MMM-yyyy",
    'MM/dd/yyyy',
    "yyyy/MM/dd",
    "MMddyyyy",
    "ddMMyyyy",
    "yyyyMMdd",
    "MM-dd-yyyy",
    "MM.dd.yyyy",
    "dd.MM.yyyy",
    "yyyy.MM.dd",
    "MMM dd, yyyy",
    "dd MMM yyyy",
    "yyyy, MMM dd",
    "MMM-dd-yyyy",
    "yyyy-MMM-dd",
    "dd/MM/yy",
    "MM/dd/yy",
  ];
  for (var format in formats) {
    try {
      var tr = DateTransformerFormat(format);
      if (tr.transform(s) == expectedValue) {
        return tr;
      }
    } catch (e) {
      // Ignore
    }
  }
  return null;
}

List<Transformer> buildNumberTransformerChain(String s, Decimal expectedValue) {
  s = s.trim();

  var numberRegexp = RegExp(r'^-?\d+[,.\d]*[\d]+$');
  if (!numberRegexp.hasMatch(s)) return [];

  var numTransformer = isDecimalComma(s)
      ? NumberTransformerDecimalComma()
      : NumberTransformerDecimalPoint();
  var num = numTransformer.transform(s);

  // Does not match what we want
  if (num.abs() != expectedValue.abs()) {
    return [];
  }

  if (num.signum != expectedValue.signum) {
    return [numTransformer, NumberTransformerFlipSign()];
  }
  return [numTransformer];
}

bool isDecimalComma(String s) {
  for (var i = s.length - 1; i >= 0; i--) {
    if (s[i] == ',') return true;
    if (s[i] == '.') return false;
  }

  throw Exception('Cannot figure out if the number is decimal comma or point');
}


// buildNumberTransformerChain
// String input, Decimal output
// -> Check if it matches the regexp for a number
// -> See if Decimal point or comma, check against abs value
// -> If sign is different, flip it


// buildCsvIndexPosTransformer
// Takes csvInput and the expected value with the type
// This gives a csv chain

// buildStringTransformerChain