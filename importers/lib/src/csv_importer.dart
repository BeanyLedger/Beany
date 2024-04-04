import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/amount.dart';
import 'package:beany_core/core/meta_value.dart';
import 'package:beany_core/core/posting.dart';
import 'package:beany_core/core/transaction.dart';
import 'package:beany_core/misc/date.dart';
import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

import 'package:meta/meta.dart';

// part 'csv_importer.g.dart';

void trainImporter(List<dynamic> csvValues, TransactionSpec expectedTr) {}

@immutable
class PostingTransformer {
  final List<Transformer> accountTransformers;
  final List<Transformer> amountTransformers;
  final List<Transformer> currencyTransformers;

  PostingTransformer({
    required this.accountTransformers,
    required this.amountTransformers,
    required this.currencyTransformers,
  }) {
    //
    // Validate Inputs
    //
    if (accountTransformers.isEmpty) {
      throw Exception('Empty Account transformers');
    }
    if (amountTransformers.isEmpty) {
      throw Exception('Empty Amount transformers');
    }
    if (currencyTransformers.isEmpty) {
      throw Exception('Empty Currency transformers');
    }

    //
    // Validate Outputs
    //
    if (accountTransformers.last.outputType != Account) {
      throw Exception('Invalid Account transformer');
    }
    if (amountTransformers.last.outputType != Decimal) {
      throw Exception('Invalid Amount transformer');
    }
    if (currencyTransformers.last.outputType != String) {
      throw Exception('Invalid Currency transformer');
    }
  }

  PostingSpec apply(List<String> values) {
    var account = applyTransformers(accountTransformers, values);
    var amount = applyTransformers(amountTransformers, values);
    var currency = applyTransformers(currencyTransformers, values);

    return PostingSpec(account, Amount(amount, currency));
  }
}

@immutable
class TransactionTransformer {
  final List<Transformer> dateTransformers;
  final List<Transformer> narrationTransformers;
  final List<Transformer> payeeTransformers;
  final List<Transformer> commentsTransformers;

  final List<Transformer> meta0KeyTransformer;
  final List<Transformer> meta0ValueTransformer;

  final List<Transformer> meta1KeyTransformer;
  final List<Transformer> meta1ValueTransformer;

  final List<PostingTransformer> postingTransformers;

  TransactionTransformer({
    required this.dateTransformers,
    required this.narrationTransformers,
    this.payeeTransformers = const [],
    this.commentsTransformers = const [],
    this.meta0KeyTransformer = const [],
    this.meta0ValueTransformer = const [],
    this.meta1KeyTransformer = const [],
    this.meta1ValueTransformer = const [],
    required this.postingTransformers,
  }) {
    //
    // Validate Inputs
    //
    if (dateTransformers.isEmpty) {
      throw Exception('Empty Date transformers');
    }
    if (narrationTransformers.isEmpty) {
      throw Exception('Empty Narration transformers');
    }

    //
    // Validate Outputs
    //
    if (dateTransformers.last.outputType != Date) {
      throw Exception('Invalid date transformer');
    }
    if (narrationTransformers.last.outputType != String) {
      throw Exception('Invalid narration transformer');
    }
    if (payeeTransformers.isNotEmpty &&
        payeeTransformers.last.outputType != String) {
      throw Exception('Invalid payee transformer');
    }
    if (commentsTransformers.isNotEmpty &&
        commentsTransformers.last.outputType != String) {
      throw Exception('Invalid comments transformer');
    }
    if (meta0KeyTransformer.isNotEmpty &&
        meta0KeyTransformer.last.outputType != String) {
      throw Exception('Invalid meta0Key transformer');
    }
    if (meta0ValueTransformer.isNotEmpty &&
        meta0ValueTransformer.last.outputType != String) {
      throw Exception('Invalid meta0Value transformer');
    }
    if (meta1KeyTransformer.isNotEmpty &&
        meta1KeyTransformer.last.outputType != String) {
      throw Exception('Invalid meta1Key transformer');
    }
    if (meta1ValueTransformer.isNotEmpty &&
        meta1ValueTransformer.last.outputType != String) {
      throw Exception('Invalid meta1Value transformer');
    }
  }

  TransactionSpec apply(List<String> values) {
    var date = applyTransformers(dateTransformers, values);
    var narration = applyTransformers(narrationTransformers, values);
    var payee = payeeTransformers.isEmpty
        ? null
        : applyTransformers(payeeTransformers, values);
    var comment = commentsTransformers.isEmpty
        ? null
        : applyTransformers(commentsTransformers, values);

    var meta0Key = meta0KeyTransformer.isEmpty
        ? null
        : applyTransformers(meta0KeyTransformer, values);
    var meta0Value = meta0ValueTransformer.isEmpty
        ? null
        : applyTransformers(meta0ValueTransformer, values);

    var meta1Key = meta1KeyTransformer.isEmpty
        ? null
        : applyTransformers(meta1KeyTransformer, values);
    var meta1Value = meta1ValueTransformer.isEmpty
        ? null
        : applyTransformers(meta1ValueTransformer, values);

    var meta = <String, MetaValue>{
      if (meta0Key != null && meta0Value != null)
        meta0Key: MetaValue(stringValue: meta0Value),
      if (meta1Key != null && meta1Value != null)
        meta1Key: MetaValue(stringValue: meta1Value),
    };

    return TransactionSpec(
      date,
      TransactionFlag.Okay,
      narration,
      payee: payee,
      comments: comment != null ? [comment] : [],
      meta: meta,
      postings: [
        for (var transformer in postingTransformers) transformer.apply(values),
      ],
    );
  }
}

T applyTransformers<T>(List<Transformer> transformers, List<String> values) {
  dynamic input = values;
  for (var transformer in transformers) {
    var output = transformer.transform(input);
    input = output;
  }

  return input;
}

// Maybe this can operate on the header instead of the index?

abstract class Transformer<T, R> {
  R transform(T input);

  Type get inputType => T;
  Type get outputType => R;

  String get typeId;
}

class CsvIndexPosTransformer extends Transformer<List<String>, String> {
  final int index;

  CsvIndexPosTransformer(this.index);

  @override
  String transform(List<String> input) {
    return input[index];
  }

  @override
  String get typeId => 'CsvIndexPos';
}

class DateTransformerExcel extends Transformer<String, Date> {
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

  @override
  String get typeId => 'DateTransformerExcel';
}

class DateTransformerFormat extends Transformer<String, Date> {
  final String format;

  DateTransformerFormat(this.format);

  @override
  Date transform(String input) {
    var formatter = DateFormat(format);
    return Date.truncate(formatter.parse(input));
  }

  @override
  String get typeId => 'DateTransformerFormat';
}

class StringTransformerFixed extends Transformer<void, String> {
  final String fixedValue;

  StringTransformerFixed(this.fixedValue);

  @override
  String transform(void input) {
    return fixedValue;
  }

  @override
  String get typeId => 'StringTransformerFixed';
}

class StringTrimmingTransformer extends Transformer<String, String> {
  @override
  String transform(String input) {
    return input.trim();
  }

  @override
  String get typeId => 'StringTrimmingTransformer';
}

class AccountTransformerFixed extends Transformer<void, Account> {
  final String fixedValue;

  AccountTransformerFixed(this.fixedValue);

  @override
  Account transform(void input) {
    return Account(fixedValue);
  }

  @override
  String get typeId => 'AccountTransformerFixed';
}

class NumberTransformerDecimalComma extends Transformer<String, Decimal> {
  @override
  Decimal transform(String input) {
    input = input.trim();
    input = input.replaceAll('.', '').replaceAll(',', '.');
    return Decimal.parse(input);
  }

  @override
  String get typeId => 'NumberTransformerDecimalComma';
}

class NumberTransformerDecimalPoint extends Transformer<String, Decimal> {
  @override
  Decimal transform(String input) {
    input = input.trim();
    input = input.replaceAll(',', '');
    return Decimal.parse(input);
  }

  @override
  String get typeId => 'NumberTransformerDecimalPoint';
}

class PositiveNumberTransformer extends Transformer<Decimal, Decimal> {
  @override
  Decimal transform(Decimal input) {
    return input.abs();
  }

  @override
  String get typeId => 'PositiveNumberTransformer';
}

class NegativeNumberTransformer extends Transformer<Decimal, Decimal> {
  @override
  Decimal transform(Decimal input) {
    return -input.abs();
  }

  @override
  String get typeId => 'NegativeNumberTransformer';
}

class StringSplittingTransformer extends Transformer<String, String> {
  final int part;
  final String separator;
  final int? expectedParts;

  StringSplittingTransformer(
    this.part, {
    this.separator = ' ',
    this.expectedParts,
  });

  @override
  String transform(String input) {
    var parts = input.split(separator);
    if (expectedParts != null && parts.length != expectedParts) {
      throw Exception('Invalid number of parts');
    }
    return parts[part];
  }

  @override
  String get typeId => 'StringSplittingTransformer';
}

// After that we need to add some kind of decision tree to figure out which model to use based on the input
// In the simplest case, it would be best to do it based on the existance / non-existance of some field
// or based on the enum value of some field (how do we figure this one out?)
