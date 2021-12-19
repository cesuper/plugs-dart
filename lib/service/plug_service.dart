import 'dart:async';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:plugs/discovery.dart';
import 'package:plugs/plugs/plug/info.dart';
import 'package:plugs/plugs/plug/plug.dart';

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

  // list of discovered devices
  final List<Info> _devices = [];

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

          // get the new devices only
          var newDevices = _getNewConnections(result);

          // register new devices
          _register(newDevices);
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

  ///
  /// Function to find plugs just recently connected
  /// Plugs are considered as new when not present in the [_devices]
  List<Info> _getNewConnections(List<Info> discovered) {
    // list of new plugs
    var newDevices = <Info>[];
    for (var device in discovered) {
      // is r exists in the last dicovery?
      var isExising = _devices.any((e) =>
          (e.network.ip == device.network.ip) &&
          (e.hardware.serial == device.hardware.serial));
      // if not, then add as new plug
      if (isExising == false) {
        newDevices.add(device);
      }
    }

    // return the new devices
    return newDevices;
  }

  ///
  void _register(List<Info> devices) async {
    // Future.wait(devices.map((e) => Plug(e.network.ip).connect(
    //       onEvent: (address, event) {
    //         print('$address - $event');
    //       },
    //       onError: (address, e, trace) {
    //         print('Error');
    //       },
    //       onDone: (address) {
    //         print('Disconnected: $address');
    //         _devices.removeWhere((element) => element.network.ip == address);
    //       },
    //     ).then((value) {
    //       print('Connected: ${e.hardware.serial}');
    //       _devices.add(e);
    //     })));
  }

  /// Function to find plugs just removed
  /// Plugs are considered as disconnected when existed in the previous but
  /// not in recent.
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
  }
}
