import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class DataFrame extends Equatable {
  final IList<String> columnNames;
  final IList<IList<String>> data;

  DataFrame(this.columnNames, this.data) {
    if (columnNames.isEmpty) {
      throw ArgumentError('Column names should not be empty');
    }

    if (data.isEmpty) {
      throw ArgumentError('Data should not be empty');
    }

    if (columnNames.length != data.first.length) {
      throw ArgumentError('Column names and data should have the same length');
    }

    for (var row in data) {
      if (row.length != columnNames.length) {
        throw ArgumentError('All rows should have the same length');
      }
    }
  }

  int get nrows => data.length;
  int get ncols => columnNames.length;

  factory DataFrame.fromMap(List<Map<String, String>> listOfMaps) {
    if (listOfMaps.isEmpty) {
      throw ArgumentError('List of maps should not be empty');
    }
    var columnNames = listOfMaps.first.keys.toIList();

    // Ensure that each map has the same keys
    for (var map in listOfMaps) {
      if (map.keys.toSet() != columnNames.toSet()) {
        throw ArgumentError('All maps should have the same keys');
      }
    }

    var data = listOfMaps.map((e) => e.values.toIList()).toIList();
    return DataFrame(columnNames, data);
  }

  factory DataFrame.fromArray(List<List<String>> data,
      {bool hasHeader = true}) {
    if (data.isEmpty) {
      throw ArgumentError('List of lists should not be empty');
    }

    if (hasHeader) {
      var columnNames = data.first.toIList();
      return DataFrame(
          columnNames, data.skip(1).map((e) => e.toIList()).toIList());
    } else {
      var columnNames =
          List.generate(data.first.length, (index) => index.toString())
              .toIList();
      return DataFrame(columnNames, data.map((e) => e.toIList()).toIList());
    }
  }

  DataFrame removeColumn(String columnName) {
    var columnIndex = columnNames.indexOf(columnName);
    if (columnIndex == -1) {
      throw ArgumentError('Column $columnName not found');
    }

    var newColumnNames = columnNames.removeAt(columnIndex);
    var newData = data.map((row) => row.removeAt(columnIndex)).toIList();
    return DataFrame(newColumnNames, newData);
  }

  IList<String> series(String columnName) {
    var columnIndex = columnNames.indexOf(columnName);
    if (columnIndex == -1) {
      throw ArgumentError('Column $columnName not found');
    }

    return data.map((row) => row[columnIndex]).toIList();
  }

  IList<String> column(String columnName) => series(columnName);

  IMap<String, int> valueCounts(String columnName) {
    var columnIndex = columnNames.indexOf(columnName);
    if (columnIndex == -1) {
      throw ArgumentError('Column $columnName not found');
    }

    var values = column(columnName);
    return values.fold(
      IMap<String, int>(),
      (map, value) => map.update(
        value,
        (count) => count + 1,
        ifAbsent: () => 1,
      ),
    );
  }

  IMap<String, DataFrame> groupBy(String columnName) {
    var columnIndex = columnNames.indexOf(columnName);
    if (columnIndex == -1) {
      throw ArgumentError('Column $columnName not found');
    }

    var values = column(columnName).toISet();
    var result = <String, DataFrame>{};
    for (var value in values) {
      var newData = data.where((row) => row[columnIndex] == value).toIList();
      result[value] = DataFrame(columnNames, newData);
    }

    return result.toIMap();
  }

  @override
  String toString() {
    var header = columnNames.join(', ');
    var body = data.map((row) => row.join(', ')).join('\n');
    return '$header\n$body';
  }

  @override
  List<Object?> get props => [columnNames, data];
}
