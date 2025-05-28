import 'package:boxify/custom_widgets/elevatedbutton.dart';
import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/custom_widgets/textfield.dart';
import 'package:boxify/screens/password/forgot_password/cubit/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:boxify/screens/password/forgot_password/cubit/forgot_password_cubit/forgot_password_state.dart';
import 'package:boxify/screens/password/forgot_password/view/otp_screen.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/image_resources.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(),
      child: Scaffold(
        backgroundColor: Color(0xFFF3F4F8),
        appBar: appBar(context),
        body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (BuildContext context, ForgotPasswordState state) {},
          builder: (BuildContext context, ForgotPasswordState state) {
            var forgotPasswordCubit = ForgotPasswordCubit.get(context);
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.w),
              child: Form(
                key: forgotPasswordCubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      data: forgotPassword,
                      fontFamily: koulen,
                      fontSize: 32.sp,
                    ),
                    CustomText(data: pleaseEnterEmail, fontSize: 12.sp),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      controller: forgotPasswordCubit.emailController,
                      validator: forgotPasswordCubit.validateEmail,
                      hintText: enterEmail,
                      icon: emailIcon,
                      onChanged: forgotPasswordCubit.onEmailChanged,
                    ),
                    SizedBox(height: 20.h),
                    CustomElevatedButton(
                      text: sendCode,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      onPressed: () {
                        if (forgotPasswordCubit.isEmailValid) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => OtpScreen(
                                    email:
                                        forgotPasswordCubit
                                            .emailController
                                            .text,
                                  ),
                            ),
                          );
                        }
                      },
                      backgroundColor:
                          forgotPasswordCubit.isEmailValid
                              ? Color(0xFF0E7AFF)
                              : Color(0xFFD2D4DA),
                      textColor:
                          forgotPasswordCubit.isEmailValid
                              ? Color(0xFFFFFFFF)
                              : Color(0xFF1E1E1E),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Appbar

AppBar appBar(BuildContext context) {
  return AppBar(
    surfaceTintColor: Color(0xFFF3F4F8),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ),
    toolbarHeight: 80.h,
    backgroundColor: Colors.transparent,
    leading: Padding(
      padding: EdgeInsets.only(left: 25.w),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Transform.scale(
          scale: 0.35,
          child: Image.asset(leftArrowIcon, height: 24.h, width: 24.w),
        ),
      ),
    ),
  );
}
