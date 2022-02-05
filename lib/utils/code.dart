part of plugs;

class Code {
  // invalid device code aka. undefined device
  static const unknown = 0;

  // smp8 plug
  static const smp8 = 1;

  // some early version dio device
  static const smc = 2;

  // dio single-board device
  static const dio = 3;

  // scp412 plug
  static const scp412 = 4;

  // smp8 plug
  static const smp32 = 5;

  // sup-t
  static const supt = 6;

  //
  static const senven = 7;

  //
  static const eight = 8;

  // sfp plug with 9 channels
  static const sfp9 = 9;

  // scp plug with 4-4-2 channels
  static const scp442 = 10;

  // sup plug with 1wire interface
  static const supds = 11;

  ///
  static String getFamily(int code) => _familyMap[code] ?? Family.unknown;

  ///
  static String getModel(int code) => _modelMap[code] ?? '';

  ///
  static final _familyMap = <int, String>{
    smp8: Family.smp,
    smc: Family.smc,
    dio: Family.dio,
    scp412: Family.scp,
    smp32: Family.smp,
    supt: Family.sup,
    senven: Family.unknown,
    eight: Family.unknown,
    sfp9: Family.sfp,
    scp442: Family.scp,
    supds: Family.sup
  };

  ///
  static final _modelMap = <int, String>{
    smp8: '8',
    smc: '',
    dio: '',
    scp412: '412',
    smp32: '32',
    supt: 't',
    senven: 'seven',
    eight: 'eight',
    sfp9: '9',
    scp442: '442',
    supds: 'ds'
  };
}
