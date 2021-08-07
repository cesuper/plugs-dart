import 'package:http/http.dart' as http;

import 'GroupMember.dart';
import 'Info.dart';

const CONST_PLUG_API_INFO = '/api/info.cgi';
const CONST_PLUG_API_GROUP = '/api/group.cgi';
const CONST_PLUG_API_CFG = '/api/cfg.cgi';
const CONST_PLUG_API_DATA = '/api/data.cgi';

abstract class Plug {
  // plug network address with port
  final String address;

  Plug(this.address);

  /// Read Info
  static Future<Info> readInfo(String host) async {
    var uri = Uri.http('$host', CONST_PLUG_API_INFO);
    var r = await http.get(uri).timeout(Duration(seconds: 1));
    return Info.fromJson(r.body);
  }

  /// Read Group
  Future<GroupMember> readGroup() async {
    var uri = Uri.http('$address', CONST_PLUG_API_GROUP);
    var r = await http.get(uri);
    return GroupMember.fromJson(r.body);
  }

  /// Write Group
  Future<int> writeGroup(GroupMember group) async {
    var uri = Uri.http('$address', CONST_PLUG_API_GROUP);
    var response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: group.toJson(),
    );

    return response.statusCode;
  }
}
