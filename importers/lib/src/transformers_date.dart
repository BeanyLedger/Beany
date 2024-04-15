import 'package:beany_core/misc/date.dart';
import 'package:beany_importer/src/transformers.dart';
import 'package:intl/intl.dart';

class DateTransformerExcel extends Transformer<String, Date> {
  DateTransformerExcel();

  @override
  Date transform(String input) {
    input = input.trim();
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
