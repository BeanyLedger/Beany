import 'package:beany_core/misc/date.dart';
import 'package:test/test.dart';

void main() {
  test("Test Date Equality", () {
    var dateTime = DateTime(2020, 1, 1);
    var date = Date(2020, 1, 1);
    expect(date == dateTime, true);
    expect(date, dateTime);
    expect(dateTime, equals(date));
  });
}
