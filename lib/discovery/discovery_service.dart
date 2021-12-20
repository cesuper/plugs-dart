import 'dart:async';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:plugs/discovery/discovery.dart';
import 'package:plugs/plugs/plug/info.dart';
import 'package:plugs/plugs/plug/plug.dart';

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

  //
  final StreamController<Event> eventStream = StreamController();

  // list of
  final List<Plug> _devices = [];

  // list of devices discovered
  List<Plug> get listeners => _devices;

  // timer for periodically check device presence
  // ignore: unused_field
  Timer? _timer;

  // flag indicating discovery is in progress
  bool _isDiscovering = false;

  /// Returns a new instance of device service.
  /// [localAddress] local interface address where the plugs being searched
  /// [period] defines the device scan period
  /// [timeout] defines the time to wait for responses
  DiscoveryService(
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
          _registerListener(addresses);
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
      var isExising = _devices.any((e) => e.host.address == device.network.ip);
      // if not, then add as new plug
      if (isExising == false) {
        addresses.add(device.network.ip);
      }
    }

    // return the new devices
    return addresses;
  }

  ///
  void _onConnect(Plug plug, int code) {
    //
    _devices.add(plug);

    //
    // eventStream.add(Event(
    //   DateTime.now(),
    //   listener.host.address,
    //   Event.online,
    // ));
  }

  ///
  void _onDisconnect(Plug plug, int code) {
    // remove device from pool
    _devices.removeWhere((element) => element.address == plug.address);

    //
    // eventStream.add(Event(
    //   DateTime.now(),
    //   listener.host.address,
    //   Event.offline,
    // ));
  }

  ///
  void _onEvent(Plug plug, int code) {
    //
    // eventStream.add(Event(
    //   DateTime.now(),
    //   listener.host.address,
    //   code,
    // ));
  }

  ///
  void _onError(Plug plug, int code) {
    //
    // eventStream.add(Event(
    //   DateTime.now(),
    //   listener.host.address,
    //   Event.error,
    // ));
  }

  ///
  void _registerListener(List<String> addresses) async {
    //
    for (var address in addresses) {
      // create listener for a plug
      var listener = Listener(
        InternetAddress(address),
        _onConnect,
        _onDisconnect,
        _onEvent,
        _onError,
      );

      // connect to plug
      await listener.connect();

      // TODO: add error handler

      // // connect to plug
      // listener.connect().then((value) {
      //   // add to listeners only when successfully connected event socket
      //   _listeners.add(listener);
      // }, onError: (e, trace) {
      //   logger?.e('$addresses discovered but eventListener failed to connect',
      //       e, trace);
      // });
    }
  }
}
