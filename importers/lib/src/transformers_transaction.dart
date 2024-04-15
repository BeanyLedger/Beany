import 'package:beany_core/core/account.dart';
import 'package:beany_core/core/amount.dart';
import 'package:beany_core/core/cost_spec.dart';
import 'package:beany_core/core/meta_value.dart';
import 'package:beany_core/core/posting.dart';
import 'package:beany_core/core/price_spec.dart';
import 'package:beany_core/core/transaction.dart';
import 'package:beany_core/misc/date.dart';
import 'package:beany_importer/src/transformers.dart';

import 'package:meta/meta.dart';

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
