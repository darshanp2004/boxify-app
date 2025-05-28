import 'package:boxify/screens/password/forgot_password/view/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordState());

  static ForgotPasswordCubit get(context) => BlocProvider.of(context);

  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isEmailValid = false;

  void onEmailChanged(String value) {
    isEmailValid = (validateEmail(value) == null);
    emit(ForgotPasswordState());
  }

  String? validateEmail(String? value) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value!)) return 'Enter a valid email';
    return null;
  }

}
