import 'package:beany_importer/src/csv_importer.dart';
import 'package:decimal/decimal.dart';

class NumberAddingTransformer
    extends Transformer<Map<String, String>, Decimal> {
  final List<String> fields;
  final Transformer<String, Decimal> numberTransformer;

  NumberAddingTransformer({
    required this.fields,
    required this.numberTransformer,
  });

  @override
  List<Object?> get props => [fields];

  @override
  Decimal transform(Map<String, String> input) {
    var total = Decimal.zero;
    for (var field in fields) {
      var val = input[field];
      if (val == null) {
        throw MapKeyMissingException(input, field);
      }
      total += numberTransformer.transform(val);
    }

    return total;
  }

  @override
  String get typeId => 'NumberAddingTransformer';
}
