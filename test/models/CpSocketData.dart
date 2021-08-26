import 'dart:convert';

import 'CpChannelSocketData.dart';

class CpSocketData {
  final List<CpChannelSocketData> channels;

  CpSocketData(this.channels);

  Map<String, dynamic> toMap() {
    return {
      'channels': channels.map((x) => x.toMap()).toList(),
    };
  }

  factory CpSocketData.fromMap(Map<String, dynamic> map) {
    return CpSocketData(
      List<CpChannelSocketData>.from(
          map['channels']?.map((x) => CpChannelSocketData.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CpSocketData.fromJson(String source) =>
      CpSocketData.fromMap(json.decode(source));
}
