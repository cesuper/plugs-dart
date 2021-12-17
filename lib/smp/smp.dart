import 'package:plugs/ain/ain_api.dart';
import 'package:plugs/ain/ain_buffered.dart';
import 'package:plugs/ain/ain_snapshot.dart';
import 'package:plugs/ain/ain_settings.dart';
import 'package:plugs/ain/ain_sensor_param.dart';

import 'package:plugs/plug/plug.dart';

import 'smp_sensor_param.dart';
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
      AinApi.getSensors<SmpSensorParam>(address, timeout);

  @override
  Future<void> setSensors(List<AinSensorParam> sensors) async =>
      AinApi.setSensors(address, sensors, timeout);

  @override
  Future<void> setSettings(AinSettings settings) =>
      AinApi.setSettings(address, settings, timeout);

  @override
  Future<SmpSettings> get settings => AinApi.getSettings(address, timeout);

  @override
  Future<AinSnapshot> get snapshot =>
      AinApi.getSnapshot<SmpSnapshot>(address, timeout);

  @override
  Future<SmpSnapshot> buffer(int time) =>
      AinApi.buffer<SmpSnapshot>(address, time);

  @override
  Future<SmpSnapshot> get bufferedSnapshot =>
      AinApi.getSnapshot<SmpSnapshot>(address, timeout, isBuffered: true);
}
