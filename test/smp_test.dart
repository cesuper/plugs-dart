import 'package:plugs/smp/Smp.dart';
import 'package:plugs/smp/CpSensor.dart';
import 'package:test/test.dart';

void main() async {
  // plug
  var plug = Smp('192.168.100.111:8081');

  // sensors
  var sensors = <CpSensor>[
    CpSensor('5OCUGBGR', 12.0),
    CpSensor('5OETIN28', 13.9),
    CpSensor('50OAGBHN', 0.4),
  ];

  test('Trigger', () async {
    // setup sensors
    // await plug.setSensors(sensors);

    // expect(await plug.sensors(), equals(sensors));

    // // set sampling value
    // var tSampling = 1500;

    // // create trigger param
    // var trigger = SmpTrigger(DateTime.now().millisecond, 100, tSampling);

    // // get data
    // var data = await plug.sample(trigger);

    // // check ts
    // expect(data.ts, trigger.ts);

    // // check responses
    // var responseParams =
    //     data.sensors.map((e) => CpSensor(e.serial, e.area)).toList();

    // expect(sensors, equals(responseParams));

    // // check data count
    // expect(data.sensors.first.p.length, (trigger.freq / 1000) * trigger.time);

    // print(data);
  });
}
