import 'package:plugs/smp/smp.dart';

class Smp8 extends Smp {
  // max sensors
  static final int SMP8_MAX_SENSORS = 8;

  Smp8(String address) : super(address, SMP8_MAX_SENSORS);
}
