import 'ain_sensor.dart';
import 'ain_settings.dart';
import 'ain_snapshot.dart';

abstract class Ain {
  /// Returns the size of analog input
  int get ainCount;

  /// Returns a snapshot of the sensor data
  Future<AinSnapshot> get snapshot;

  /// Returns the sensor parameters being used
  Future<List<AinSensor>> get sensors;

  /// Sets the sensor parameters
  Future<void> setSensors(List<AinSensor> sensors);

  /// Returns the settings structure
  Future<AinSettings> get settings;

  /// Provid settings for ain module
  Future<void> setSettings(AinSettings settings);
}
