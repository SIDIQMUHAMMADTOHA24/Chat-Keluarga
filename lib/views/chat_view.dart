import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.receiver});

  final String receiver;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hani")),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BubbleSpecialThree(
                  text: 'Added iMessage shape bubbles',
                  color: Color(0xFF1B97F3),
                  tail: false,
                  textStyle: TextStyle(color: Colors.white, fontSize: 16),
                ),
                BubbleSpecialThree(
                  text: 'Please try and give some feedback on it!',
                  color: Color(0xFF1B97F3),
                  tail: true,
                  textStyle: TextStyle(color: Colors.white, fontSize: 16),
                ),
                BubbleSpecialThree(
                  text: 'Sure',
                  color: Color(0xFFE8E8EE),
                  tail: false,
                  isSender: false,
                ),
                BubbleSpecialThree(
                  text: "I tried. It's awesome!!!",
                  color: Color(0xFFE8E8EE),
                  tail: false,
                  isSender: false,
                ),
                BubbleSpecialThree(
                  text: "Thanks",
                  color: Color(0xFFE8E8EE),
                  tail: true,
                  isSender: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
