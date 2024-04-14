import 'package:beany_core/core/amount.dart';
import 'package:beany_core/core/price_spec.dart';
import 'package:beany_importer/src/csv_importer.dart';

class PriceSpecPerTransformer extends Transformer<Amount, PriceSpec> {
  PriceSpecPerTransformer();

  @override
  List<Object?> get props => [];

  @override
  PriceSpec transform(Amount input) {
    return PriceSpec(amountPer: input);
  }

  @override
  String get typeId => 'PriceSpecPerTransformer';
}

class PriceSpecTotalTransformer extends Transformer<Amount, PriceSpec> {
  PriceSpecTotalTransformer();

  @override
  List<Object?> get props => [];

  @override
  PriceSpec transform(Amount input) {
    return PriceSpec(amountTotal: input);
  }

  @override
  String get typeId => 'PriceSpecTotalTransformer';
}
