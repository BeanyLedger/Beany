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

import 'package:beany_core/core/amount.dart';
import 'package:beany_core/misc/date.dart';
import 'package:beany_importer/src/csv_importer.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

abstract class TransformerBuilder<T, R> extends Equatable {
  /// Returns all the transformers that can transform the input to the output
  /// If input == output, then it'll give a NoOpTransformer
  Iterable<Transformer<T, R>> build(T input, R output);

  Type get inputType => T;
  Type get outputType => R;

  String get typeId;
}

class DateTransformerBuilder extends TransformerBuilder<String, Date> {
  DateTransformerBuilder();

  @override
  String get typeId => 'DateTransformerBuilder';

  @override
  List<Object?> get props => [];

  @override
  Iterable<Transformer<String, Date>> build(String input, Date output) {
    var s = input;

    // Check for excel format
    var d = double.tryParse(s);
    if (d != null) {
      var tr = DateTransformerExcel();
      if (tr.transform(s) == output) {
        return [tr];
      }
      return [];
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
          return [tr];
        }
      } catch (e) {
        // Ignore
      }
    }
    return [];
  }
}

class NumberTransformerBuilder extends TransformerBuilder<String, Decimal> {
  NumberTransformerBuilder();

  @override
  String get typeId => 'NumberTransformerBuilder';

  @override
  List<Object?> get props => [];

  @override
  Iterable<Transformer<String, Decimal>> build(String input, Decimal output) {
    var s = input.trim();
    if (!looksLikeNumber(s)) return [];

    var numTransformer = isDecimalComma(s)
        ? NumberTransformerDecimalComma()
        : NumberTransformerDecimalPoint();
    var num = numTransformer.transform(s);

    // Does not match what we want
    if (num.abs() != output.abs()) {
      return [];
    }

    if (num.signum != output.signum) {
      var tr = SeqTransformer<String, Decimal>(
        [numTransformer, NumberTransformerFlipSign()],
      );
      return [tr];
    }
    return [numTransformer];
  }

  static bool looksLikeNumber(String s) {
    var numberRegexp = RegExp(r'^-?\d+[,.\d]*[\d]+$');
    return numberRegexp.hasMatch(s);
  }
}

bool isDecimalComma(String s) {
  for (var i = s.length - 1; i >= 0; i--) {
    if (s[i] == ',') return true;
    if (s[i] == '.') return false;
  }

  throw Exception('Cannot figure out if the number is decimal comma or point');
}

/// Runs the given Transformer for each value in the map
/// and if it finds a match, it adds a MapValueTransformer
class MapIteratorTransformerBuilder<T>
    extends TransformerBuilder<Map<String, String>, T> {
  final TransformerBuilder<String, T> builder;

  MapIteratorTransformerBuilder({required this.builder});

  @override
  String get typeId => 'MapIteratorTransformerBuilder';

  @override
  List<Object?> get props => [builder];

  @override
  Iterable<Transformer<Map<String, String>, T>> build(
    Map<String, String> input,
    T output,
  ) sync* {
    for (var entry in input.entries) {
      var matchingTransformer = builder.build(entry.value, output);
      if (matchingTransformer.isEmpty) continue;

      for (var tr in matchingTransformer) {
        yield SeqTransformer<Map<String, String>, T>([
          MapValueTransformer(entry.key),
          if (tr is SeqTransformer) ...(tr as SeqTransformer).transformers,
          if (tr is! SeqTransformer) tr,
        ]);
      }
    }
  }
}

class StringMatchingTransformerBuilder
    extends TransformerBuilder<String, String> {
  StringMatchingTransformerBuilder();

  @override
  String get typeId => 'StringMatchingTransformerBuilder';

  @override
  List<Object?> get props => [];

  @override
  Iterable<Transformer<String, String>> build(String input, String output) {
    if (input == output) {
      return [NoOpTransformer()];
    }

    if (input.trim() == output) {
      return [StringTrimmingTransformer()];
    }

    // What other heuristics do we use?
    // Splitting the string?

    return [];
  }
}

class CurrencyTransformerBuilder extends TransformerBuilder<String, Currency> {
  CurrencyTransformerBuilder();

  @override
  String get typeId => 'CurrencyTransformerBuilder';

  @override
  List<Object?> get props => [];

  @override
  Iterable<Transformer<String, String>> build(String input, String output) {
    try {
      var tr = CurrencyTransformer();
      if (tr.transform(input) == output) {
        return [tr];
      }
    } catch (ex) {
      return [];
    }
    return [];
  }
}

class AmountFromStringTransformerBuilder
    extends TransformerBuilder<String, Amount> {
  AmountFromStringTransformerBuilder();

  @override
  String get typeId => 'AmountFromStringTransformerBuilder';

  @override
  List<Object?> get props => [];

  @override
  Iterable<Transformer<String, Amount>> build(
      String input, Amount output) sync* {
    // What about the extra spaces?
    // if there are more parts cause of empty spaces?
    // the empty spaces could be anywhere?

    var parts = input.split(' ');
    if (parts.length != 2) return;

    var numberBuilder = NumberTransformerBuilder();
    var currencyBuilder = CurrencyTransformerBuilder();

    var numberTransformers = numberBuilder.build(parts[0], output.number);
    if (numberTransformers.isNotEmpty) {
      var currencyTransformers =
          currencyBuilder.build(parts[1], output.currency);
      if (currencyTransformers.isNotEmpty) {
        for (var numberTr in numberTransformers) {
          for (var currencyTr in currencyTransformers) {
            yield AmountFromStringTransformer(
              numberTransformer: SeqTransformer([
                StringSplittingTransformer(0, separator: ' ', expectedParts: 2),
                numberTr,
              ]),
              currencyTransformer: SeqTransformer([
                StringSplittingTransformer(1, separator: ' ', expectedParts: 2),
                currencyTr,
              ]),
            );
          }
        }
      }
    }

    numberTransformers = numberBuilder.build(parts[1], output.number);
    if (numberTransformers.isNotEmpty) {
      var currencyTransformers =
          currencyBuilder.build(parts[0], output.currency);
      if (currencyTransformers.isNotEmpty) {
        for (var numberTr in numberTransformers) {
          for (var currencyTr in currencyTransformers) {
            yield AmountFromStringTransformer(
              numberTransformer: SeqTransformer([
                StringSplittingTransformer(1, separator: ' ', expectedParts: 2),
                numberTr,
              ]),
              currencyTransformer: SeqTransformer([
                StringSplittingTransformer(0, separator: ' ', expectedParts: 2),
                currencyTr,
              ]),
            );
          }
        }
      }
    }
  }
}

class AmountTransformerBuilder
    extends TransformerBuilder<Map<String, String>, Amount> {
  AmountTransformerBuilder();

  @override
  String get typeId => 'AmountTransformerBuilder';

  @override
  List<Object?> get props => [];

  @override
  Iterable<Transformer<Map<String, String>, Amount>> build(
    Map<String, String> input,
    Amount output,
  ) sync* {
    var numberBuilder = MapIteratorTransformerBuilder(
      builder: NumberTransformerBuilder(),
    );
    var currencyBuilder = MapIteratorTransformerBuilder(
      builder: CurrencyTransformerBuilder(),
    );

    var numberTransformers = numberBuilder.build(input, output.number);
    var currencyTransformers = currencyBuilder.build(input, output.currency);

    if (currencyTransformers.isEmpty) {
      currencyTransformers = [CurrencyTransformerFixed(output.currency)];
    }

    for (var numberTr in numberTransformers) {
      for (var currencyTr in currencyTransformers) {
        yield AmountTransformer(
          numberTransformer: numberTr,
          currencyTransformer: currencyTr,
        );
      }
    }

    var amountFromStringBuilder = MapIteratorTransformerBuilder(
      builder: AmountFromStringTransformerBuilder(),
    );
    var amountFromStringTransformers =
        amountFromStringBuilder.build(input, output);
    for (var tr in amountFromStringTransformers) {
      yield tr;
    }
  }
}

/*
class PostingTransformerBuilder
    extends TransformerBuilder<Map<String, String>, PostingSpec> {
  final TransformerBuilder<String, String> accountBuilder;
  final TransformerBuilder<String, Decimal> amountBuilder;

  PostingTransformerBuilder({
    required this.accountBuilder,
    required this.amountBuilder,
  });

  @override
  String get typeId => 'PostingTransformerBuilder';

  @override
  List<Object?> get props => [accountBuilder, amountBuilder];

  @override
  Iterable<Transformer<Map<String, String>, Posting>> build(
    Map<String, String> input,
    Posting output,
  ) {
    var expectedAccount = output.account;
    // For the account, iterate over the map and try to find a match

    var account = accountBuilder.build(input['account']!, output.account);

    // For the Amount number, iterate over the map and try to find a match
    // For the Amount currency, same but default to fixed if not found
    var amount = amountBuilder.build(input['amount']!, output.amount);
    if (account == null || amount == null) return null;

    return PostingTransformer(
      accountTransformer: account,
      amountTransformer: amount,
    );
  }
}
*/


// Then we do MetaDataTransformerBuilder
// Then we do a TransactionTransformerBuilder

// With this, we then need a TransformerSimplifier which removes the NoOpTransformers
// and combines the SeqTransformers, if possible

// Maybe the way to reduce the number of solutions is to ask for more data
// instead of applying heuristics to the data?
// How do we communicate what extra data is required in order to reduce the number of solutions?
// This isn't trivial!

// FIXME: Make sure any FixedTransformer is only used for -
// - Account Names
// - Currency Names
// - MetaData keys