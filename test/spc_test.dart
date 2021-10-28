import 'package:plugs/scp/scp_442.dart';
import 'package:test/test.dart';

void main() async {
  //
  var plug = Scp442('192.168.100.108:80');

  test('field', () async {
    print(await plug.field());
  });

  test('input', () async {
    var data = await plug.digitalInput();
    print(data);
  });

  test('output', () async {
    var data = await plug.digitalOutput();
    print(data);
  });

  test('start pin', () async {
    await plug.startPin(0, 8000);
  });

  test('stop pin', () async {
    await plug.startPin(0, 8000);
    await Future.delayed(const Duration(seconds: 2));
    await plug.stopPin(0);
  });
}
