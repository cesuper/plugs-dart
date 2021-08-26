import 'dart:convert';

class SocketDeviceConnectData {
  final String address;
  final String content;

  SocketDeviceConnectData(this.address, this.content);

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'content': content,
    };
  }

  factory SocketDeviceConnectData.fromMap(Map<String, dynamic> map) {
    return SocketDeviceConnectData(
      map['address'],
      map['content'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SocketDeviceConnectData.fromJson(String source) =>
      SocketDeviceConnectData.fromMap(json.decode(source));

  @override
  String toString() =>
      'SocketDeviceConnectData(address: $address, data: $content)';
}
