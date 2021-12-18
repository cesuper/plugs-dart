import 'dart:async';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:plugs/discovery.dart';
import 'package:plugs/plugs/plug/info.dart';

//
typedef NetworkStateChangedCallback = void Function(List<Info> plugs);

/// TODO: provide detailed description about device service
///
class PlugService {
  // logger
  final Logger? logger;

  // local address where plugs expected to be
  final InternetAddress localAddress;

  // discovery period
  final Duration period;

  // discovery response timeout
  final Duration timeout;

  // port to bind socket used for discovery
  final int port;

  // callback
  final NetworkStateChangedCallback? onConnected;

  // callback
  final NetworkStateChangedCallback? onDisconnected;

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
    this.localAddress, {
    this.period = const Duration(seconds: 3),
    this.timeout = const Duration(seconds: 1),
    this.port = 0,
    this.onConnected,
    this.onDisconnected,
    this.logger,
  });

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
          var recent = await Discovery.discover(
            localAddress,
            timeout: timeout,
            port: port,
          );
          //
          _searchForNew(_devices, recent);
          //
          _searchForDisconnected(_devices, recent);

          // update devices
          _devices = recent;
        } on SocketException catch (e, stackTrace) {
          // log socket exceptions
          logger?.e('Socket Exception, check port?', e, stackTrace);
        } catch (e) {
          logger?.e(e);
        }

        // reset flag
        _isDiscovering = false;
      }
    });
  }

  /// Function to filter new plugs.
  /// Plugs are considered as new when not present in the previous
  /// discovery result.
  void _searchForNew(List<Info> previous, List<Info> recent) {
    // plug is not new when the plug serial and ip address remains unchanged

    // list of new plugs
    var list = <Info>[];
    for (var r in recent) {
      // is r exists in the last dicovery?
      var isExising = previous.any((e) =>
          (e.network.ip == r.network.ip) &&
          (e.hardware.serial == r.hardware.serial));
      // if not, then add as new plug
      if (isExising == false) {
        list.add(r);
      }
    }
    //
    onConnected!(list);
  }

  /// Function to find disconnected plugs
  /// Plugs are considered as disconnected when existed in the previous but
  /// not in recent
  void _searchForDisconnected(List<Info> previous, List<Info> recent) {
    // list of new plugs
    var list = <Info>[];
    for (var p in previous) {
      // is r exists in the last dicovery?
      var isExising = recent.any((e) =>
          (e.network.ip == p.network.ip) &&
          (e.hardware.serial == p.hardware.serial));
      // if not, then add as new plug
      if (isExising == false) {
        list.add(p);
      }
    }
    //
    onDisconnected!(list);
  }
}
