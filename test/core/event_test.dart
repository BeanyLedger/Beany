import 'package:gringotts/core/event.dart';
import 'package:gringotts/parser.dart';
import 'package:test/test.dart';

void main() {
  test('Event Parser', () {
    expect(
      eventParser.parse('2013-11-03 event "location" "Paris, France"\n').value,
      Event(DateTime(2013, 11, 03), "location", "Paris, France"),
    );
  });
}
