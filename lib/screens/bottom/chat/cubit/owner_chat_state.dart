abstract class OwnerChatState {}

class ChatInitial extends OwnerChatState {}

class ChatLoading extends OwnerChatState{}

class ChatLoaded extends OwnerChatState {
  final List<bool> senderFlags;  final List<String> messages;

  ChatLoaded(this.messages, this.senderFlags);
}

class ChatError extends OwnerChatState {
  final String message;

  ChatError(this.message);
}
