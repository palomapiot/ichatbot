import 'package:ichatbot/chat/cubit/models/button.dart';

enum MessageType { sender, receiver }

class ChatMessage {
  ChatMessage({
    required this.messageContent,
    required this.messageType,
    this.buttons,
  });

  String messageContent;
  MessageType messageType;
  List<Button>? buttons;
}
