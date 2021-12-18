import 'dart:async';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:plugs/discovery.dart';
import 'package:plugs/plugs/plug/info.dart';

import 'plug_info.dart';

//
typedef OnPlugConnected = void Function(List<PlugInfo> plugs);

//
typedef OnPlugDisconnected = void Function(List<PlugInfo> plugs);

//

/// TODO: provide detailed description about device service
///
class PlugService {
  // logger
  final Logger _logger;

  // local address where plugs expected to be
  final InternetAddress localAddress;

  // discovery period
  final Duration period;

  // discovery response timeout
  final Duration timeout;

  // port to bind socket used for discovery
  final int port;

  // list of discovered devices
  List<Info> _devices = [];

  // list of devices discovered
  List<Info> get devices => _devices;

  // timer for periodically check device presence
  // ignore: unused_field
  Timer? _timer;

  // flag indicating discovery is in progress
  bool _isDiscovering = false;

  /// Returns a new instance of device service.
  /// [localAddress] local interface address where the plugs being searched
  /// [period] defines the device scan period
  /// [timeout] defines the time to wait for responses
  PlugService(
    Logger logger,
    this.localAddress, {
    this.period = const Duration(seconds: 3),
    this.timeout = const Duration(seconds: 1),
    this.port = 0,
  }) : _logger = logger;

  ///
  void start() {
    //
    _timer = Timer.periodic(period, (timer) async {
      // check if progress
      if (!_isDiscovering) {
        // set discovery flag
        _isDiscovering = true;

        try {
          // start discovery and wait for result
          _devices = await Discovery.discover(
            localAddress,
            timeout: timeout,
            port: port,
          );
        } on SocketException catch (e, stackTrace) {
          // log socket exceptions
          _logger.e('Socket Exception', e, stackTrace);
        } catch (e) {
          _logger.e(e);
        }

        // reset flag
        _isDiscovering = false;
      }
    });
  }
}
