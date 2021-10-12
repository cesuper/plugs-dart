import 'package:plugs/flw/flw_plug_cfg.dart';
import 'package:plugs/flw/flw_plug.dart';
import 'package:plugs/flw/flw_sensor.dart';

import 'package:test/test.dart';

void main() async {
  var plug = FlwPlug('192.168.100.107:80');

  // test('Read Channels from Socket', () async {
  //   var channels = await plug.readChannels();

  //   print(channels);
  // });

  // test('Write Channels to Socket', () async {
  //   // channels to read
  //   var channels = cpChannels;

  //   await plug.writeChannels(channels);
  // });

  test('Read Config', () async {
    var cfg = await plug.readConfig();
    print(cfg);
  });

  test('Write Config', () async {
    var sensors = <FlwSensor>[
      FlwSensor('994559880192100081'),
      FlwSensor('994559880192100105'),
    ];
    var cfg = FlwPlugCfg(sensors);

    await plug.writeConfig(cfg);
  });

  test('Sampling test', () async {
    var snapshot = await plug.snapshot();
    print(snapshot);
  });
}
