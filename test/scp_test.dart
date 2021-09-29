import 'package:plugs/scp/412/scp_412.dart';
import 'package:plugs/scp/ScpTriggerConfig.dart';
import 'package:test/test.dart';

void main() async {
  var plug = Scp412('192.168.100.106:80');

  test('State', () async {
    // read field and print
    print(await plug.state());
  });

  group('Output', () {
    test('High State', () async {
      // set all pins high
      var states = List<bool>.filled(plug.noOutputs, true);

      // timeout value
      var timeout = 500;

      // set all pins to high
      for (var i = 0; i < states.length; i++) {
        await plug.startPin(i, timeout);
      }

      // wait half of the timeout time
      await Future.delayed(Duration(milliseconds: timeout ~/ 2));

      // read it back and expect all states are high
      var snapshot = await plug.state();

      // expect all states are in high
      expect(states, snapshot.output);
    });
    test('Timed Low State', () async {
      // set all pins high
      var states = List<bool>.filled(plug.noOutputs, false);

      // timeout value
      var timeout = 500;

      // set all pins to high
      for (var i = 0; i < states.length; i++) {
        await plug.startPin(i, timeout);
      }

      // wait more than timeout value
      await Future.delayed(Duration(milliseconds: (timeout * 1.2).toInt()));

      // read it back and expect all states are high
      var snapshot = await plug.state();

      // expect all states are in Low
      expect(states, snapshot.output);
    });
  });

  group('Input', () {
    test('High State', () async {
      // set all pins high
      var states = List<bool>.filled(plug.noInputs, true);

      // timeout value
      var timeout = 500;

      // set all pins to high
      for (var i = 0; i < states.length; i++) {
        await plug.startPin(i, timeout, port: 0);
      }

      // wait half of the timeout time
      await Future.delayed(Duration(milliseconds: timeout ~/ 2));

      // read it back and expect all states are high
      var snapshot = await plug.state();

      // expect all states are in high
      expect(states, snapshot.input);
    });
    test('Timed Low State', () async {
      // set all pins high
      var states = List<bool>.filled(plug.noOutputs, false);

      // timeout value
      var timeout = 500;

      // set all pins to high
      for (var i = 0; i < states.length; i++) {
        await plug.startPin(i, timeout);
      }

      // wait more than timeout value
      await Future.delayed(Duration(milliseconds: (timeout * 1.2).toInt()));

      // read it back and expect all states are high
      var snapshot = await plug.state();

      // expect all states are in Low
      expect(states, snapshot.output);
    });
  }, skip: true);

  group('Config', () {
    test('Trigger', () async {
      // cfg
      var cfg =
          ScpTriggerConfig(true, '192.168.100.111:8010', '/api/trigger', 1500);

      // set new config
      await plug.setTriggerConfig(cfg);

      expect(await plug.triggerConfig(), equals(cfg));
    });
  });
}
