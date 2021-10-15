import 'package:plugs/cp/cp_const.dart';
import 'package:plugs/cp/cp_plug.dart';

import 'package:test/test.dart';

void main() async {
  //
  var plug = CpPlug('192.168.100.105:80', 8);

  test('getSensors', () async {
    var sensors = await plug.getSensors();
    print(sensors);
  });

  test('setSensors', () async {
    await plug.setSensors(cpSensors);
  });

  test('Snapshot', () async {
    print(await plug.snapshot());
  });

  test('getSample', () async {
    print(await plug.getSample());
  });

  test('setSample', () async {
    print(await plug.setSample(1, 1200));
  });
}
