import 'dart:async';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:plugs/discovery.dart';
import 'package:plugs/plugs/plug/info.dart';
import 'package:plugs/service/event.dart';
import 'package:plugs/service/event_listener.dart';

/// TODO: provide detailed description about device service
///
class EventService {
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

  //
  final StreamController<Event> eventStream = StreamController();

  // list of
  final List<EventListener> _listeners = [];

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
  EventService(
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

          // get new devices only
          var addresses = _getNewConnections(result);

          // register new devices
          _register(addresses);
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
  List<String> _getNewConnections(List<Info> discovered) {
    // list of new plugs
    var addresses = <String>[];
    for (var device in discovered) {
      // is r exists in the last dicovery?
      var isExising = _devices.any((e) =>
          (e.network.ip == device.network.ip) &&
          (e.hardware.serial == device.hardware.serial));
      // if not, then add as new plug
      if (isExising == false) {
        addresses.add(device.network.ip);
      }
    }

    // return the new devices
    return addresses;
  }

  ///
  void _register(List<String> addresses) async {
    //
    for (var address in addresses) {
      // create listener
      var listener = EventListener(InternetAddress(address), eventStream);

      // connect to plug
      listener.connect().then((value) {
        // add to listeners only when successfully connected event socket
        _listeners.add(listener);
      }, onError: (e, trace) {
        logger?.e('$addresses discovered but eventListener failed to connect',
            e, trace);
      });
    }

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
