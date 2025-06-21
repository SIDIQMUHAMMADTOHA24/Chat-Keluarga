import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

class ChatService {
  late IOWebSocketChannel channel;
  String? token;

  // Inisialisasi WebSocket dengan token
  void connect(String authToken) {
    token = authToken;
    channel = IOWebSocketChannel.connect(
      'ws://localhost:8080/api/ws',
      headers: {'Authorization': 'Bearer $authToken'},
    );

    // Dengarkan pesan masuk
    channel.stream.listen(
      (message) {
        final data = jsonDecode(message);
        print('Pesan diterima: $data');
        // Update UI di sini (misalnya, tambahkan ke list chat)
      },
      onError: (error) => print('Error WebSocket: $error'),
      onDone: () => print('WebSocket ditutup'),
    );
  }

  // Kirim pesan
  void sendMessage(int receiverId, String content) {
    final message = {'receiver_id': receiverId, 'content': content};
    channel.sink.add(jsonEncode(message));
  }

  // Tutup koneksi
  void disconnect() {
    channel.sink.close();
  }
}
