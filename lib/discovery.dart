import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:plugs/plugs/plug/info.dart';

//
typedef ConnectionStateChangedCallback = Function(Info info, bool isConnected);

/// TODO: in service mode the timer should wait for period before start
/// TODO: provide detailed description about device service
///
class Discovery {
  /// Port used by plugs to recieve discovery request
  static const int remotePort = 6060;

  /// Discovery request
  static final request = <int>[0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];

  // local address where plugs expected to be
  final InternetAddress localAddress;

  // discovery response timeout
  final Duration timeout;

  // result of the last discovery
  List<Info> _devices = [];

  // list of devices discovered
  List<Info> get devices => _devices;

  // timer for periodically check device presence
  Timer? _timer;

  // flag indicating discovery is in progress
  bool _isDiscovering = false;

  //
  final ConnectionStateChangedCallback? onStateChanged;

  /// Returns a new instance of device service.
  /// [localAddress] local interface address where the plugs being searched
  /// [onStateChanged] when privided callback is fired on new device or removal
  /// [timeout] timeout for discovery response
  /// [port] port to bind discovery socket, default is 0
  Discovery(
    this.localAddress, {
    this.onStateChanged,
    this.timeout = const Duration(seconds: 1),
  });

  ///
  Future<List<Info>> discover() async {
    // check if progress
    if (!_isDiscovering) {
      // set discovery flag
      _isDiscovering = true;

      // scan devices
      var result = await _discover();

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

      // reset flag
      _isDiscovering = false;
    }

    // return devices discovered when service is running
    return _devices;
  }

  /// Starts a periodic timer to check devices on the network.
  /// [onStateChanged] callback is fired when new device discovered or lost
  void start({Duration period = const Duration(seconds: 3)}) async {
    // start now and
    await discover();

    // setup timer for period calls
    _timer = Timer.periodic(period, (timer) async => await discover());
  }

  /// Stops timer
  void stop() => _timer?.cancel();

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

  /// Starts the discovery process by sending discovery request from [localAddress]
  /// to [remotePort]  and wait for reply witing [timeout].
  Future<List<Info>> _discover() async {
    //
    var result = <Info>[];

    // todo handle error
    // bind to any port
    var socket = await RawDatagramSocket.bind(localAddress, 0);

    // enable broadcast
    socket.broadcastEnabled = true;

    //
    socket.listen(
      (e) {
        if (e == RawSocketEvent.read) {
          // read a chunk
          Datagram? dg = socket.receive();

          // check if dg available
          if (dg != null) {
            // get the string content from the datagram
            var sub = dg.data.takeWhile((value) => value != 0).toList();

            //
            var str = utf8.decode(sub, allowMalformed: true);

            //
            result.add(Info.fromJson(str));
          }
        }
      },
    );
    // construct direct broadcast address from local address
    var targetRawAddress = localAddress.rawAddress..[3] = 0xFF;

    // create destination address from direct broadcast address
    var destinationAddress = InternetAddress.fromRawAddress(
      targetRawAddress,
      type: InternetAddressType.IPv4,
    );

    // send discovery request
    socket.send(request, destinationAddress, remotePort);

    // wait for reply
    await Future.delayed(timeout);

    //
    socket.close();

    // return the discovery result
    return result;
  }
}
