import 'package:plugs/plugs.dart';
import 'package:test/test.dart';

void main() {
  group('Plug Tests', () {
    final awesome = Awesome();

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      expect(awesome.isAwesome, isTrue);
    });
  });
}
