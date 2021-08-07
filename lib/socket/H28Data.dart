import 'dart:convert';

class H28Data {
  // sensor status
  final int status;

  // 1W device address
  final String address;

  // temperature value
  final double value;

  H28Data(
    this.status,
    this.address,
    this.value,
  );

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'address': address,
      'value': value,
    };
  }

  factory H28Data.fromMap(Map<String, dynamic> map) {
    return H28Data(
      map['status'],
      map['address'],
      map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory H28Data.fromJson(String source) =>
      H28Data.fromMap(json.decode(source));

  @override
  String toString() =>
      'H28Data(status: $status, address: $address, value: $value)';
}
