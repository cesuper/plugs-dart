import 'dart:convert';

class H43 {
  // status of the read operation
  final int status;

  // 1W device address
  final String address;

  // eeprom memory content
  final String content;

  H43(this.status, this.address, this.content);

  Map<String, dynamic> toMap() {
    return {'status': status, 'address': address, 'content': content};
  }

  factory H43.fromMap(Map<String, dynamic> map) {
    return H43(
      map['status'],
      map['address'],
      map['content'],
    );
  }

  String toJson() => json.encode(toMap());

  factory H43.fromJson(String source) => H43.fromMap(json.decode(source));

  @override
  String toString() =>
      'H43(status: $status, address: $address, content: $content)';
}
