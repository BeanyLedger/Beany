import 'package:gringotts/core/event.dart';
import 'package:gringotts/parser.dart';
import 'package:test/test.dart';

void main() {
  test('Event Parser', () {
    var input = '2013-11-03 event "location" "Paris, France"';
    var event = Event.parser.parse(input).value;

    expect(event.toString(), input);
    expect(event, Event(DateTime(2013, 11, 03), "location", "Paris, France"));

    var transactions = parser.parse(input).value;
    var actual = transactions.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });
}
