import 'package:plugs/scp/Scp412.dart';
import 'package:test/test.dart';

void main() async {
  var plug = Scp412('192.168.100.111:8080');

  group('Field', () {
    test('Low State', () async {
      var fieldValue = false;

      // write new field value
      await plug.writeField(fieldValue);

      // read it back
      var val = await plug.readField();

      expect(val, fieldValue);
    });

    test('High State', () async {
      var fieldValue = true;

      // write new field value
      await plug.writeField(fieldValue);

      // read it back
      var val = await plug.readField();

      expect(val, fieldValue);
    });
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
      var snapshot = await plug.readSnapshot();

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
      var snapshot = await plug.readSnapshot();

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
      var snapshot = await plug.readSnapshot();

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
      var snapshot = await plug.readSnapshot();

      // expect all states are in Low
      expect(states, snapshot.output);
    });
  });
}
