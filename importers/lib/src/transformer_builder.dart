import 'package:beany_core/core/amount.dart';
import 'package:beany_core/core/cost_spec.dart';
import 'package:beany_core/core/currency.dart';
import 'package:beany_core/core/meta_value.dart';
import 'package:beany_core/core/posting.dart';
import 'package:beany_core/core/price_spec.dart';
import 'package:beany_core/core/transaction.dart';
import 'package:beany_core/misc/date.dart';
import 'package:beany_importer/src/csv_importer.dart';
import 'package:beany_importer/src/transformers_cost.dart';
import 'package:beany_importer/src/transformers_price.dart';
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
  Iterable<Transformer<String, Currency>> build(String input, Currency output) {
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

class CostSpecTransformerBuilder
    extends TransformerBuilder<Map<String, String>, CostSpec> {
  @override
  Iterable<Transformer<Map<String, String>, CostSpec>> build(
    Map<String, String> input,
    CostSpec output,
  ) sync* {
    var amountPer = output.amountPer;
    if (amountPer != null) {
      var builder = AmountTransformerBuilder();
      var transformers = builder.build(input, amountPer);
      for (var tr in transformers) {
        yield SeqTransformer([
          tr,
          CostSpecAmountPerTransformer(),
        ]);
      }
    }

    var amountTotal = output.amountTotal;
    if (amountTotal != null) {
      var builder = AmountTransformerBuilder();
      var transformers = builder.build(input, amountTotal);
      for (var tr in transformers) {
        yield SeqTransformer([
          tr,
          CostSpecAmountTotalTransformer(),
        ]);
      }
    }
  }

  @override
  List<Object?> get props => [];

  @override
  String get typeId => 'CostSpecTransformerBuilder';
}

class PriceSpecTransformerBuilder
    extends TransformerBuilder<Map<String, String>, PriceSpec> {
  @override
  Iterable<Transformer<Map<String, String>, PriceSpec>> build(
    Map<String, String> input,
    PriceSpec output,
  ) sync* {
    var amountPerSpec = output.amountPer;
    if (amountPerSpec != null) {
      if (!amountPerSpec.canResolve) {
        throw Exception('AmountPer must be resolvable for PriceSpec Builder');
      }
      var amount = amountPerSpec.toAmount();

      var builder = AmountTransformerBuilder();
      var transformers = builder.build(input, amount);
      for (var tr in transformers) {
        yield SeqTransformer([
          tr,
          PriceSpecPerTransformer(),
        ]);
      }
    }

    var amountTotalSpec = output.amountTotal;
    if (amountTotalSpec != null) {
      if (!amountTotalSpec.canResolve) {
        throw Exception('AmountPer must be resolvable for PriceSpec Builder');
      }
      var amount = amountTotalSpec.toAmount();

      var builder = AmountTransformerBuilder();
      var transformers = builder.build(input, amount);
      for (var tr in transformers) {
        yield SeqTransformer([
          tr,
          PriceSpecTotalTransformer(),
        ]);
      }
    }
  }

  @override
  List<Object?> get props => [];

  @override
  String get typeId => 'PriceSpecTransformerBuilder';
}

class PostingTransformerBuilder
    extends TransformerBuilder<Map<String, String>, PostingSpec> {
  PostingTransformerBuilder();

  @override
  String get typeId => 'PostingTransformerBuilder';

  @override
  List<Object?> get props => [];

  @override
  Iterable<Transformer<Map<String, String>, PostingSpec>> build(
    Map<String, String> input,
    PostingSpec output,
  ) sync* {
    // For now, we're just assuming the account to be fixed
    var expectedAccount = output.account;
    var accountTransformer = AccountTransformerFixed<Map<String, String>>(
      expectedAccount.value,
    );

    if (output.amount == null) {
      yield PostingTransformer(accountTransformer: accountTransformer);
      return;
    }

    var amount = output.amount!;
    var amountBuilder = AmountTransformerBuilder();
    var amountTransformers = amountBuilder.build(input, amount);

    var costSpecTransformers = <Transformer<Map<String, String>, CostSpec?>>[];
    var costSpec = output.costSpec;
    if (costSpec != null) {
      var costSpecBuilder = CostSpecTransformerBuilder();
      costSpecTransformers = costSpecBuilder.build(input, costSpec).toList();
    } else {
      var tr = NullTransformer<Map<String, String>, CostSpec>();
      costSpecTransformers.add(tr);
    }

    var priceSpecTransformers =
        <Transformer<Map<String, String>, PriceSpec?>>[];
    var priceSpec = output.priceSpec;
    if (priceSpec != null) {
      var priceSpecBuilder = PriceSpecTransformerBuilder();
      priceSpecTransformers = priceSpecBuilder.build(input, priceSpec).toList();
    } else {
      var tr = NullTransformer<Map<String, String>, PriceSpec>();
      priceSpecTransformers.add(tr);
    }

    for (var amountTr in amountTransformers) {
      for (var costSpecTr in costSpecTransformers) {
        for (var priceSpecTr in priceSpecTransformers) {
          yield PostingTransformer(
            accountTransformer: accountTransformer,
            amountTransformer: amountTr,
            costSpecTransformer: costSpecTr,
            priceSpecTransformer: priceSpecTr,
          );
        }
      }
    }
  }
}

class MetaValueTransformerBuilder
    extends TransformerBuilder<Map<String, String>, MetaValue> {
  MetaValueTransformerBuilder();

  @override
  String get typeId => 'MetaValueTransformerBuilder';

  @override
  List<Object?> get props => [];

  @override
  Iterable<Transformer<Map<String, String>, MetaValue>> build(
    Map<String, String> input,
    MetaValue output,
  ) sync* {
    if (output.stringValue == null) {
      throw Exception('MetaValue must have a string value');
    }

    var valueBuilder = MapIteratorTransformerBuilder(
      builder: StringMatchingTransformerBuilder(),
    );
    var valueTransformers = valueBuilder.build(input, output.stringValue!);
    for (var valueTr in valueTransformers) {
      yield SeqTransformer([
        valueTr,
        MetaValueTransformer(),
      ]);
    }

    return;
  }
}

class MetaDataEntryTransformerBuilder
    extends TransformerBuilder<Map<String, String>, (String, MetaValue)> {
  MetaDataEntryTransformerBuilder();

  @override
  String get typeId => 'MetaDataEntryTransformerBuilder';

  @override
  List<Object?> get props => [];

  @override
  Iterable<Transformer<Map<String, String>, (String, MetaValue)>> build(
    Map<String, String> input,
    (String, MetaValue) output,
  ) sync* {
    var keyTransformer = StringTransformerFixed<Map<String, String>>(output.$1);
    var valueTransformerBuilder = MetaValueTransformerBuilder();
    var valueTransformers = valueTransformerBuilder.build(input, output.$2);

    for (var valueTr in valueTransformers) {
      yield MetaDataEntryTransformer(
        keyTransformer: keyTransformer,
        valueTransformer: valueTr,
      );
    }
  }
}

class MetaDataTransformerBuilder {
  MetaDataTransformerBuilder();

  Iterable<List<Transformer<Map<String, String>, (String, MetaValue)>>> build(
    Map<String, String> input,
    Map<String, MetaValue> output,
  ) sync* {
    var transformers =
        <Iterable<Transformer<Map<String, String>, (String, MetaValue)>>>[];

    var builder = MetaDataEntryTransformerBuilder();
    for (var entry in output.entries) {
      var trList = builder.build(input, (entry.key, entry.value));
      transformers.add(trList);
    }

    if (transformers.length == 1) {
      for (var tr0 in transformers[0]) {
        yield [tr0];
      }
      return;
    }
    if (transformers.length == 2) {
      for (var tr0 in transformers[0]) {
        for (var tr1 in transformers[1]) {
          yield [tr0, tr1];
        }
      }
      return;
    }
    if (transformers.length == 3) {
      for (var tr0 in transformers[0]) {
        for (var tr1 in transformers[1]) {
          for (var tr2 in transformers[2]) {
            yield [tr0, tr1, tr2];
          }
        }
      }
      return;
    }
  }
}

class MultiTransformerProduct<T> {
  final TransformerBuilder<Map<String, String>, T> builder;

  MultiTransformerProduct({required this.builder});

  Iterable<List<Transformer<Map<String, String>, T>>> build(
    Map<String, String> input,
    List<T> output,
  ) sync* {
    // So we get a list of transformers for each item
    // and then we need to do a product of all of them
    var transformers = <Iterable<Transformer<Map<String, String>, T>>>[];

    for (var out in output) {
      var trList = builder.build(input, out);
      transformers.add(trList);
    }

    // How do I simplify this code and make it more abstract?
    if (transformers.length == 1) {
      for (var tr0 in transformers[0]) {
        yield [tr0];
      }
      return;
    }
    if (transformers.length == 2) {
      for (var tr0 in transformers[0]) {
        for (var tr1 in transformers[1]) {
          yield [tr0, tr1];
        }
      }
      return;
    }
    if (transformers.length == 3) {
      for (var tr0 in transformers[0]) {
        for (var tr1 in transformers[1]) {
          for (var tr2 in transformers[2]) {
            yield [tr0, tr1, tr2];
          }
        }
      }
      return;
    }
  }
}

class TransactionTransformerBuilder
    extends TransformerBuilder<Map<String, String>, TransactionSpec> {
  TransactionTransformerBuilder();

  @override
  String get typeId => 'TransactionTransformerBuilder';

  @override
  List<Object?> get props => [];

  @override
  Iterable<Transformer<Map<String, String>, TransactionSpec>> build(
    Map<String, String> input,
    TransactionSpec output,
  ) sync* {
    var dateBuilder = MapIteratorTransformerBuilder(
      builder: DateTransformerBuilder(),
    );
    var narrationBuilder = MapIteratorTransformerBuilder(
      builder: StringMatchingTransformerBuilder(),
    );
    var payeeBuilder = MapIteratorTransformerBuilder(
      builder: StringMatchingTransformerBuilder(),
    );
    var commentBuilder = MapIteratorTransformerBuilder(
      builder: StringMatchingTransformerBuilder(),
    );
    var metaBuilder = MetaDataTransformerBuilder();
    var postingsBuilder = MultiTransformerProduct(
      builder: PostingTransformerBuilder(),
    );

    var dateTransformers = dateBuilder.build(input, Date.truncate(output.date));
    var narrationTransformers = narrationBuilder.build(input, output.narration);
    var payeeTransformers = output.payee != null
        ? payeeBuilder.build(input, output.payee!).toList()
        : <Transformer<Map<String, String>, String?>>[
            NullTransformer<Map<String, String>, String?>(),
          ];

    // FIXME: This is a big hack to support comments
    //        as the comments are sometimes parsed as the Posting's preComments
    //        The entire TrasnactionSpec needs to be changed
    //        to be able to address comments better
    //        Comments can also come between metadata lines
    var comments = output.comments;
    if (comments.isEmpty) {
      if (output.postings.isNotEmpty) {
        comments = output.postings[0].preComments;
      }
    }
    var commentsTransformers = comments.isNotEmpty
        ? commentBuilder.build(input, comments[0]).toList()
        : <Transformer<Map<String, String>, String?>>[
            NullTransformer<Map<String, String>, String?>(),
          ];
    var metaTransformers =
        metaBuilder.build(input, output.meta.unlockView).toList();
    if (metaTransformers.isEmpty) {
      metaTransformers.add([]);
    }
    var postingTransformers =
        postingsBuilder.build(input, output.postings.unlockView);

    for (var dateTr in dateTransformers) {
      for (var narrationTr in narrationTransformers) {
        for (var payeeTr in payeeTransformers) {
          for (var commentTr in commentsTransformers) {
            for (var metaTr in metaTransformers) {
              for (var postingTrs in postingTransformers) {
                yield TransactionTransformer(
                  dateTransformers: dateTr,
                  narrationTransformers: narrationTr,
                  payeeTransformers: payeeTr,
                  metaTransformers: metaTr,
                  postingTransformers: postingTrs,
                  commentsTransformers: commentTr,
                );
              }
            }
          }
        }
      }
    }
  }
}




// With this, we then need a TransformerSimplifier which removes the NoOpTransformers
// and combines the SeqTransformers, if possible
// and removes the NullTransformers

// Maybe the way to reduce the number of solutions is to ask for more data
// instead of applying heuristics to the data?
// How do we communicate what extra data is required in order to reduce the number of solutions?
// This isn't trivial!
