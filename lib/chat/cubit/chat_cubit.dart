import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:ichatbot/chat/cubit/models/button.dart';
import 'package:ichatbot/chat/cubit/models/message.dart';
import 'package:ichatbot/chat/cubit/models/rasa_request.dart';
import 'package:ichatbot/chat/cubit/models/rasa_response.dart';
import 'package:uuid/uuid.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState());

  Future<void> resetChat() async {
    emit(state.copyWith(newMessage: '', messages: []));
  }

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
    final response = await http.post(
      Uri.parse(
        //'https://122e-2a02-8388-8cbd-7b80-f1f3-9ac9-bc95-d398.ngrok.io/webhooks/rest/webhook',
        'http://0.0.0.0:5005/webhooks/rest/webhook',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(RasaRequest(state.id, state.newMessage).toJson()),
    );
    emit(state.copyWith(newMessage: '', messages: updatedMessages));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      final rasaResponse = RasaResponseList.fromJson(jsonResponse);
      for (final rasaMessage in rasaResponse.responses) {
        await receiveMessage(rasaMessage.text, rasaMessage.buttons);
      }
    } else {
      throw Exception('Failed to send message.');
    }
  }

  Future<void> receiveMessage(String text, ButtonList buttons) async {
    final updatedMessages = state.messages.toList()
      ..add(
        ChatMessage(
            messageContent: text,
            messageType: MessageType.receiver,
            buttons: buttons.buttons,
        ),
      );
    emit(state.copyWith(newMessage: '', messages: updatedMessages));
  }
}
