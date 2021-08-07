import 'package:plugs/plugs.dart';
import 'package:plugs/scp/Scp412.dart';
import 'package:test/test.dart';

void main() {
  group('Plug Tests', () async {
    final awesome = Awesome();
    final plug = Scp412('192.168.100.111:8080');
    print(await plug.readGroup());
    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      expect(awesome.isAwesome, isTrue);
    });
  });
}
