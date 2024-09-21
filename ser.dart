import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

//import 'package:image/image.dart';
int a = 0;
void main() async {
  // bind the socket server to an address and port
  final server = await ServerSocket.bind('192.168.0.11', 8000);

  // listen for clent connections to the server
  server.listen((client) {
    handleConnection(client);
  });
}

void handleConnection(Socket client) {
  print('Connection from'
      ' ${client.remoteAddress.address}:${client.remotePort}');

  // listen for events from the client
  client.listen(
    // handle data from the client
    (Uint8List data) async {
      // final message = String.fromCharCodes(data);

      print(data);
      await File('new${a}.JPG').writeAsBytes(data);
      a++;
    },

    // handle errors
    onError: (error) {
      print(error);
      client.close();
    },

    // handle the client closing the connection
    onDone: () {
      print('Client left');
      client.close();
    },
  );
}
