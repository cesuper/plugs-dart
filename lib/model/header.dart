part of plugs;

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
