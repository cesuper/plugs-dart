import 'package:plugs/flw/flw_socket_content.dart';

import 'flw_sensor.dart';

final flwSensors = <FlwSensor>[
  FlwSensor('994559880192100081', 'Channel 1'),
  FlwSensor('994559880192100105', 'Channel 2'),
];

final flwSocketContent = FlwSocketContent(flwSensors);
