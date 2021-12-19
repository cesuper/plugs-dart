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

  //
  final StreamController<Event> eventStream = StreamController();

  // list of
  final List<EventListener> _listeners = [];

  // list of devices discovered
  List<EventListener> get listeners => _listeners;

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
      var isExising =
          _listeners.any((e) => e.host.address == device.network.ip);
      // if not, then add as new plug
      if (isExising == false) {
        addresses.add(device.network.ip);
      }
    }

    // return the new devices
    return addresses;
  }

  ///
  void _onConnect(EventListener listener, int code) {
    //
    _listeners.add(listener);

    //
    eventStream.add(Event(
      DateTime.now(),
      listener.host.address,
      Event.online,
    ));
  }

  void _onDisconnect(EventListener listener, int code) {
    //
    _listeners.removeWhere(
        (element) => element.host.address == listener.host.address);

    //
    eventStream.add(Event(
      DateTime.now(),
      listener.host.address,
      Event.offline,
    ));
  }

  void _onEvent(EventListener listener, int code) {
    //
    eventStream.add(Event(
      DateTime.now(),
      listener.host.address,
      code,
    ));
  }

  void _onError(EventListener listener, int code) {
    //
    eventStream.add(Event(
      DateTime.now(),
      listener.host.address,
      Event.error,
    ));
  }

  ///
  void _registerListener(List<String> addresses) async {
    //
    for (var address in addresses) {
      // create listener for a plug
      var listener = EventListener(
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
