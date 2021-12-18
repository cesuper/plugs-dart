abstract class Dio {
  /// Returns the size of input
  int get diCount;

  /// Returns the size of output
  int get doCount;

  /// Returns the field state
  Future<bool> get field;

  /// Returns the state of input pins
  Future<List<bool>> get input;

  /// Retruns the state of output pins
  Future<List<bool>> get output;

  /// Starts timed output control
  Future<int> startPin(int pin, int timeout, {int delay = 0});

  /// Stops timed output controler
  Future<int> stopPin(int pin);
}
