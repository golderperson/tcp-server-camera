import 'dart:io';
import 'dart:typed_data';

void main() async {
  Uint8List bytes =
      await File('diablo-iv-PS5-wallpapers-2023-03.png').readAsBytes();

  final socket = await Socket.connect('192.168.0.11', 3000);
  print('Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');

  // listen for responses from the server
  socket.listen(
    // handle data from the server
    (Uint8List data) {
      final serverResponse = String.fromCharCodes(data);
      print('Server: $serverResponse');
    },

    // handle errors
    onError: (error) {
      print(error);
      socket.destroy();
    },

    // handle server ending connection
    onDone: () {
      print('Server left.');
      socket.destroy();
    },
  );

  // send some messages to the server
  await sendMessage(socket, bytes);
}

Future<void> sendMessage(Socket socket, Uint8List message) async {
  print('Client: $message');
  socket.add(message);
}
