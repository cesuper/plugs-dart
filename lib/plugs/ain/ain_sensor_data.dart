abstract class AinSensorData {
  /// plug serial number from where the adata is originated
  final String plug;

  /// Status of the sensor from measurement point of view
  final int status;

  /// Sensor serial number
  final String serial;

  /// Sensor name
  final String name;

  ///
  AinSensorData(this.plug, this.status, this.serial, this.name);
}
