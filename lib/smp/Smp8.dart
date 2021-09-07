import 'package:plugs/smp/Smp.dart';

class Smp8 extends Smp {
  // max sensors
  static final int MAX_SENSORS = 8;

  Smp8(String address) : super(address, MAX_SENSORS);
}
