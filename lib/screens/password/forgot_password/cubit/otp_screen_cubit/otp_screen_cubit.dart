import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'otp_screen_state.dart';

class OtpScreenCubit extends Cubit<OtpScreenState> {
  OtpScreenCubit() : super(OtpScreenState(otpDigits: List.filled(6, '')));

  static OtpScreenCubit get(context) => BlocProvider.of(context);

  List<TextEditingController> controllers = List.generate(6, (context) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (context) => FocusNode());

  void updateDigit(int index, String value) {
    final updatedDigits = List<String>.from(state.otpDigits);
    updatedDigits[index] = value;
    emit(state.copyWith(otpDigits: updatedDigits));

    if (value.isNotEmpty && index < focusNodes.length - 1) {
      focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }
}
