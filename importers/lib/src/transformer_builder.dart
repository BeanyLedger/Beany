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
import 'package:equatable/equatable.dart';

class DateTransformerBuilder extends TransformerBuilder<String, Date> {
  DateTransformerBuilder();

  @override
  String get typeId => 'DateTransformerBuilder';

  @override
  List<Object?> get props => [];

  @override
  Transformer<String, Date>? build(String input, Date output) {
    var s = input.trim();

    // Check for excel format
    var d = double.tryParse(s);
    if (d != null) {
      var tr = DateTransformerExcel();
      if (tr.transform(s) == output) {
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
        if (tr.transform(s) == output) {
          return tr;
        }
      } catch (e) {
        // Ignore
      }
    }
    return null;
  }
}

class NumberTransformerBuilder extends TransformerBuilder<String, Decimal> {
  NumberTransformerBuilder();

  @override
  String get typeId => 'NumberTransformerBuilder';

  @override
  List<Object?> get props => [];

  @override
  Transformer<String, Decimal>? build(String input, Decimal output) {
    var s = input.trim();

    var numberRegexp = RegExp(r'^-?\d+[,.\d]*[\d]+$');
    if (!numberRegexp.hasMatch(s)) return null;

    var numTransformer = isDecimalComma(s)
        ? NumberTransformerDecimalComma()
        : NumberTransformerDecimalPoint();
    var num = numTransformer.transform(s);

    // Does not match what we want
    if (num.abs() != output.abs()) {
      return null;
    }

    if (num.signum != output.signum) {
      return SeqTransformer(
        [numTransformer, NumberTransformerFlipSign()],
      );
    }
    return numTransformer;
  }
}

bool isDecimalComma(String s) {
  for (var i = s.length - 1; i >= 0; i--) {
    if (s[i] == ',') return true;
    if (s[i] == '.') return false;
  }

  throw Exception('Cannot figure out if the number is decimal comma or point');
}

// Do for strings
// try via trim

// Do for

// buildCsvIndexPosTransformer
// Takes csvInput and the expected value with the type
// This gives a csv chain

// buildStringTransformerChain
// do this for currencies

abstract class TransformerBuilder<T, R> extends Equatable {
  Transformer<T, R>? build(T input, R output);

  Type get inputType => T;
  Type get outputType => R;

  String get typeId;
}

// Maybe rename this to FindInListTransformerBuilder
// and we can have strategies for finding the first correct value
// vs the second or whatever
// FIXME: This clearly needs to be changed!!
//        We don't exactly have a list any more, it's more a Map<String, String>
class MapIteratorTransformerBuilder<T>
    extends TransformerBuilder<Map<String, String>, T> {
  final TransformerBuilder<String, T> builder;

  MapIteratorTransformerBuilder({required this.builder});

  @override
  String get typeId => 'MapIteratorTransformerBuilder';

  @override
  List<Object?> get props => [builder];

  @override
  Transformer<Map<String, String>, T>? build(
    Map<String, String> input,
    T output,
  ) {
    for (var entry in input.entries) {
      var tr = builder.build(entry.value, output);
      if (tr != null) {
        return SeqTransformer([
          MapValueTransformer(entry.key),
          if (tr is SeqTransformer) ...(tr as SeqTransformer).transformers,
          if (tr is! SeqTransformer) tr,
        ]);
      }
    }
    return null;
  }
}

// For each Transformer
// there needs to be similar TransformerBuilder



// Instead of returning a list of transformers
// Create a special ListChainTransformer
// which takes a list of transformers
// and runs them one after another!

// The constructor of this ListChainTransformer can also validate
// that the types match up for each node in this transformer

