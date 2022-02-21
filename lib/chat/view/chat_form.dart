import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ichatbot/chat/chat.dart';
import 'package:ichatbot/chat/cubit/models/message.dart';
import 'package:ichatbot/common/widgets/base_page.dart';
import 'package:ichatbot/l10n/l10n.dart';

final _controller = ScrollController();

void _scrollDown() {
  _controller.animateTo(
    _controller.position.maxScrollExtent,
    duration: const Duration(seconds: 1),
    curve: Curves.fastOutSlowIn,
  );
}

class ChatForm extends BasePage {
  const ChatForm({Key? key}) : super(key);

  @override
  String title(BuildContext context) => 'Chat with your assistant';

  @override
  List<BlocListener> listeners(BuildContext context) {
    return [
      BlocListener<ChatCubit, ChatState>(
        listenWhen: (previous, current) =>
            previous.messages != current.messages,
        listener: (context, state) {
          _scrollDown();
        },
      ),
    ];
  }

  @override
  Widget widget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SafeArea(
        child: Stack(
          children: const [_ChatMessages(), _InputText()],
        ),
      ),
    );
  }
}

class _ChatMessages extends StatelessWidget {
  const _ChatMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      buildWhen: (previous, current) => previous.messages != current.messages,
      builder: (context, state) {
        final messages = state.messages;
        return ListView.builder(
          controller: _controller,
          itemCount: messages.length,
          padding: const EdgeInsets.only(top: 10, bottom: 160),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 10,
              ),
              child: messages[index].messageType == MessageType.receiver
                  ? _ReceiverMessage(message: messages[index].messageContent)
                  : _SenderMessage(message: messages[index].messageContent),
            );
          },
        );
      },
    );
  }
}

class _SenderMessage extends StatelessWidget {
  const _SenderMessage({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromRGBO(90, 23, 238, .5),
        ),
        padding: const EdgeInsets.all(16),
        child: Text(
          message,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}

class _ReceiverMessage extends StatelessWidget {
  const _ReceiverMessage({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade200,
        ),
        padding: const EdgeInsets.all(16),
        child: Text(
          message,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}

class _InputText extends StatelessWidget {
  const _InputText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
        height: 60,
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                buildWhen: (previous, current) =>
                    previous.messages != current.messages &&
                    current.messages.last.messageType == MessageType.sender,
                builder: (context, state) {
                  return TextField(
                    controller: TextEditingController(
                      text: state.newMessage,
                    ),
                    onChanged: (newValue) =>
                        context.read<ChatCubit>().newMessageChanged(newValue),
                    decoration: InputDecoration(
                      hintText: l10n.writeMessage,
                      hintStyle: const TextStyle(color: Colors.black54),
                      border: InputBorder.none,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            FloatingActionButton(
              onPressed: () async {
                await context.read<ChatCubit>().sendMessage();
              },
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0,
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
