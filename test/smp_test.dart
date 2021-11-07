import 'package:plugs/cp/smp_const.dart';
import 'package:plugs/cp/smp.dart';

import 'package:test/test.dart';

void main() async {
  //
  var plug = Smp('192.168.100.110:80', 8);
  for (var i = 0; i < 100; i++) {
    test('getSensors', () async {
      var sensors = await plug.sensors;
      //print(sensors);
    });

    test('getSettings', () async {
      var settings = await plug.settings;
      //print(settings);
    });

    test('Snapshot', () async {
      var snapshot = await plug.snapshot;
      //print(snapshot);
    });

    test('getbufferedSnapshot', () async {
      var bufferedSnapshot = await plug.bufferedSnapshot;
      //print(bufferedSnapshot);
    });

    test('setSensors', () async {
      await plug.setSensors(smpSensors);
    });

    test('buffer', () async {
      await plug.buffer();
    });
  }
}
