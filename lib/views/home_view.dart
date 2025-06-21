import 'package:chat_keluarga/utils/storage_util.dart';
import 'package:chat_keluarga/views/chat_view.dart';
import 'package:chat_keluarga/views/login_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await StorageUtils.deleteToken();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginView()),
            (route) => false,
          );
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}
