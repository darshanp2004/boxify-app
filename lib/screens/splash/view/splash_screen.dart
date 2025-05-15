import 'package:boxify/screens/bottom/bottom_navigation/view/bottom_navigation_screen.dart';
import 'package:boxify/screens/splash/cubit/splashscreen_cubit.dart';
import 'package:boxify/screens/splash/cubit/splashscreen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Utils/image_resources.dart';
import '../../auth/sign_in/view/signin_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return BlocProvider(
      create: (context)=>SplashCubit()..showSplash(),
      child: Scaffold(
        body: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is SplashNavigateToHome) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomNavigationScreen(),
                ),
              );
            } else if (state is SplashNavigateToLogin) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            }
          },
          child: BlocBuilder<SplashCubit, SplashState>(
            builder: (context, state) {
              if (state is SplashLoading) {
                return Image.asset(
                  splashImage,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.fill,
                );
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
