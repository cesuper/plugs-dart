import 'package:plugs/smp/Smp.dart';
import 'package:plugs/smp/SmpSensor.dart';
import 'package:plugs/smp/SmpTrigger.dart';
import 'package:test/test.dart';

void main() async {
  // plug
  var plug = Smp('192.168.100.111:8080');

  // sensors
  var sensors = <SmpSensor>[
    SmpSensor('5OCUGBGR', 12.0),
    SmpSensor('5OETIN28', 13.9),
    SmpSensor('50OAGBHN', 0.4),
  ];

  // test('Sensors', () async {
  //   // set channels
  //   await plug.setSensors(sensors);
  //   expect(await plug.sensors(), equals(sensors));
  // });

  test('Trigger', () async {
    // setup sensors
    await plug.setSensors(sensors);
    expect(await plug.sensors(), equals(sensors));

    // set sampling value
    var tSampling = 1500;

    // get ignored trigger
    var smpInfo = await plug.readSmpInfo();

    // create trigger param
    var trigger = SmpTrigger(DateTime.now().millisecond, 100, tSampling);

    // start trigger and expect success code
    expect(await plug.setTrigger(trigger), 200);

    // expect buffer status TRUE
    expect(await plug.triggerStatus(), true);

    // start trigger and expect in-progress code
    expect(await plug.setTrigger(trigger), 500);

    // check ignoredtriggers increase by 1
    expect((await plug.readSmpInfo()).ignoredTriggers,
        smpInfo.ignoredTriggers + 1);

    // wait
    await Future.delayed(Duration(milliseconds: (tSampling + 500)));

    // expect buffer status FALSE
    expect(await plug.triggerStatus(), false);

    // get data
    var data = await plug.data();

    // check ts
    expect(data.ts, trigger.ts);

    // check sensors
    expect(data.sensors.map((e) => e.serial),
        equals(sensors.map((e) => e.serial)));

    // check data count
    expect(
        data.sensors.first.p.length, (trigger.freq / 1000) * trigger.tSampling);

    print(data);
  });
}
