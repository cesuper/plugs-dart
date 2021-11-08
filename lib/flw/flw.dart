import '../ain/ain.dart';
import '../ain/ain_api.dart';
import '../ain/ain_settings.dart';
import '../ain/ain_sensor_param.dart';
import '../plug/plug.dart';
import 'flw_sensor_param.dart';
import 'flw_settings.dart';
import 'flw_snapshot.dart';

class Flw extends Plug implements Ain {
  //
  final int _noAin;

  Flw(String address, {int noAin = 9})
      : _noAin = noAin,
        super(address);

  @override
  int get ainCount => _noAin;

  @override
  Future<FlwSnapshot> get snapshot => AinApi.getSnapshot<FlwSnapshot>(address);

  @override
  Future<List<FlwSensorParam>> get sensors =>
      AinApi.getSensors<FlwSensorParam>(address);

  @override
  Future<FlwSettings> get settings => AinApi.getSettings<FlwSettings>(address);

  @override
  Future<void> setSensors(List<AinSensorParam> sensors) =>
      AinApi.setSensors(address, sensors);

  @override
  Future<void> setSettings(AinSettings settings) =>
      AinApi.setSettings(address, settings);
}
