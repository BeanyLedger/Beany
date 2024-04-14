import 'package:beany_core/core/amount.dart';
import 'package:beany_core/core/cost_spec.dart';
import 'package:beany_core/core/currency.dart';
import 'package:beany_importer/src/csv_importer.dart';
import 'package:decimal/decimal.dart';

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
