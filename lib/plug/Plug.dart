import 'package:http/http.dart' as http;
import 'package:plugs/socket/Socket.dart';

import 'GroupMember.dart';
import 'Info.dart';

const CONST_PLUG_API_INFO = '/api/info.cgi';
const CONST_PLUG_API_GROUP = '/api/group.cgi';
const CONST_PLUG_API_CFG = '/api/cfg.cgi';
const CONST_PLUG_API_DATA = '/api/data.cgi';

abstract class Plug {
  // plug network address with port
  final String address;

  final Socket socket;

  Plug(this.address) : socket = Socket(address);

  /// Read Info
  Future<Info> readInfo() async {
    var uri = Uri.http('$address', CONST_PLUG_API_INFO);
    var r = await http.get(uri);
    return Info.fromJson(r.body);
  }

  /// Read Group
  Future<GroupMember> readGroup() async {
    var uri = Uri.http('$address', CONST_PLUG_API_GROUP);
    var r = await http.get(uri);
    return GroupMember.fromJson(r.body);
  }

  /// Write Group
  Future<int> writeGroup(String type, int index) async {
    var group = GroupMember(type, index);
    var uri = Uri.http('$address', CONST_PLUG_API_GROUP);
    var response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: group.toJson(),
    );

    return response.statusCode;
  }
}
