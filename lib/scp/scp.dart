import '../dio/dio.dart';
import '../dio/dio_api.dart';
import '../plug/plug.dart';
import '../ain/ain_buffered.dart';
import '../ain/ain_api.dart';
import '../ain/ain_snapshot.dart';
import '../ain/ain_settings.dart';
import '../ain/ain_sensor.dart';

import 'scp_ain_settings.dart';
import 'scp_ain_snapshot.dart';
import 'scp_ain_sensor.dart';

abstract class Scp extends Plug implements AinBuffered, Dio {
  //
  @override
  final int diCount;

  //
  @override
  final int doCount;

  //
  @override
  final int ainCount;

  Scp(String address, this.diCount, this.doCount, this.ainCount)
      : super(address);

  @override
  Future<ScpAinSnapshot> get snapshot =>
      AinApi.getSnapshot<ScpAinSnapshot>(address);

  @override
  Future<List<ScpAinSensor>> get sensors =>
      AinApi.getSensors<ScpAinSensor>(address);

  @override
  Future<ScpAinSettings> get settings =>
      AinApi.getSettings<ScpAinSettings>(address);

  @override
  Future<AinSnapshot> get bufferedSnapshot =>
      AinApi.getSnapshot<ScpAinSnapshot>(address, isBuffered: true);

  @override
  Future<int> setSensors(List<AinSensor> sensors) async =>
      AinApi.setSensors(address, sensors);

  @override
  Future<void> setSettings(AinSettings settings) =>
      AinApi.setSettings(address, settings);

  @override
  Future<bool> buffer() => AinApi.buffer(address);

  //
  // dio
  //

  ///
  @override
  Future<List<bool>> get input => DioApi.getInput(address);

  ///
  @override
  Future<bool> get field => DioApi.getField(address);

  ///
  @override
  Future<List<bool>> get output => DioApi.getOutput(address);

  ///
  @override
  Future<int> startPin(int pin, int timeout, {int delay = 0}) =>
      DioApi.startPin(address, pin, timeout, delay: delay);

  ///
  @override
  Future<int> stopPin(int pin) => DioApi.stopPin(address, pin);
}
