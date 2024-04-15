import 'package:beany_importer/src/transformers.dart';

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
