import 'dart:convert';

class H28 {
  // sensor status
  final int status;

  // 1W device address
  final String address;

  // temperature value
  final double value;

  H28(
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

  factory H28.fromMap(Map<String, dynamic> map) {
    return H28(
      map['status'],
      map['address'],
      map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory H28.fromJson(String source) => H28.fromMap(json.decode(source));

  @override
  String toString() =>
      'H28Data(status: $status, address: $address, value: $value)';
}
