import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/amount.dart';
import 'package:beany_core/core/cost_spec.dart';
import 'package:beany_core/core/meta_value.dart';
import 'package:beany_core/core/posting.dart';
import 'package:beany_core/core/transaction.dart';
import 'package:beany_core/misc/date.dart';
import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

@immutable
class PostingTransformer extends Equatable {
  final List<Transformer> accountTransformers;
  final List<Transformer> amountTransformers;
  final List<Transformer> currencyTransformers;
  final List<Transformer> costSpecTransformers;

  @override
  List<Object?> get props => [
        accountTransformers,
        amountTransformers,
        currencyTransformers,
        costSpecTransformers
      ];

  PostingTransformer({
    required this.accountTransformers,
    required this.amountTransformers,
    required this.currencyTransformers,
    this.costSpecTransformers = const [],
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
    if (costSpecTransformers.isNotEmpty &&
        costSpecTransformers.last.outputType != CostSpec) {
      throw Exception('Invalid CostSpec transformer');
    }

    //
    // Validate Transformer Chains
    //
    validateTransformerChain(accountTransformers);
    validateTransformerChain(amountTransformers);
    validateTransformerChain(currencyTransformers);
    validateTransformerChain(costSpecTransformers);
  }

  PostingSpec apply(List<String> values) {
    var account = applyTransformers(accountTransformers, values);
    var amount = applyTransformers(amountTransformers, values);
    var currency = applyTransformers(currencyTransformers, values);
    var costSpec = costSpecTransformers.isEmpty
        ? null
        : applyTransformers(costSpecTransformers, values);

    return PostingSpec(account, Amount(amount, currency), costSpec: costSpec);
  }
}

@immutable
class MetaDataTransformer extends Equatable {
  final List<Transformer> keyTransformers;
  final List<Transformer> valueTransformers;

  @override
  List<Object?> get props => [keyTransformers, valueTransformers];

  MetaDataTransformer({
    required this.keyTransformers,
    required this.valueTransformers,
  }) {
    //
    // Validate Inputs
    //
    if (keyTransformers.isEmpty) {
      throw Exception('Empty Key transformers');
    }
    if (valueTransformers.isEmpty) {
      throw Exception('Empty Value transformers');
    }

    //
    // Validate Outputs
    //
    if (keyTransformers.last.outputType != String) {
      throw Exception('Invalid Key transformer');
    }
    if (valueTransformers.last.outputType != String) {
      throw Exception('Invalid Value transformer');
    }

    //
    // Validate Transformer Chains
    //
    validateTransformerChain(keyTransformers);
    validateTransformerChain(valueTransformers);
  }

  Map<String, MetaValue> apply(List<String> values) {
    var key = applyTransformers(keyTransformers, values);
    var value = applyTransformers(valueTransformers, values);

    return {key: MetaValue(stringValue: value)};
  }
}

@immutable
class TransactionTransformer extends Equatable {
  final List<Transformer> dateTransformers;
  final List<Transformer> narrationTransformers;
  final List<Transformer> payeeTransformers;
  final List<Transformer> commentsTransformers;

  final List<MetaDataTransformer> metaTransformers;
  final List<PostingTransformer> postingTransformers;

  @override
  List<Object?> get props => [
        dateTransformers,
        narrationTransformers,
        payeeTransformers,
        commentsTransformers,
        metaTransformers,
        postingTransformers,
      ];

  TransactionTransformer({
    required this.dateTransformers,
    required this.narrationTransformers,
    this.payeeTransformers = const [],
    this.commentsTransformers = const [],
    this.metaTransformers = const [],
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

    //
    // Validate Chains
    //
    validateTransformerChain(dateTransformers);
    validateTransformerChain(narrationTransformers);
    validateTransformerChain(payeeTransformers);
    validateTransformerChain(commentsTransformers);
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

    return TransactionSpec(
      date,
      TransactionFlag.Okay,
      narration,
      payee: payee,
      comments: comment != null ? [comment] : [],
      meta: {
        for (var metaTransformer in metaTransformers)
          ...metaTransformer.apply(values),
      },
      postings: [
        for (var transformer in postingTransformers) transformer.apply(values),
      ],
    );
  }
}

void validateTransformerChain(List<Transformer> transformers) {
  if (transformers.isEmpty) return;

  var currentType = transformers.first.inputType;
  for (var tr in transformers) {
    if (tr.inputType != currentType) {
      throw Exception(
          'Invalid input type while validating transformers. ${tr.typeId} cannot accept $currentType. It needs ${tr.inputType}');
    }
    currentType = tr.outputType;
  }
}

R applyTransformers<T, R>(List<Transformer> transformers, T value) {
  dynamic input = value;
  for (var transformer in transformers) {
    var output = transformer.transform(input);
    input = output;
  }

  return input;
}

// Maybe this can operate on the header instead of the index?

abstract class Transformer<T, R> extends Equatable {
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

  @override
  List<Object?> get props => [index];
}

class DateTransformerExcel extends Transformer<String, Date> {
  DateTransformerExcel();

  @override
  Date transform(String input) {
    var days = double.parse(input);
    var dt = Date(1899, 12, 30).add(Duration(days: days.toInt()));
    /*
    if (dt.year < 1900) {
      throw Exception('Invalid date - Excel Transformer date is too old');
    }
    if (dt.year > 2100) {
      throw Exception(
          'Invalid date - Excel Transformer date is too much in the futre');
    }
    */
    return Date.truncate(dt);
  }

  @override
  String get typeId => 'DateTransformerExcel';

  @override
  List<Object?> get props => [];
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

  @override
  List<Object?> get props => [format];
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

  @override
  List<Object?> get props => [fixedValue];
}

class StringTrimmingTransformer extends Transformer<String, String> {
  @override
  String transform(String input) {
    return input.trim();
  }

  @override
  String get typeId => 'StringTrimmingTransformer';

  @override
  List<Object?> get props => [];
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

  @override
  List<Object?> get props => [fixedValue];
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

  @override
  List<Object?> get props => [];
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
  @override
  List<Object?> get props => [];
}

class NumberTransformerFlipSign extends Transformer<Decimal, Decimal> {
  @override
  Decimal transform(Decimal input) {
    return -input;
  }

  @override
  String get typeId => 'NumberTransformerFlipSign';

  @override
  List<Object?> get props => [];
}

class PositiveNumberTransformer extends Transformer<Decimal, Decimal> {
  @override
  Decimal transform(Decimal input) {
    return input.abs();
  }

  @override
  String get typeId => 'PositiveNumberTransformer';

  @override
  List<Object?> get props => [];
}

class NegativeNumberTransformer extends Transformer<Decimal, Decimal> {
  @override
  Decimal transform(Decimal input) {
    return -input.abs();
  }

  @override
  String get typeId => 'NegativeNumberTransformer';

  @override
  List<Object?> get props => [];
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

  @override
  List<Object?> get props => [part, separator, expectedParts];
}

class CostSpecTotalTransformer extends Transformer<Decimal, CostSpec> {
  final Currency currency;

  CostSpecTotalTransformer({required this.currency});

  @override
  CostSpec transform(Decimal input) {
    return CostSpec(amountTotal: Amount(input, currency));
  }

  @override
  String get typeId => 'CostSpecTotalTransformer';

  @override
  List<Object?> get props => [currency];
}

// After that we need to add some kind of decision tree to figure out which model to use based on the input
// In the simplest case, it would be best to do it based on the existance / non-existance of some field
// or based on the enum value of some field (how do we figure this one out?)
