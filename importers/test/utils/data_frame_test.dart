import 'package:beany_importer/src/utils/data_frame.dart';
import 'package:test/test.dart';

void main() {
  test('GroupBy', () {
    var df = DataFrame.fromArray([
      ['outlook', 'temperature', 'play'],
      ['sunny', 'hot', 'no'],
      ['sunny', 'hot', 'no'],
      ['overcast', 'hot', 'yes'],
      ['rainy', 'mild', 'yes'],
      ['rainy', 'cool', 'yes'],
      ['rainy', 'cool', 'no'],
      ['overcast', 'cool', 'yes'],
      ['sunny', 'mild', 'no'],
      ['sunny', 'cool', 'yes'],
      ['rainy', 'mild', 'yes'],
      ['sunny', 'mild', 'yes'],
      ['overcast', 'mild', 'yes'],
      ['overcast', 'hot', 'yes'],
      ['rainy', 'mild', 'no'],
    ]);

    var grouped = df.groupBy('outlook');
    expect(grouped.keys, ['sunny', 'overcast', 'rainy']);

    var sunny = DataFrame.fromArray([
      ['outlook', 'temperature', 'play'],
      ['sunny', 'hot', 'no'],
      ['sunny', 'hot', 'no'],
      ['sunny', 'mild', 'no'],
      ['sunny', 'cool', 'yes'],
      ['sunny', 'mild', 'yes'],
    ]);
    expect(grouped['sunny'], sunny);

    var overcast = DataFrame.fromArray([
      ['outlook', 'temperature', 'play'],
      ['overcast', 'hot', 'yes'],
      ['overcast', 'cool', 'yes'],
      ['overcast', 'mild', 'yes'],
      ['overcast', 'hot', 'yes'],
    ]);
    expect(grouped['overcast'], overcast);

    var rainy = DataFrame.fromArray([
      ['outlook', 'temperature', 'play'],
      ['rainy', 'mild', 'yes'],
      ['rainy', 'cool', 'yes'],
      ['rainy', 'cool', 'no'],
      ['rainy', 'mild', 'yes'],
      ['rainy', 'mild', 'no'],
    ]);
    expect(grouped['rainy'], rainy);
  });
}
