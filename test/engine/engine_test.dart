import 'package:beany/core/account.dart';
import 'package:beany/core/open.dart';
import 'package:beany/engine/engine.dart';
import 'package:test/test.dart';

void main() {
  test('Include Files', () async {
    var filePath = 'test/testdata/root.beancount';
    var engine = await Engine.loadRootFile(filePath);

    var accountOpen = Open(DateTime(2013, 01, 01), Account('Assets:Work:N26'));
    expect(engine.statements, contains(accountOpen));

    /*
    for (var statement in engine.statements) {
      print(statement);
    }
    */
  });
}
