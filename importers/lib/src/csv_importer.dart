import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/amount.dart';
import 'package:beany_core/core/posting.dart';
import 'package:beany_core/core/transaction.dart';
import 'package:beany_core/misc/date.dart';
import 'package:decimal/decimal.dart';

import 'package:meta/meta.dart';

// part 'csv_importer.g.dart';

void trainImporter(List<dynamic> csvValues, TransactionSpec expectedTr) {}

@immutable
class TrainedData {
  final int dateIndex;
  final DateTransformer dateTransformer;

  final int narrationIndex;
  final StringTransformer narrationTransformer;

  final int payeeIndex;
  final StringTransformer payeeTransformer;

  final int meta0Index;
  final StringTransformer meta0Transformer;

  final int meta1Index;
  final StringTransformer meta1Transformer;

  final int meta2Index;
  final StringTransformer meta2Transformer;

  final int posting0AccountIndex;
  final AccountTransformer posting0AccountTransformer;

  final int posting0AmountIndex;
  final NumberTransformer posting0AmountTransformer;

  final int posting0CurrencyIndex;
  final StringTransformer posting0CurrencyTransformer;

  // Add cost info
  // Add potential price info
  // What about more postings

  TrainedData({
    required this.dateIndex,
    required this.dateTransformer,
    required this.narrationIndex,
    required this.narrationTransformer,
    required this.payeeIndex,
    required this.payeeTransformer,
    required this.meta0Index,
    required this.meta0Transformer,
    required this.meta1Index,
    required this.meta1Transformer,
    required this.meta2Index,
    required this.meta2Transformer,
    required this.posting0AccountIndex,
    required this.posting0AccountTransformer,
    required this.posting0AmountIndex,
    required this.posting0AmountTransformer,
    required this.posting0CurrencyIndex,
    required this.posting0CurrencyTransformer,
  });

  TransactionSpec apply(List<dynamic> values) {
    var date = dateTransformer.transform(values[dateIndex]);
    var narration = narrationTransformer.transform(values[narrationIndex]);
    var payee = payeeIndex == -1
        ? null
        : payeeTransformer.transform(values[payeeIndex]);
    // Also handle metadata keys
    // var meta0 = meta0Index == -1
    //     ? null
    //     : meta0Transformer.transform(values[meta0Index]);
    // var meta1 = meta1Index == -1
    //     ? null
    //     : meta1Transformer.transform(values[meta1Index]);
    // var meta2 = meta2Index == -1
    //     ? null
    //     : meta2Transformer.transform(values[meta2Index]);
    var posting0Account =
        posting0AccountTransformer.transform(values[posting0AccountIndex]);
    var posting0Amount = Decimal.parse(values[posting0AmountIndex]);
    var posting0Currency =
        posting0CurrencyTransformer.transform(values[posting0CurrencyIndex]);

    return TransactionSpec(
      date,
      TransactionFlag.Okay,
      narration,
      payee: payee,
      postings: [
        PostingSpec(posting0Account, Amount(posting0Amount, posting0Currency)),
      ],
    );
  }
}

// Date
abstract class DateTransformer {
  Date transform(String input);

  factory DateTransformer.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'excel':
        return DateTransformerExcel();
      case 'format':
        return DateTransformerFormat.fromJson(json);
      default:
        throw Exception('Unknown DateTransformer type');
    }
  }

  // Map<String, dynamic> toJson();
}

class DateTransformerExcel implements DateTransformer {
  DateTransformerExcel();

  @override
  Date transform(String input) {
    var days = double.parse(input);
    var dt = Date(1899, 12, 30).add(Duration(days: days.toInt()));
    if (dt.year < 1900) {
      throw Exception('Invalid date - Excel Transformer date is too old');
    }
    if (dt.year > 2100) {
      throw Exception(
          'Invalid date - Excel Transformer date is too much in the futre');
    }
    return Date.truncate(dt);
  }
}

class DateTransformerFormat implements DateTransformer {
  final String format;

  DateTransformerFormat(this.format);

  @override
  Date transform(String input) {
    return Date(2024, 3, 30);
  }

  // Auto-generate this?
  Map<String, dynamic> toJson() {
    return {
      'format': format,
    };
  }

  factory DateTransformerFormat.fromJson(Map<String, dynamic> json) {
    return DateTransformerFormat(json['format']);
  }
}

// String
abstract class StringTransformer {
  String transform(String input);

  factory StringTransformer.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'none':
        return StringTransformerNone();
      // case 'split':
      // return StringTransformerSplit.fromJson(json);
      default:
        throw Exception('Unknown StringTransformer type');
    }
  }

  // Map<String, dynamic> toJson();
}

class StringTransformerNone implements StringTransformer {
  StringTransformerNone();

  @override
  String transform(String input) {
    return input;
  }

  // factory StringTransformerNone.fromJson(Map<String, dynamic> json) =>
  // _$StringTransformerNoneFromJson(json);
  // Map<String, dynamic> toJson() => _$StringTransformerNoneToJson(this);
}

class StringTransformerFixed implements StringTransformer {
  final String fixedValue;

  StringTransformerFixed(this.fixedValue);

  @override
  String transform(String input) {
    return fixedValue;
  }
}

// Account
abstract class AccountTransformer {
  Account transform(String input);
}

class AccountTransformerFixed implements AccountTransformer {
  final String fixedValue;

  AccountTransformerFixed(this.fixedValue);

  @override
  Account transform(String input) {
    return Account(fixedValue);
  }
}

// Numbers
abstract class NumberTransformer {
  Decimal transform(String input);

  factory NumberTransformer.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'decimalComma':
        return NumberTransformerDecimalComma();
      case 'decimalPoint':
        return NumberTransformerDecimalPoint();
      default:
        throw Exception('Unknown NumberTransformer type');
    }
  }
}

class NumberTransformerDecimalComma implements NumberTransformer {
  @override
  Decimal transform(String input) {
    input = input.trim();
    input = input.replaceAll('.', '').replaceAll(',', '.');
    return Decimal.parse(input);
  }
}

class NumberTransformerDecimalPoint implements NumberTransformer {
  @override
  Decimal transform(String input) {
    input = input.trim();
    input = input.replaceAll(',', '');
    return Decimal.parse(input);
  }
}

// We can have specific transformers
// Date
// string
// number
// currency
// account


// For Dates
// - Excel format
// - The exact format used

// For numbers
// - DecimalComma format
// - DecimalPoint format

// For Strings
// - Split and Take index - Ensure that it the split number of words in constant

//
// We can write some kind of transformer with indexes + list of transformers for that data
// This can be the final model
//

// After that we need to add some kind of decision tree to figure out which model to use based on the input
// In the simplest case, it would be best to do it based on the existance / non-existance of some field
// or based on the enum value of some field (how do we figure this one out?)

// Should we allow for multiple transformers?