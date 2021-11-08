import 'package:plugs/ain/ain_api.dart';
import 'package:plugs/ain/ain_buffered.dart';
import 'package:plugs/ain/ain_snapshot.dart';
import 'package:plugs/ain/ain_settings.dart';
import 'package:plugs/ain/ain_sensor_param.dart';

import 'package:plugs/plug/plug.dart';

import 'smp_sensor.dart';
import 'smp_settings.dart';
import 'smp_snapshot.dart';

class Smp extends Plug implements AinBuffered {
//
  @override
  final int ainCount;

  /// Returns the excitation voltage used for strain gauges
  Future<double> readExcVoltage() async {
    return 5.0;
  }

  Smp(String address, this.ainCount) : super(address);

  @override
  Future<List<AinSensorParam>> get sensors =>
      AinApi.getSensors<SmpSensor>(address);

  @override
  Future<void> setSensors(List<AinSensorParam> sensors) async =>
      AinApi.setSensors(address, sensors);

  @override
  Future<void> setSettings(AinSettings settings) =>
      AinApi.setSettings(address, settings);

  @override
  Future<SmpSettings> get settings => AinApi.getSettings(address);

  @override
  Future<AinSnapshot> get snapshot => AinApi.getSnapshot<SmpSnapshot>(address);

  @override
  Future<void> buffer() => AinApi.buffer(address);

  @override
  Future<AinSnapshot> get bufferedSnapshot =>
      AinApi.getSnapshot<SmpSnapshot>(address, isBuffered: true);
}
