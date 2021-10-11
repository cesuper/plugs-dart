import 'dart:convert';

import 'package:plugs/flw/flw_channel.dart';

class FlwSocketContent {
  //
  final List<FlwChannel> channels;

  FlwSocketContent(this.channels);

  factory FlwSocketContent.fromList(List<dynamic> list) {
    return FlwSocketContent(
        List<FlwChannel>.from(list.map((e) => FlwChannel.fromMap(e))).toList());
  }

  String toJson() => json.encode(channels.map((e) => e.toMap()).toList());

  factory FlwSocketContent.fromJson(String source) =>
      FlwSocketContent.fromList(json.decode(source));
}
