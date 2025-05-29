import 'package:boxify/utils/string.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splashscreen_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void showSplash() async {
    emit(SplashLoading());
    await Future.delayed(Duration(seconds: 2));
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool(loginKey) ?? false;
    final isSignedUp = prefs.getString(key);
    if (isSignedUp == user) {
      emit(SplashNavigateToHome());
    } else if (isSignedUp == owner) {
      emit(SplashNavigateToOwner());
    } else if (isLoggedIn) {
      emit(SplashNavigateToHome());
    } else {
      emit(SplashNavigateToLogin());
    }
  }
}
