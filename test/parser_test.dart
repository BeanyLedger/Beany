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
}

String p(String str) => parse(str).quoted_string().val();
