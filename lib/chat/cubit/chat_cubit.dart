import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ichatbot/chat/cubit/models/message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState());

  Future<void> messagesChanged(List<ChatMessage> messages) async {
    emit(state.copyWith(newMessage: '', messages: messages));
  }

  Future<void> newMessageChanged(String text) async {
    emit(state.copyWith(newMessage: text));
  }

  Future<void> sendMessage() async {
    final updatedMessages = state.messages.toList()
      ..add(
        ChatMessage(
          messageContent: state.newMessage,
          messageType: MessageType.sender,
        ),
      );
    emit(state.copyWith(newMessage: '', messages: updatedMessages));
    await receiveMessage('Thanks for your message!');
  }

  Future<void> receiveMessage(String text) async {
    final updatedMessages = state.messages.toList()
      ..add(
        ChatMessage(messageContent: text, messageType: MessageType.receiver),
      );
    emit(state.copyWith(newMessage: '', messages: updatedMessages));
  }
}
