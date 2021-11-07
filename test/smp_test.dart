import 'package:plugs/cp/smp_const.dart';
import 'package:plugs/cp/smp.dart';

import 'package:test/test.dart';

void main() async {
  //
  var plug = Smp('192.168.100.110:80', 8);

  test('getSensors', () async {
    var sensors = await plug.sensors;
    print(sensors);
  });

  test('setSensors', () async {
    await plug.setSensors(smpSensors);
  });

  test('Snapshot', () async {
    print(await plug.snapshot);
  });

  test('get buffer', () async {
    print(await plug.bufferedSnapshot);
  });

  test('setSample', () async {
    await plug.buffer();
  });
}
