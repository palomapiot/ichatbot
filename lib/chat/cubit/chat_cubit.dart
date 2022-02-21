import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import 'package:ichatbot/chat/cubit/models/message.dart';
import 'package:ichatbot/chat/cubit/models/rasa_request.dart';
import 'package:ichatbot/chat/cubit/models/rasa_response.dart';

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
    final response = await http.post(
      Uri.parse(
        'https://86e9-2a02-8388-8cbd-7b80-7064-1610-101b-7262.ngrok.io/webhooks/rest/webhook',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(RasaRequest('user', state.newMessage).toJson()),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      final rasaResponse = RasaResponseList.fromJson(jsonResponse);
      await receiveMessage(rasaResponse.responses.first.text);
    } else {
      throw Exception('Failed to send message.');
    }
  }

  Future<void> receiveMessage(String text) async {
    final updatedMessages = state.messages.toList()
      ..add(
        ChatMessage(messageContent: text, messageType: MessageType.receiver),
      );
    emit(state.copyWith(newMessage: '', messages: updatedMessages));
  }
}
