import 'dart:async';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:plugs/smp/smp.dart';

//
final log = Logger(printer: PrettyPrinter(methodCount: 0, printTime: false));

//
const pingTimeout = Duration(seconds: 3);

// ideal timeout is more than 5 sec
const connectionTimeout = Duration(seconds: 5);

//
const port = 6069;

//
enum ConnectionState { removed, connecting, connected }

class CpSlot {
  //
  final InternetAddress localAddress;

  //
  final InternetAddress remoteAddress;

  //
  final Smp _plug;

  // for periodic reconnect
  Timer? _timer;

  // maintain the active socket
  Socket? _socket;

  /// plug connection state related to the slot
  ConnectionState _state = ConnectionState.removed;

  //
  CpSlot(
    this.remoteAddress,
    this.localAddress,
  ) : _plug = Smp(remoteAddress.address, 8);

  ///
  void open() async {
    // start asap
    _connect();

    //
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // try to connect when plug is not connecting or connected
      if (_state == ConnectionState.removed) {
        _connect();
      }
    });
  }

  ///
  void close() {
    if (_timer != null) {
      // stop timer
      _timer!.cancel();
    }

    // destroy socket
    _socket?.destroy();

    _setState(ConnectionState.removed);
  }

  ///
  void _connect() async {
    try {
      // set state to connecting
      _setState(ConnectionState.connecting, printState: false);

      // try to connect
      _socket = await Socket.connect(
        remoteAddress,
        port,
        sourceAddress: localAddress,
      ).timeout(connectionTimeout);

      // set state to connected
      _setState(ConnectionState.connected);

      // listen on events with timeout
      _socket!.timeout(pingTimeout).listen((event) {
        // show event
        //log.i(event.first);
      }, onError: (e) {
        _socket?.destroy();
        _setState(ConnectionState.removed);
      }, onDone: () {
        _socket?.destroy();
        _setState(ConnectionState.removed, printState: false);
      });
    } catch (e) {
      _socket?.destroy();
      _setState(ConnectionState.removed, printState: false);
    }
  }

  ///
  void _setState(ConnectionState state, {bool printState = true}) {
    _state = state;

    if (printState) {
      log.i(state);
    }
  }
}
