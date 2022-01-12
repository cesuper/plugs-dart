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

  //
  static const unknownFamilyName = 'unknown';

  ///
  static final familyMap = <int, String>{
    unknown: unknownFamilyName,
    smp8: 'smp',
    smc: 'smc',
    dio: 'dio',
    scp412: 'scp',
    smp32: 'smp',
    supt: 'sup',
    senven: 'seven',
    eight: 'eight',
    sfp9: 'sfp',
    scp442: 'scp',
    supds: 'sup'
  };

  ///
  static final modelMap = <int, String>{
    unknown: '',
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
