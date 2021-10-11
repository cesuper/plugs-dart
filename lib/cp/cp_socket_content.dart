import 'dart:convert';

import 'cp_channel.dart';

class CpSocketContent {
  //
  final List<CpChannel> channels;

  CpSocketContent(this.channels);

  factory CpSocketContent.fromList(List<dynamic> list) {
    return CpSocketContent(
        List<CpChannel>.from(list.map((e) => CpChannel.fromMap(e))).toList());
  }

  String toJson() => json.encode(channels.map((x) => x.toMap()).toList());

  factory CpSocketContent.fromJson(String source) =>
      CpSocketContent.fromList(json.decode(source));
}
