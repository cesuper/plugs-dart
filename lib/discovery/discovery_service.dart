import 'dart:async';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:plugs/discovery/discovery.dart';
import 'package:plugs/plugs/plug/info.dart';

//
typedef ConnectionStateChangedCallback = Function(Info info, bool isConnected);

/// TODO: Start, stop discovery
/// TODO: Manual discover
/// TODO: Start Timer callback fx immediately

/// TODO: provide detailed description about device service
///
class DiscoveryService {
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

  // result of the last discovery
  List<Info> _devices = [];

  // list of devices discovered
  List<Info> get listeners => _devices;

  // timer for periodically check device presence
  Timer? _timer;

  // flag indicating discovery is in progress
  bool _isDiscovering = false;

  //
  final ConnectionStateChangedCallback? onStateChanged;

  /// Returns a new instance of device service.
  /// [localAddress] local interface address where the plugs being searched
  /// [period] device scan period
  /// [timeout] timeout for discovery response
  /// [port] port to bind discovery socket, default is 0
  DiscoveryService(
    this.localAddress, {
    this.onStateChanged,
    this.period = const Duration(seconds: 3),
    this.timeout = const Duration(seconds: 1),
    this.port = 0,
    this.logger,
  });

  ///
  /// Starts a periodic timer to check devices on the network.
  void start() {
    //
    _timer = Timer.periodic(period, (timer) async {
      // check if progress
      if (!_isDiscovering) {
        // set discovery flag
        _isDiscovering = true;

        try {
          // scan devices
          var result = await Discovery.discover(
            localAddress,
            timeout: timeout,
            port: port,
          );

          // handle new connections
          _checkConnections(_devices, result).forEach((e) {
            onStateChanged?.call(e, true);
          });

          // handle removals
          _checkRemovals(_devices, result).forEach((e) {
            onStateChanged?.call(e, false);
          });

          // update devices
          _devices = result;
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

  /// List device connections.
  /// Connection is new, when an address presents in [discovered] but
  /// not available in [recent]
  List<Info> _checkConnections(List<Info> recent, List<Info> discovered) {
    // list of new plugs
    var found = <Info>[];
    for (var device in discovered) {
      // check if address is new since the last discovery
      var exists = recent.any((e) => (e.network.ip == device.network.ip));
      // if not, then add as new plug
      if (exists == false) {
        found.add(device);
      }
    }
    return found;
  }

  /// List device removals
  /// Connection is removed, when an address presents in [recent] but not
  /// available in [discovered]
  List<Info> _checkRemovals(List<Info> recent, List<Info> discovered) {
    // list of lost
    var lost = <Info>[];
    for (var device in recent) {
      // check if address is lost since the last dicovery
      var exists = discovered.any((e) => (e.network.ip == device.network.ip));
      // if not, then add as new plug
      if (exists == false) {
        lost.add(device);
      }
    }
    return lost;
  }
}
