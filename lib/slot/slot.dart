import 'package:plugs/plugs_const.dart';

class Slot {
  // ip address assigned to this slot
  final String address;

  // expected device model in this slot. see [plugs_const] for models
  final String model;

  const Slot(
    this.address,
    this.model,
  );

  // Cp slot
  Slot.cp(String address) : this(address, modelCp);

  // Scp slot
  Slot.scp(String address) : this(address, modelScp);

  // Flw slot
  Slot.flw(String address) : this(address, modelFlw);

  // Def slot
  Slot.def(String address) : this(address, modelDef);
}
