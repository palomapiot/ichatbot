import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ichatbot/chat/cubit/chat_cubit.dart';
import 'package:ichatbot/chat/view/chat_form.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: ChatPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit(),
      child: const ChatForm(),
    );
  }
}
