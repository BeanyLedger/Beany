import 'package:gringotts/core/statements.dart';
import 'package:gringotts/parser.dart';
import 'package:test/test.dart';

void main() {
  test('Include Parser', () {
    var input = 'include "../path"';
    var include = Include.parser.parse(input).value;

    expect(include.toString(), input);
    expect(include, Include('../path'));

    var transactions = parser.parse(input).value;
    var actual = transactions.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });

  test('Option Parser', () {
    var input = 'option "title" "Ed’s Personal Ledger"';
    var option = Option.parser.parse(input).value;

    expect(option.toString(), input);
    expect(option, Option('title', "Ed’s Personal Ledger"));

    var transactions = parser.parse(input).value;
    var actual = transactions.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });

  test('Comment Parser', () {
    var input = '; Hello';
    var comment = Comment.parser.parse(input).value;

    expect(comment.toString(), input);
    expect(comment, Comment('Hello'));

    var transactions = parser.parse(input).value;
    var actual = transactions.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });
}
