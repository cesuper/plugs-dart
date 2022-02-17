library plugs;

/// Imports
import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:universal_io/io.dart';
import 'package:http/http.dart';

// root
part 'api_client.dart';
part 'api_exception.dart';
part 'api_helper.dart';

// clients
part 'client/plug_client.dart';

// api
part 'api/ain_api.dart';
part 'api/scp_api.dart';
part 'api/plug_api.dart';
part 'api/sfp_api.dart';
part 'api/smp_api.dart';

// models/scp
part 'model/scp/scp_ain_sensor_state.dart';
part 'model/scp/scp_ain_params.dart';
part 'model/scp/scp_ain_state.dart';
part 'model/scp/scp_dio_state.dart';
part 'model/scp/scp_plug_state.dart';

// models/sfp
part 'model/sfp/flw_sensor_state.dart';
part 'model/sfp/flw.dart';
part 'model/sfp/sfp_plug_state.dart';

// models/smp
part 'model/smp/smp_ain_sensor_state.dart';
part 'model/smp/smp_ain_params.dart';
part 'model/smp/smp_ain_state.dart';
part 'model/smp/smp_plug_state.dart';

// models
part 'model/plug_ain_params.dart';
part 'model/plug_ain_state.dart';
part 'model/discovery_result.dart';
part 'model/memory.dart';
part 'model/plug_state.dart';
part 'model/plug.dart';
part 'model/sensor_state.dart';
part 'model/socket.dart';

// utils
part 'utils/code.dart';
part 'utils/family.dart';
