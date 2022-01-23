// ignore_for_file: avoid_print

import 'package:plugs/api.dart';
import 'package:test/test.dart';

void main() async {
  //
  var client = PlugClient('http://192.168.100.101');
  final api = client.getFlwPlugApi();

  test('Read', () async {
    final state = await api.getState();
    print(state);
  });

  test('Write', () async {
    //
    final state = await api.getState();
    print(state);

    final newState = FlwPlugState(1500, state.sensors);
    print(newState);

    // set new
    await api.setState(newState);

    print(await api.getState());
  });
}
