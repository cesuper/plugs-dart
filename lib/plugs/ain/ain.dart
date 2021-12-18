import 'ain_sensor_param.dart';
import 'ain_settings.dart';
import 'ain_snapshot.dart';

abstract class Ain {
  /// Returns the size of analog input
  int get ainCount;

  /// Returns a snapshot of the sensor data
  Future<AinSnapshot> get snapshot;

  /// Returns the sensor parameters being used
  Future<List<AinSensorParam>> get sensors;

  /// Sets the sensor parameters
  Future<int> setSensors(List<AinSensorParam> sensors);

  /// Returns the settings structure
  Future<AinSettings> get settings;

  /// Provid settings for ain module
  Future<void> setSettings(AinSettings settings);
}
