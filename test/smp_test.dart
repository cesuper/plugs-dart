import 'package:plugs/smp/Smp.dart';
import 'package:plugs/smp/CpSensor.dart';
import 'package:plugs/smp/SmpSamplingRequest.dart';
import 'package:test/test.dart';

void main() async {
  // plug
  var plug = Smp('192.168.100.105');
  //var plug = Smp('192.168.100.111:8081');

  // sensors
  var sensors = <CpSensor>[
    CpSensor('5OCUGBGR', 12.0),
    CpSensor('5OETIN28', 13.9),
    CpSensor('50OAGBHN', 0.4),
  ];

  test('Trigger', () async {
    // request id
    var ts = DateTime.now().millisecondsSinceEpoch;

    // sampling freq
    var freq = 100;

    // sampling time
    var time = 100;

    // create sampling request
    var req = SmpSamplingRequest(ts, freq, time, sensors);

    // get data
    var res = await plug.sample(req);

    // check ts
    expect(res.ts, ts);

    // expect no error
    expect(res.error, 0);

    // expect serial equaliy
    expect(sensors.map((e) => e.serial).toList(),
        equals(res.sensors.map((e) => e.serial)));

    // check data count
    expect(res.sensors.first.p.length, (freq / 1000) * time);

    print(res);
  });
}
