import 'dart:async';
import 'dart:io';

import 'package:plugs/discovery.dart';
import 'package:plugs/plugs/plug/info.dart';

import 'device_info.dart';

/// TODO: provide detailed description about device service
///
class DeviceService {
  // local address where plugs expected to be
  final InternetAddress localAddress;

  // discovery period
  final Duration period;

  // discovery response timeout
  final Duration timeout;

  // list of discovered devices
  List<Info> _devices = [];

  // list of devices discovered
  List<Info> get devices => _devices;

  //
  List<DeviceInfo> deviceInfo = [];

  // timer for periodically check device presence
  // ignore: unused_field
  Timer? _timer;

  // flag indicating discovery is in progress
  bool _isDiscovering = false;

  /// Returns a new instance of device service.
  /// [period] defines the device scan period
  /// [timeout] defines the time to wait for responses
  DeviceService(this.localAddress, this.period, this.timeout);

  ///
  void start() {
    //
    _timer = Timer.periodic(period, (timer) async {
      // check if progress
      if (!_isDiscovering) {
        // set flag
        _isDiscovering = true;

        try {
          // discover
          _devices = await Discovery.discover(localAddress, timeout);

          // populate deviceInfo
          deviceInfo = _devices.map((e) {
            return DeviceInfo(
                e.network.ip,
                e.hardware.mac,
                e.hardware.serial,
                '${e.software.major}.${e.software.minor}.${e.software.fix}',
                e.software.release,
                e.software.build);
          }).toList();
        } catch (e) {
          // ignore: todo
          // TODO log errors
          print(e);
        }

        // reset flag
        _isDiscovering = false;
      }
    });
  }
}
