import 'package:plugs/smp/cp_sensor.dart';
import 'package:plugs/smp/smp.dart';
import 'package:plugs/smp/cp_sampling_request.dart';
import 'package:plugs/smp/smp8.dart';

import 'package:test/test.dart';

void main() async {
  var plugs = <Smp>[
    Smp8('192.168.100.111:8081'),
    Smp8('192.168.100.111:8082'),
  ];

  // sensors
  var sensors = <CpSensor>[
    CpSensor('5OCUGBGR', 12.0),
    CpSensor('5OETIN28', 13.9),
    CpSensor('50OAGBHN', 0.4),
  ];

  // request id
  var ts = DateTime.now().millisecondsSinceEpoch;

  // sampling freq
  var freq = 100;

  // sampling time
  var time = 5000;

  // create sampling request
  var req = CpSamplingRequest(ts, freq, time, sensors);

  group('Multi-Plug sampling', () {
    test('Trigger', () async {
      var s = Stopwatch()..start();
      try {
        // send request and wait for response
        var results = await Future.wait(plugs.map((e) => e.sample(req)));
      } catch (e) {
        print('plug error');
      }

      print(s.elapsedMilliseconds);
    });
  });
}
