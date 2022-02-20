import 'package:flutter/material.dart';
import 'package:ichatbot/chat/view/chat_form.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: ChatPage());

  @override
  Widget build(BuildContext context) {
    return const ChatForm();
  }
}
