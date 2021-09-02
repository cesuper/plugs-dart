import 'package:plugs/smp/Smp.dart';
import 'package:plugs/smp/SmpTrigger.dart';
import 'package:test/test.dart';

void main() async {
  final tSampling = 5000;

  var plugs = <Smp>[
    Smp('192.168.100.111:8081'),
    Smp('192.168.100.111:8082'),
  ];

  group('Multiple-Sampling', () {
    test('Trigger', () async {
      // create common trigger
      var trigger = SmpTrigger(DateTime.now().microsecond, 100, tSampling);

      try {
        // send request and wait for response
        var results = await getResults(plugs, trigger);
        print(results);
      } catch (e) {
        print('plug error');
      }
    });
  });
}

Future<List<int>> getResults(List<Smp> plugs, SmpTrigger trigger) async {
  // trigger every plug
  await Future.wait(plugs.map((e) => e.setTrigger(trigger)), eagerError: true);

  // wait a bit
  await Future.delayed(Duration(milliseconds: trigger.time + 100));

  // get results
  var results = await Future.wait(plugs.map((e) => e.data()), eagerError: true);

  return results.map((e) => e.ts).toList();
}
