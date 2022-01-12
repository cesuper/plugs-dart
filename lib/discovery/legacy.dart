import 'package:collection/collection.dart';
import 'package:plugs/plugs/code.dart';

// map of code - List<RevRange>, where one code may have multiple revisions
final _map = <int, List<RevRange>>{
  Code.smp8: <RevRange>[
    RevRange(5, 376, max),
    RevRange(4, 76, 357),
  ],
  Code.smp32: <RevRange>[
    RevRange(2, 11, max),
  ],
  Code.scp412: <RevRange>[
    RevRange(3, 315, 999),
    RevRange(2, 18, 314),
  ],
  // TODO: verfiy
  Code.scp442: <RevRange>[
    RevRange(1, 1000, max),
  ],
  Code.sfp9: <RevRange>[
    RevRange(2, 53, max),
  ],
  Code.supt: <RevRange>[
    RevRange(2, 841, max),
  ],
  Code.supds: <RevRange>[
    RevRange(1, 1, max),
  ],
};

// helper for max int value
final max = double.maxFinite.toInt();

/// Model for rev - {from,to}
class RevRange {
  //
  final int rev;

  // range start - inclusive
  final int from;

  // range to - inclusive
  final int to;

  RevRange(this.rev, this.from, this.to);

  // function returns true when value is in range
  bool inRange(int val) => from <= val && val <= to;
}

/// Helper class to find the 'real' rev value for a device
class Legacy {
  /// Function returns revision number based on device code
  /// and serial number or 0 if not found
  static int getRevision(int code, int sn) {
    // check if code exists
    final revList = _map[code];

    // check if code found
    if (revList == null) return 0;

    // check if any range found
    final range = revList.firstWhereOrNull((element) => element.inRange(sn));

    // return revision
    return (range == null) ? 0 : range.rev;
  }
}
