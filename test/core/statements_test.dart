import 'package:test/test.dart';

import 'package:gringotts/core/statements.dart';
import 'package:gringotts/parser/parser.dart';

void main() {
  test('Include Parser', () {
    var input = 'include "../path"';
    var include = parse(input).includeStatement().val();

    expect(include.toString(), input);
    expect(include, Include('../path'));

    var transactions = parse(input).all().val();
    var actual = transactions.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });

  test('Option Parser', () {
    var input = 'option "title" "Ed’s Personal Ledger"';
    var option = parse(input).optionStatement().val();

    expect(option.toString(), input);
    expect(option, Option('title', "Ed’s Personal Ledger"));

    var transactions = parse(input).all().val();
    var actual = transactions.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });

  test('Comment Parser', () {
    var input = '; Hello';
    var comment = parse(input).commentStatement().val();

    expect(comment.toString(), input);
    expect(comment, Comment('Hello'));

    var transactions = parse(input).all().val();
    var actual = transactions.map((t) => t.toString()).join("\n");
    expect(actual, input);
  });
}
