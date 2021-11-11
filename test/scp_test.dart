// ignore_for_file: avoid_print

import 'package:plugs/scp/scp_442.dart';
import 'package:plugs/scp/scp_const.dart';
import 'package:test/test.dart';

void main() async {
  //
  var plug = Scp442('192.168.100.109:80');

  test('field', () async {
    print(await plug.field);
  });

  test('input', () async {
    var data = await plug.input;
    print(data);
  });

  test('output', () async {
    var data = await plug.output;
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

  test('ain sensor params', () async {
    // set
    await plug.setSensors(scpSensorParams);

    var sensors = await plug.sensors;
    print(sensors);
  });

  test('Settings', () async {
    print(await plug.settings);
  });
}
