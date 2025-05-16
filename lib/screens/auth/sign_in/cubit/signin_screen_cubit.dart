import 'package:boxify/screens/auth/sign_in/cubit/signin_screen_state.dart';
import 'package:boxify/screens/bottom/bottom_navigation/view/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/string.dart';
import '../../sign_up/view/signup_screen.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInState());

  static SignInCubit get(context) => BlocProvider.of(context);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? validateEmail(String? value) {
    final isEmailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value!);

    if (value.isEmpty) {
      return emailValidator;
    }
    if (!isEmailValid) {
      return invalidEmail;
    }
    return null;
  }

  String? validatePassword(String? value) {
    final isPasswordValid = (value)!.length >= 8;

    if (value.isEmpty) {
      return passwordValidator;
    }
    if (!isPasswordValid) {
      return invalidPass;
    }
    return null;
  }

  Future<void> validateInputs(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(loginKey, true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavigationScreen()),
      );
    }
  }

  void navigateToSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }
}
