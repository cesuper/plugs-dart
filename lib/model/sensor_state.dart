part of plugs;

abstract class SensorState {
  // plug
  final String plug;

  // sensor serial number
  final String serial;

  // sensor name
  final String name;

  // status of the sensor from measurement point of view
  final int status;

  SensorState(this.plug, this.serial, this.name, this.status);
}
