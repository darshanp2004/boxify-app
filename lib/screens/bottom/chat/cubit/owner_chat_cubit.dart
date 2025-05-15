import 'package:boxify/screens/bottom/chat/cubit/owner_chat_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerChatCubit extends Cubit<OwnerChatState> {
  OwnerChatCubit() : super(ChatInitial());

  bool isSender=false;

  final messageController = TextEditingController();


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
          "• Waiting Room\n\n"
          "and other accessibilities as well. ",
      "Thanks a lot!",
      "Hello, Urban Owner",
      "Hello, Joseph Anderson",
      "Can you share court amenities?",
      "Sure\n"
          "Here are the amenities of our court.\n\n  "
          "• Parking\n  "
          "• Changing Room\n  "
          "• Cafeteria\n  "
          "• Waiting Room\n\n"
          "and other accessibilities as well. ",
      "Thanks a lot!",
    ];
    emit(ChatLoaded(messages, isSender));
  }
}
