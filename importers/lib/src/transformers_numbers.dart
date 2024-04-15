import 'package:beany_importer/src/transformers.dart';
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

class NumberTransformerDecimalComma extends Transformer<String, Decimal> {
  @override
  Decimal transform(String input) {
    try {
      input = input.trim();
      input = input.replaceAll('.', '').replaceAll(',', '.');
      return Decimal.parse(input);
    } catch (ex) {
      throw TransformerException(this, input);
    }
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
