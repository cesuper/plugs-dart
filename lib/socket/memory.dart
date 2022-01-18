import 'dart:convert';

class Memory {
  ///
  final String address;

  ///
  final int total;

  //
  final int free;

  //
  final Header header;

  Memory(this.address, this.total, this.free, this.header);

  ///
  /// methods
  ///

  ///
  bool get isConnected => address != '';

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'total': total,
      'free': free,
      'header': header.toMap(),
    };
  }

  factory Memory.fromMap(Map<String, dynamic> map) {
    return Memory(
      map['address'] ?? '',
      map['total']?.toInt() ?? 0,
      map['free']?.toInt() ?? 0,
      Header.fromMap(map['header']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Memory.fromJson(String source) => Memory.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Memory(address: $address, total: $total, free: $free, header: $header)';
  }
}

class Header {
  //
  final int len;

  //
  final int crc;

  //
  final bool isValid;

  Header(this.len, this.crc, this.isValid);

  Map<String, dynamic> toMap() {
    return {
      'len': len,
      'crc': crc,
      'isValid': isValid,
    };
  }

  factory Header.fromMap(Map<String, dynamic> map) {
    return Header(
      map['len']?.toInt() ?? 0,
      map['crc']?.toInt() ?? 0,
      map['isValid'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Header.fromJson(String source) => Header.fromMap(json.decode(source));

  @override
  String toString() => 'Header(len: $len, crc: $crc, isValid: $isValid)';
}
