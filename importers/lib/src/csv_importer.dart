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
class TransactionTransformer {
  final List<Transformer> dateTransformers;
  final List<Transformer> narrationTransformers;
  final List<Transformer> payeeTransformers;

  final List<Transformer> posting0AccountTransformers;
  final List<Transformer> posting0AmountTransformers;
  final List<Transformer> posting0CurrencyTransformers;

  TransactionTransformer({
    required this.dateTransformers,
    required this.narrationTransformers,
    this.payeeTransformers = const [],
    required this.posting0AccountTransformers,
    required this.posting0AmountTransformers,
    required this.posting0CurrencyTransformers,
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
    if (posting0AccountTransformers.isEmpty) {
      throw Exception('Empty Posting0Account transformers');
    }
    if (posting0AmountTransformers.isEmpty) {
      throw Exception('Empty Posting0Amount transformers');
    }
    if (posting0CurrencyTransformers.isEmpty) {
      throw Exception('Empty Posting0Currency transformers');
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
    if (posting0AccountTransformers.last.outputType != Account) {
      throw Exception('Invalid posting0Account transformer');
    }
    if (posting0AmountTransformers.last.outputType != Decimal) {
      throw Exception('Invalid posting0Amount transformer');
    }
    if (posting0CurrencyTransformers.last.outputType != String) {
      throw Exception('Invalid posting0Currency transformer');
    }
  }

  TransactionSpec apply(List<String> values) {
    var date = applyTransformers(dateTransformers, values);
    var narration = applyTransformers(narrationTransformers, values);
    var payee = payeeTransformers.isEmpty
        ? null
        : applyTransformers(payeeTransformers, values);

    var posting0Account =
        applyTransformers(posting0AccountTransformers, values);
    var posting0Amount = applyTransformers(posting0AmountTransformers, values);
    var posting0Currency =
        applyTransformers(posting0CurrencyTransformers, values);

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
    throw Exception("Not implemented");
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

// After that we need to add some kind of decision tree to figure out which model to use based on the input
// In the simplest case, it would be best to do it based on the existance / non-existance of some field
// or based on the enum value of some field (how do we figure this one out?)
