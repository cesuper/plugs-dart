abstract class AinSensorData {
  /// Status of the sensor from measurement point of view
  final int status;

  /// Sensor serial number
  final String serial;

  /// Sensor name
  final String name;

  ///
  AinSensorData(this.status, this.serial, this.name);
}
