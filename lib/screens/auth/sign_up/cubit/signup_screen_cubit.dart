import 'package:boxify/screens/auth/sign_up/cubit/models/sign_up_response_model.dart';
import 'package:boxify/screens/auth/sign_up/cubit/signup_screen_state.dart';
import 'package:boxify/screens/bottom/bottom_navigation/view/bottom_navigation_screen.dart';
import 'package:boxify/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/string.dart';
import 'models/sign_up_request_model.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final ApiService _apiService = ApiService();

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

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );
    return await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );
  }

  Future<void> validateInputs(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      Position? position = await getCurrentLocation();

      if (position == null) {
        emit(state.copyWith(isLoading: false));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.location_off, color: Colors.white),
                SizedBox(width: 12.w),
                Expanded(child: Text("Please turn on your location")),
              ],
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            elevation: 10,
            duration: Duration(seconds: 3),
            margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.w),
          ),
        );
        return;
      }

      final request = SignUpRequestModel(
        userName: userNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        latitude: position.latitude,
        longitude: position.longitude,
      );

      final SignUpResponseModel? response = await _apiService.signUp(request);

      if (response != null && response.meta?.isSuccess == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool(signupKey, true);
        await prefs.setString('token', response.data!.token ?? '');

        emit(state.copyWith(isLoading: false));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigationScreen()),
        );
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: response?.meta?.message ?? signUpError,
          ),
        );
      }
    }
  }
}
