part of 'chat_cubit.dart';

class ChatState extends Equatable {
  ChatState({
    String? newMessage,
    List<ChatMessage>? messages,
  })  : newMessage = newMessage ?? '',
        messages = messages ?? List.empty();

  final String newMessage;
  final List<ChatMessage> messages;

  ChatState copyWith({
    required String newMessage,
    List<ChatMessage>? messages,
  }) {
    return ChatState(
      newMessage: newMessage,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [newMessage, messages];

  @override
  String toString() => 'ChatState { newMessage: newMessage, '
      'messages: ${messages.length} }';
}
