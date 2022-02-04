library plugs;

/// Imports
import 'dart:async';
import 'dart:convert';
import 'package:universal_io/io.dart';
import 'package:http/http.dart';

// root
part 'api_client.dart';
part 'api_exception.dart';
part 'api_helper.dart';

// clients
part 'client/plug_client.dart';

// api
part 'api/scp_api.dart';
part 'api/plug_api.dart';
part 'api/socket_api.dart';
part 'api/sfp_api.dart';

// models
part 'model/discovery_result.dart';
part 'model/memory.dart';
part 'model/plug_state.dart';
part 'model/plug.dart';
part 'model/socket.dart';

// models/scp
part 'model/scp/scp_plug_state.dart';
part 'model/scp/ain.dart';
part 'model/scp/dio.dart';

// models/flw
part 'model/flw/sfp_plug_state.dart';
part 'model/flw/flw_sensor_state.dart';
part 'model/flw/flw.dart';

// utils
part 'utils/code.dart';
