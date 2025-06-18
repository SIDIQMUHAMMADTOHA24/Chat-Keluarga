import 'package:chat_keluarga/views/chat_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  //Nama
  //Isi pesan
  //Terakhir chat

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat Keluarga")),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => ListTile(
          title: Text("Hani"),
          subtitle: Text("Hallo ?"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatView(receiver: "Hani"),
              ),
            );
          },
          trailing: Text("12:30"),
        ),
      ),
    );
  }
}
