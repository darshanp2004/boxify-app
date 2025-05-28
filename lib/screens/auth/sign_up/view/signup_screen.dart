import 'package:boxify/custom_widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Utils/image_resources.dart';
import '../../../../custom_widgets/elevatedbutton.dart';
import '../../../../custom_widgets/textfield.dart';
import '../../../../utils/string.dart';
import '../cubit/signup_screen_cubit.dart';
import '../cubit/signup_screen_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (BuildContext context, SignUpState state) {},
        builder: (context, state) {
          var signUpCubit = SignUpCubit.get(context);
          return Scaffold(
            backgroundColor: Color(0xFFF3F4F8),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 100.h,
                  horizontal: 30.w,
                ),
                child: Form(
                  key: signUpCubit.formKey,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: CustomText(
                          data: createAcc,
                          inherit: true,
                          fontSize: 32.sp,
                          fontFamily: koulen,
                        ),
                      ),
                      SizedBox(height: 50.h),
                      CustomTextField(
                        controller: signUpCubit.userNameController,
                        hintText: userName,
                        icon: userIcon,
                        validator: signUpCubit.validateUsername,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: signUpCubit.emailController,
                        hintText: email,
                        icon: emailIcon,
                        validator: signUpCubit.validateEmail,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: signUpCubit.passwordController,
                        hintText: pass,
                        icon: lockIcon,
                        obscureText: true,
                        validator: signUpCubit.validatePassword,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: signUpCubit.confirmPasswordController,
                        hintText: confirmPass,
                        icon: lockIcon,
                        obscureText: true,
                        validator: signUpCubit.validateConfirmPassword,
                      ),
                      SizedBox(height: 40.h),
                      CustomElevatedButton(
                        text: signUp,
                        onPressed: () {
                          signUpCubit.validateInputs(context);
                        },
                        backgroundColor: Color(0XFF0E7AFF),
                        textColor: Color(0XFFFFFFFF),
                        borderColor: Colors.transparent,
                        fontWeight: FontWeight.w800,
                        fontSize: 12.sp,
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
                        onPressed: () {},
                        textColor: Color(0XFF1E1E1E),
                        fontWeight: FontWeight.w700,
                        fontSize: 12.sp,
                        borderColor: Color(0xFFD2D4DA),
                      ),
                      SizedBox(height: 10.h),
                      CustomElevatedButton(
                        text: googleLogin,
                        icon: googleIcon,
                        onPressed: () {},
                        textColor: Color(0XFF1E1E1E),
                        fontWeight: FontWeight.w700,
                        fontSize: 12.sp,
                        borderColor: Color(0xFFD2D4DA),
                      ),
                    ],
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
