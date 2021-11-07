import '../ain/ain.dart';
import '../ain/ain_api.dart';
import '../ain/ain_settings.dart';
import '../ain/ain_sensor.dart';
import '../plug/plug.dart';
import 'flw_sensor.dart';
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
  Future<List<FlwSensor>> get sensors => AinApi.getSensors<FlwSensor>(address);

  @override
  Future<FlwSettings> get settings => AinApi.getSettings<FlwSettings>(address);

  @override
  Future<void> setSensors(List<AinSensor> sensors) =>
      AinApi.setSensors(address, sensors);

  @override
  Future<void> setSettings(AinSettings settings) =>
      AinApi.setSettings(address, settings);
}
