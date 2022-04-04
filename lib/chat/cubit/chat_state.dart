part of 'chat_cubit.dart';

class ChatState extends Equatable {
  ChatState( {
    String? id,
    String? newMessage,
    List<ChatMessage>? messages,
  })  : id = id ?? const Uuid().v4(),
        newMessage = newMessage ?? '',
        messages = messages ?? List.empty();

  final String id;
  final String newMessage;
  final List<ChatMessage> messages;

  ChatState copyWith({
    String? id,
    required String newMessage,
    List<ChatMessage>? messages,
  }) {
    return ChatState(
      id: id ?? this.id,
      newMessage: newMessage,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [id, newMessage, messages];

  @override
  String toString() => 'ChatState { id: ${id}, newMessage: ${newMessage}, '
      'messages: ${messages.length} }';
}
