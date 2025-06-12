import 'package:boxify/screens/auth/sign_in/cubit/signin_screen_state.dart';
import 'package:boxify/screens/bottom/bottom_navigation/view/bottom_navigation_screen.dart';
import 'package:boxify/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/string.dart';
import 'models/sign_in_request_model.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInState());

  static SignInCubit get(context) => BlocProvider.of(context);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final ApiService _apiService = ApiService();

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
    if (!formKey.currentState!.validate()) return;

    emit(state.copyWith(isLoading: true, errorMessage: null));

    final request = SignInRequestModel(
      emailOrUserName: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    try {
      final response = await _apiService.signIn(request);

      if (response != null && response.meta?.isSuccess == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool(loginKey, true);
        await prefs.setString('token', response.data!.token ?? '');

        emit(state.copyWith(isLoading: false, errorMessage: null));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigationScreen()),
        );
      } else {
        final errorMessage = response?.meta?.message?.isNotEmpty == true
            ? response!.meta!.message!
            : loginError;

        emit(state.copyWith(isLoading: false, errorMessage: errorMessage));
      }
    } on DioException catch (dioError) {
      String errorMessage = loginError;
      if (dioError.response?.data != null) {
        try {
          final responseData = dioError.response?.data;
          errorMessage = responseData['meta']?['message'] ?? loginError;
        } catch (_) {
          errorMessage = loginError;
        }
      }

      emit(state.copyWith(isLoading: false, errorMessage: errorMessage));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Unexpected error occurred. Please try again.',
      ));
    }
  }


  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
