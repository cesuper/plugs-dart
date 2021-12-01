// import 'dart:io';
// import 'dart:convert';

// main() {
//   var DESTINATION_ADDRESS = InternetAddress("x.y.z.255");

//   RawDatagramSocket.bind(InternetAddress.anyIPv4, 8889)
//       .then((RawDatagramSocket udpSocket) {
//     udpSocket.broadcastEnabled = true;
//     udpSocket.listen((e) {
//       Datagram dg = udpSocket.receive();
//       if (dg != null) {
//         print("received ${dg.data}");
//       }
//     });
//     List<int> data = utf8.encode('TEST');
//     udpSocket.send(data, DESTINATION_ADDRESS, 8889);
//   });
// }
