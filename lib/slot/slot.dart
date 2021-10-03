import 'package:plugs/plugs_const.dart';

class Slot {
  // ip address assigned to this slot
  final String address;

  // expected device model in this slot. see [plugs_const] for models
  final String model;

  // requested device code or null if not defined
  final int? code;

  Slot(this.address, this.model, this.code);

  // Cp slot
  Slot.cp(String address, {int? code}) : this(address, modelCp, code);

  // Scp slot
  Slot.scp(String address, {int? code}) : this(address, modelScp, code);

  // Flw slot
  Slot.flw(String address, {int? code}) : this(address, modelFlw, code);

  // Def slot
  Slot.def(String address, {int? code}) : this(address, modelDef, code);
}
