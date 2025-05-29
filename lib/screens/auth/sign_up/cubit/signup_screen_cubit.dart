import 'package:boxify/screens/auth/sign_up/cubit/signup_screen_state.dart';
import 'package:boxify/screens/bottom/bottom_navigation/view/bottom_navigation_screen.dart';
import 'package:boxify/screens/bottom/home/view/home_screen.dart';
import 'package:boxify/screens/owner/details/owner_details/view/owner_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/string.dart';
import '../view/signup_screen.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return userValidator;
    }
    return null;
  }

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

  String? validateConfirmPassword(String? value) {
    if (passwordController.text != confirmPasswordController.text) {
      return passNotMatch;
    }
    return null;
  }

  Future<void> validateInputs(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      final signUpType = prefs.getString(key);
      if (signUpType == user) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigationScreen()),
          (route) => false,
        );
      } else if (signUpType == owner) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder:
                (context) => OwnerDetailsScreen(
                  username: userNameController.text,
                  email: emailController.text,
                ),
          ),
          (route) => false,
        );
      }
    }
  }
}
