import 'package:beany_core/core/amount.dart';
import 'package:beany_core/core/cost_spec.dart';
import 'package:beany_importer/src/transformers.dart';

class CostSpecAmountPerTransformer extends Transformer<Amount, CostSpec> {
  CostSpecAmountPerTransformer();

  @override
  List<Object?> get props => [];

  @override
  CostSpec transform(Amount input) {
    return CostSpec(amountPer: input);
  }

  @override
  String get typeId => 'CostSpecAmountPerTransformer';
}

class CostSpecAmountTotalTransformer extends Transformer<Amount, CostSpec> {
  CostSpecAmountTotalTransformer();

  @override
  List<Object?> get props => [];

  @override
  CostSpec transform(Amount input) {
    return CostSpec(amountTotal: input);
  }

  @override
  String get typeId => 'CostSpecAmountTotalTransformer';
}
