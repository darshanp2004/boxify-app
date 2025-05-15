abstract class OwnerChatState {}

class ChatInitial extends OwnerChatState {}

class ChatLoading extends OwnerChatState{}

class ChatLoaded extends OwnerChatState {
  bool isSender;
  final List<String> messages;

  ChatLoaded(this.messages, this.isSender);
}

class ChatError extends OwnerChatState {
  final String message;

  ChatError(this.message);
}
