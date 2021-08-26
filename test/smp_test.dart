import 'package:plugs/smp/Smp.dart';
import 'package:plugs/smp/SmpChannel.dart';
import 'package:plugs/smp/SmpTrigger.dart';
import 'package:test/test.dart';

void main() async {
  var plug = Smp('192.168.100.111:8080');

  group('Channels', () {
    test('#1', () async {
      var channels = List<SmpChannel>.generate(
        5,
        (index) =>
            SmpChannel('serial-$index', double.parse('12.$index'), '#$index'),
      );

      // set channels
      await plug.setChannels(channels);

      expect(await plug.channels(), equals(channels));
    });
  });

  test('Snapshot', () async {
    var data = await plug.snapshot();
    print(data);
  });

  test('Buffer', () async {
    var data = await plug.readBuffer();
    print(data);
  });

  test('Buffer Status', () async {
    var data = await plug.readBufferStatus();
    print(data);
  });

  test('Trigger', () async {
    //
    var tSampling = 1500;
    var trigger = SmpTrigger(DateTime.now().millisecond, 100, tSampling);

    // start trigger
    expect(await plug.writeTrigger(trigger), 200);

    // expect buffer status TRUE
    expect(await plug.readBufferStatus(), true);

    // wait
    await Future.delayed(Duration(milliseconds: (tSampling + 500)));

    // expect buffer status FALSE
    expect(await plug.readBufferStatus(), false);

    // get data
    var data = await plug.readBuffer();
  }, skip: true);
}
