import 'dart:ui';

import 'package:boxify/custom_widgets/elevatedbutton.dart';
import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/screens/auth/sign_up/view/signup_screen.dart';
import 'package:boxify/screens/password/forgot_password/view/forgot_password_screen.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:boxify/custom_widgets/textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Utils/image_resources.dart';
import '../cubit/signin_screen_cubit.dart';
import '../cubit/signin_screen_state.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: BlocConsumer<SignInCubit, SignInState>(
        listener: (BuildContext context, SignInState state) {},
        builder: (context, state) {
          var signInCubit = SignInCubit.get(context);
          return Scaffold(
            backgroundColor: Color(0xFFF3F4F8),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 9,
                    horizontal: 30.w,
                  ),
                  child: Form(
                    key: signInCubit.formKey,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              CustomText(
                                data: welcomeText,
                                fontSize: 32.sp,
                                fontFamily: koulen,
                              ),
                              SizedBox(width: 10.w),
                              Padding(
                                padding: EdgeInsets.only(bottom: 5.h),
                                child: Image.asset(
                                  wavingHand,
                                  height: 25.h,
                                  width: 30.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 50.h),
                        CustomTextField(
                          controller: signInCubit.emailController,
                          hintText: emailOrUser,
                          icon: userIcon,
                          validator: signInCubit.validateEmail,
                        ),
                        SizedBox(height: 10.h),
                        CustomTextField(
                          controller: signInCubit.passwordController,
                          hintText: pass,
                          icon: lockIcon,
                          obscureText: true,
                          validator: signInCubit.validatePassword,
                        ),
                        SizedBox(height: 5.h),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordScreen(),
                                ),
                              );
                            },
                            child: CustomText(
                              data: forgotPassText,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        CustomElevatedButton(
                          text: logIn,
                          onPressed: () {
                            signInCubit.validateInputs(context);
                          },
                          backgroundColor: Color(0XFF0E7AFF),
                          textColor: Color(0XFFFFFFFF),
                          fontWeight: FontWeight.w800,
                          borderColor: Colors.transparent,
                          fontSize: 12.sp,
                        ),
                        SizedBox(height: 10.h),
                        CustomElevatedButton(
                          text: signUp,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            showDialog(
                              context: context,
                              builder: (context) => RegisterDialog(),
                            );
                          },
                          textColor: Color(0XFF1E1E1E),
                          fontWeight: FontWeight.w800,
                          fontSize: 12.sp,
                          borderColor: Color(0xFFD2D4DA),
                        ),
                        SizedBox(height: 30.h),
                        Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.only(left: 8.w, right: 8.w),
                              child: CustomText(
                                data: or,
                                color: Color(0XFF1E1E1E),
                              ),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        SizedBox(height: 30.h),
                        CustomElevatedButton(
                          text: appleLogin,
                          icon: appleIcon,
                          fontWeight: FontWeight.w700,
                          onPressed: () {},
                          textColor: Color(0XFF1E1E1E),
                          fontSize: 12.sp,
                          borderColor: Color(0xFFD2D4DA),
                        ),
                        SizedBox(height: 10.h),
                        CustomElevatedButton(
                          text: googleLogin,
                          icon: googleIcon,
                          fontWeight: FontWeight.w700,
                          onPressed: () {},
                          textColor: Color(0XFF1E1E1E),
                          fontSize: 12.sp,
                          borderColor: Color(0xFFD2D4DA),
                        ),
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

// Dialog

class RegisterDialog extends StatelessWidget {
  const RegisterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: SizedBox(
          height: 300.h,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString(key, user);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: Container(
                    height: 60.h,
                    width: 240.w,
                    decoration: BoxDecoration(
                      color: Color(0xFF0E7AFF),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: CustomText(
                        data: signUpAsUser,
                        fontWeight: FontWeight.w800,
                        fontSize: 15.sp,
                        color: Color(0xFFF3F4F8),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 8.w),
                      child: CustomText(data: or, color: Color(0XFF1E1E1E)),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: 30.h),
                GestureDetector(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString(key, owner);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: CustomText(
                    data: signUpAsOwner,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1E1E1E),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
