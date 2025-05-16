import 'package:boxify/screens/bottom/chat/cubit/owner_chat_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerChatCubit extends Cubit<OwnerChatState> {
  OwnerChatCubit() : super(ChatInitial());

  static OwnerChatCubit get(context) => BlocProvider.of(context);

  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  void loadChat() async {
    emit(ChatLoading());
    await Future.delayed(Duration(seconds: 1));
    List<String> messages = [
      "Hello, Urban Owner",
      "Hello, Joseph Anderson",
      "Can you share court amenities?",
      "Sure\n"
          "Here are the amenities of our court.\n\n  "
          "• Parking\n  "
          "• Changing Room\n  "
          "• Cafeteria\n  "
          "• Waiting Room\n\n  "
          "and other accessibilities as well..",
      "Thanks a lot!",
    ];
    List<bool> senderFlags = List.generate(
      messages.length,
      (index) => index % 2 == 0,
    );
    emit(ChatLoaded(messages, senderFlags));
  }

  void scrollToBottom() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void sendMessage() {
    final text = messageController.text.trim();
    if(text.isEmpty) return;
    if (state is ChatLoaded) {
      final currentState = state as ChatLoaded;
      final updatedMessages = List<String>.from(currentState.messages)
        ..add(text);
      final updatedSenderFlags = List<bool>.from(currentState.senderFlags)
        ..add(true);
      messageController.clear();
      emit(ChatLoaded(updatedMessages, updatedSenderFlags));
    }
  }
}
