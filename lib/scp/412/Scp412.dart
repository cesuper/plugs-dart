import 'package:http/http.dart' as http;
import 'package:plugs/scp/412/Scp412Info.dart';
import 'package:plugs/scp/Scp.dart';

class Scp412 extends Scp {
  Scp412(String address) : super(address, 4, 12);

  Future<Scp412Info> scpInfo() async {
    var uri = Uri.http('$address', SCP_API_INFO);
    var r = await http.get(uri);
    return Scp412Info.fromJson(r.body);
  }
}
