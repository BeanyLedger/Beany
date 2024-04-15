import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/amount.dart';
import 'package:beany_core/core/cost_spec.dart';
import 'package:beany_core/core/currency.dart';
import 'package:beany_core/core/meta_value.dart';
import 'package:beany_core/core/posting.dart';
import 'package:beany_core/core/price_spec.dart';
import 'package:beany_core/core/transaction.dart';
import 'package:beany_core/misc/date.dart';
import 'package:decimal/decimal.dart';

import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

export 'transformers_date.dart';
export 'transformers_numbers.dart';
export 'transformers_cost.dart';
export 'transformers_price.dart';
export 'transformers_string.dart';

@immutable
class PostingTransformer extends Transformer<Map<String, String>, PostingSpec> {
  final Transformer<Map<String, String>, Account> accountTransformer;
  final Transformer<Map<String, String>, Amount>? amountTransformer;
  final Transformer<Map<String, String>, CostSpec?>? costSpecTransformer;
  final Transformer<Map<String, String>, PriceSpec?>? priceSpecTransformer;

  @override
  List<Object?> get props => [
        accountTransformer,
        amountTransformer,
        costSpecTransformer,
        priceSpecTransformer,
      ];

  PostingTransformer({
    required this.accountTransformer,
    this.amountTransformer,
    this.costSpecTransformer,
    this.priceSpecTransformer,
  });

  @override
  PostingSpec transform(Map<String, String> input) {
    var values = input;
    var account = accountTransformer.transform(values);
    var amount = amountTransformer?.transform(values);
    var costSpec = costSpecTransformer?.transform(values);
    var priceSpec = priceSpecTransformer?.transform(values);

    return PostingSpec(account, amount,
        costSpec: costSpec, priceSpec: priceSpec);
  }

  @override
  String get typeId => 'PostingTransformer';
}

@immutable
class MetaDataEntryTransformer
    extends Transformer<Map<String, String>, (String, MetaValue)> {
  final Transformer<Map<String, String>, String> keyTransformer;
  final Transformer<Map<String, String>, MetaValue> valueTransformer;

  @override
  List<Object?> get props => [keyTransformer, valueTransformer];

  MetaDataEntryTransformer({
    required this.keyTransformer,
    required this.valueTransformer,
  });

  @override
  (String, MetaValue) transform(Map<String, String> input) {
    var values = input;
    var key = keyTransformer.transform(values);
    var value = valueTransformer.transform(values);

    return (key, value);
  }

  @override
  String get typeId => "MetaDataTransformer";
}

class MetaValueTransformer extends Transformer<String, MetaValue> {
  @override
  MetaValue transform(String input) {
    return MetaValue(stringValue: input);
  }

  @override
  String get typeId => 'MetaValueTransformer';

  @override
  List<Object?> get props => [];
}

@immutable
class TransactionTransformer
    extends Transformer<Map<String, String>, TransactionSpec> {
  final Transformer<Map<String, String>, Date> dateTransformers;
  final Transformer<Map<String, String>, String> narrationTransformers;
  final Transformer<Map<String, String>, String?>? payeeTransformers;
  final Transformer<Map<String, String>, String?>? commentsTransformers;

  // This should also ideally just be a single Transformer, no need for multiple
  final List<Transformer<Map<String, String>, (String, MetaValue)>>
      metaTransformers;
  final List<Transformer<Map<String, String>, PostingSpec>> postingTransformers;

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

  @override
  TransactionSpec transform(Map<String, String> input) {
    var values = input;
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
      meta: Map.fromEntries(
        metaTransformers.map((mt) {
          var tuple = mt.transform(values);
          return MapEntry(tuple.$1, tuple.$2);
        }),
      ),
      postings: ParallelTransformer<Map<String, String>, PostingSpec>(
              postingTransformers)
          .transform(values),
    );
  }

  @override
  String get typeId => 'TransactionTransformer';
}

class SeqTransformer<T, R> extends Transformer<T, R> {
  final List<Transformer> transformers;

  SeqTransformer(this.transformers) {
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

    if (currentType != R) {
      var currentTypeStr = currentType.toString();
      var returnTypeStr = R.toString();

      var currentTypeWithoutNull = currentTypeStr.replaceAll('?', '');
      var returnTypeWithoutNull = returnTypeStr.replaceAll('?', '');

      // It's acceptable if the ReturnType is nullable but the actual type being returned is not
      // but the reverse is not acceptable
      if (currentTypeWithoutNull != returnTypeWithoutNull) {
        throw Exception(
            'Invalid output type while validating transformers. Expected $R, got $currentType');
      }
      if (currentTypeStr.contains('?') && !returnTypeStr.contains('?')) {
        throw Exception(
            'Invalid output type while validating transformers. Expected $R, got $currentType');
      }
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
  String get typeId => 'SeqTransformer';

  @override
  List<Object?> get props => [transformers];
}

// Calls all the transformers on the input T independently, and gives a list of results
// This operation can be parallelized
class ParallelTransformer<T, R> extends Transformer<T, List<R>> {
  final List<Transformer<T, R>> transformers;

  ParallelTransformer(this.transformers);

  @override
  List<R> transform(T input) {
    return transformers.map((tr) => tr.transform(input)).toList();
  }

  @override
  String get typeId => 'ParallelTransformer';

  @override
  List<Object?> get props => [transformers];
}

abstract class Transformer<T, R> extends Equatable {
  R transform(T input);

  Type get inputType => T;
  Type get outputType => R;

  String get typeId;
}

class TransformerException<T> implements Exception {
  final Transformer tr;
  final T input;

  TransformerException(this.tr, this.input);

  @override
  String toString() {
    return 'TransformerException: failed on $input for $tr';
  }
}

class MapKeyMissingException extends TransformerException<Map<String, String>> {
  final String key;

  MapKeyMissingException(Map<String, String> input, this.key)
      : super(MapValueTransformer(key), input);

  @override
  String toString() {
    return 'MapKeyMissingException: key "$key" not found in $input';
  }
}

/// Fetches the value for the given key from the map
class MapValueTransformer extends Transformer<Map<String, String>, String> {
  final String key;

  MapValueTransformer(this.key);

  @override
  String transform(Map<String, String> input) {
    var val = input[key];
    if (val == null) {
      throw MapKeyMissingException(input, key);
    }
    return input[key]!;
  }

  @override
  String get typeId => 'MapValueTransformer';

  @override
  List<Object?> get props => [key];
}

/// This is a template class, as it's ignoring the input completely
/// and we want to be able to pass any kind of input
/// Normally either a String or Map<String, String>
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

class CurrencyTransformerFixed<T> extends Transformer<T, Currency> {
  final Currency currency;

  CurrencyTransformerFixed(this.currency);

  @override
  Currency transform(T input) {
    return currency;
  }

  @override
  String get typeId => 'CurrencyTransformerFixed';

  @override
  List<Object?> get props => [currency];
}

class CurrencyTransformer extends Transformer<String, Currency> {
  @override
  Currency transform(String input) {
    input = input.trim();
    if (resembesCurrency(input)) {
      return Currency(input);
    }

    throw Exception('Invalid currency');
  }

  @override
  String get typeId => 'CurrencyTransformer';

  @override
  List<Object?> get props => [];

  static bool resembesCurrency(String input) {
    input = input.trim();
    if (input.isEmpty || input.length > 24) return false;

    // From the beancount documentation
    // Technically, a currency name may be up to 24 characters long, and it must
    // start with a capital letter, must end with with a capital letter or number,
    // and its other characters must only be capital letters, numbers, or punctuation
    // limited to these characters: “'._-” (apostrophe, period, underscore, dash.
    var currencyRegExp = RegExp('[A-Z][A-Z0-9\'._-]+[A-Z0-9]');
    return currencyRegExp.hasMatch(input);
  }
}

class AmountTransformer extends Transformer<Map<String, String>, Amount> {
  final Transformer<Map<String, String>, Decimal> numberTransformer;
  final Transformer<Map<String, String>, Currency> currencyTransformer;

  AmountTransformer({
    required this.numberTransformer,
    required this.currencyTransformer,
  });

  @override
  Amount transform(Map<String, String> input) {
    var amount = numberTransformer.transform(input);
    var currency = currencyTransformer.transform(input);
    return Amount(amount, currency);
  }

  @override
  String get typeId => 'AmountTransformer';

  @override
  List<Object?> get props => [numberTransformer, currencyTransformer];
}

class AmountFromStringTransformer extends Transformer<String, Amount> {
  final Transformer<String, Decimal> numberTransformer;
  final Transformer<String, Currency> currencyTransformer;

  AmountFromStringTransformer({
    required this.numberTransformer,
    required this.currencyTransformer,
  });

  @override
  Amount transform(String input) {
    var amount = numberTransformer.transform(input);
    var currency = currencyTransformer.transform(input);
    return Amount(amount, currency);
  }

  @override
  String get typeId => 'AmountFromStringTransformer';

  @override
  List<Object?> get props => [numberTransformer, currencyTransformer];
}

class NoOpTransformer<T> extends Transformer<T, T> {
  @override
  T transform(T input) => input;

  @override
  List<Object?> get props => [];

  @override
  String get typeId => 'NoOpTransformer';
}

class NullTransformer<T, R> extends Transformer<T, R?> {
  @override
  R? transform(T input) {
    return null;
  }

  @override
  List<Object?> get props => [];

  @override
  String get typeId => 'NullTransformer';
}
