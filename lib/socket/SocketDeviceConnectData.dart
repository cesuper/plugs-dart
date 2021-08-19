import 'dart:convert';

class SocketDeviceConnectData {
  final String address;
  final String data;

  SocketDeviceConnectData(this.address, this.data);

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'data': data,
    };
  }

  factory SocketDeviceConnectData.fromMap(Map<String, dynamic> map) {
    return SocketDeviceConnectData(
      map['address'],
      map['data'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SocketDeviceConnectData.fromJson(String source) =>
      SocketDeviceConnectData.fromMap(json.decode(source));

  @override
  String toString() =>
      'SocketDeviceConnectData(address: $address, data: $data)';
}
