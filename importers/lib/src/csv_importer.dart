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

// Shouldn't this List<String> be just a template type?
@immutable
class PostingTransformer extends Equatable {
  final Transformer<List<String>, Account> accountTransformer;
  final Transformer<List<String>, Decimal> amountTransformer;
  final Transformer<List<String>, String> currencyTransformer;
  final Transformer<List<String>, CostSpec>? costSpecTransformer;

  @override
  List<Object?> get props => [
        accountTransformer,
        amountTransformer,
        currencyTransformer,
        costSpecTransformer
      ];

  PostingTransformer({
    required this.accountTransformer,
    required this.amountTransformer,
    required this.currencyTransformer,
    this.costSpecTransformer,
  });

  PostingSpec apply(List<String> values) {
    var account = accountTransformer.transform(values);
    // This should probably be combined into a single transformer
    // as the currency can often be in the same column as the amount
    var amount = amountTransformer.transform(values);
    var currency = currencyTransformer.transform(values);
    var costSpec = costSpecTransformer?.transform(values);

    return PostingSpec(account, Amount(amount, currency), costSpec: costSpec);
  }
}

@immutable
class MetaDataTransformer extends Equatable {
  final Transformer<List<String>, String> keyTransformer;
  final Transformer<List<String>, String> valueTransformer;

  @override
  List<Object?> get props => [keyTransformer, valueTransformer];

  MetaDataTransformer({
    required this.keyTransformer,
    required this.valueTransformer,
  });

  Map<String, MetaValue> apply(List<String> values) {
    var key = keyTransformer.transform(values);
    var value = valueTransformer.transform(values);

    return {key: MetaValue(stringValue: value)};
  }
}

@immutable
class TransactionTransformer extends Equatable {
  final Transformer<List<String>, Date> dateTransformers;
  final Transformer<List<String>, String> narrationTransformers;
  final Transformer<List<String>, String>? payeeTransformers;
  final Transformer<List<String>, String>? commentsTransformers;

  // This should also ideally just be a single Transformer, no need for multiple
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
    this.payeeTransformers,
    this.commentsTransformers,
    this.metaTransformers = const [],
    required this.postingTransformers,
  });

  TransactionSpec apply(List<String> values) {
    var date = dateTransformers.transform(values);
    var narration = narrationTransformers.transform(values);
    var payee = payeeTransformers?.transform(values);
    var comment = commentsTransformers?.transform(values);

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

class ChainedListTransformer<T, R> extends Transformer<T, R> {
  final List<Transformer> transformers;

  ChainedListTransformer(this.transformers) {
    if (transformers.isEmpty) {
      throw Exception('Empty transformers');
    }

    var currentType = transformers.first.inputType;
    for (var tr in transformers) {
      if (tr.inputType != currentType) {
        throw Exception(
            'Invalid input type while validating transformers. ${tr.typeId} cannot accept $currentType. It needs ${tr.inputType}');
      }
      currentType = tr.outputType;
    }
  }

  @override
  R transform(T input) {
    dynamic val = input;
    for (var transformer in transformers) {
      var output = transformer.transform(val);
      val = output;
    }

    return val;
  }

  @override
  String get typeId => 'ChainedListTransformer';

  @override
  List<Object?> get props => [transformers];
}

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

class StringTransformerFixed<T> extends Transformer<T, String> {
  final String fixedValue;

  StringTransformerFixed(this.fixedValue);

  @override
  String transform(T input) {
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

class AccountTransformerFixed<T> extends Transformer<T, Account> {
  final String fixedValue;

  AccountTransformerFixed(this.fixedValue);

  @override
  Account transform(T input) {
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
