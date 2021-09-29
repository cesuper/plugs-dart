import 'dart:convert';

class H43Data {
  // status of the read operation
  final int status;

  // 1W device address
  final String address;

  // eeprom memory content
  final String content;

  H43Data(this.status, this.address, this.content);

  Map<String, dynamic> toMap() {
    return {'status': status, 'address': address, 'content': content};
  }

  factory H43Data.fromMap(Map<String, dynamic> map) {
    return H43Data(
      map['status'],
      map['address'],
      map['content'],
    );
  }

  String toJson() => json.encode(toMap());

  factory H43Data.fromJson(String source) =>
      H43Data.fromMap(json.decode(source));

  @override
  String toString() =>
      'H43Data(status: $status, address: $address, content: $content)';
}
