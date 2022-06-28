import 'package:gringotts/parser/parser.dart';
import 'package:test/test.dart';

void main() {
  test('Quoted String', () {
    expect(p('"Hello"'), "Hello");
    expect(p('"Hello/World"'), "Hello/World");
    expect(p('"foo"'), "foo");
    expect(p('""'), "");
    expect(p('"Róú\'s brithday"'), "Róú's brithday");

    // expect(p('"').isFailure, true);
    // expect(p('"dafsdf\nsafasdf"').isFailure, true);
  });

  test('Tags', () {
    expect(t('#hello #berlin-2014'), ["hello", "berlin-2014"]);
    expect(t('#bérlin-2014'), ["bérlin-2014"]);
  });
}

String p(String str) => parse(str).quoted_string().val();
List<String> t(String str) => parse(str).tags().val().toList();
