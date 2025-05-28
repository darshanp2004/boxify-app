import 'package:boxify/custom_widgets/elevatedbutton.dart';
import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/screens/auth/sign_in/view/signin_screen.dart';
import 'package:boxify/screens/password/forgot_password/cubit/forgot_password_success_cubit/forgot_password_success_cubit.dart';
import 'package:boxify/screens/password/forgot_password/cubit/forgot_password_success_cubit/forgot_password_success_state.dart';
import 'package:boxify/utils/image_resources.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class ForgotPasswordSuccessScreen extends StatefulWidget {
  const ForgotPasswordSuccessScreen({super.key});

  @override
  State<ForgotPasswordSuccessScreen> createState() => _ForgotPasswordSuccessScreenState();
}

class _ForgotPasswordSuccessScreenState extends State<ForgotPasswordSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordSuccessCubit()..startTimer(),
      child:
          BlocConsumer<ForgotPasswordSuccessCubit, ForgotPasswordSuccessState>(
            listener: (BuildContext context, ForgotPasswordSuccessState state) {
              if (state is ForgotSuccess) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                  (route) => false,
                );
              }
            },
            builder: (BuildContext context, ForgotPasswordSuccessState state) {
              return PopScope(
                canPop: false,
                child: Scaffold(
                  backgroundColor: Color(0xFFF3F4F8),
                  body: SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 2 - 100,
                        ),
                        child: Column(
                          children: [
                            RippleAnimation(
                              color: Color(0xFF0E7AFF),
                              delay: Duration(milliseconds: 300),
                              repeat: true,
                              maxRadius: 50.r,
                              ripplesCount: 5,
                              duration: Duration(milliseconds: 6 * 300),
                              child: Container(
                                height: 100.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: Color(0xFF0E7AFF),
                                  shape: BoxShape.circle,
                                ),
                                child: Transform.scale(
                                  scale: 0.45,
                                  child: Image.asset(okIcon),
                                ),
                              ),
                            ),
                            SizedBox(height: 30.h),
                            CustomText(
                              data: congratulations,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w800,
                            ),
                            CustomText(
                              data: passChangeSuccess,
                              fontSize: 15.sp,
                            ),
                            SizedBox(height: 25.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }
}
