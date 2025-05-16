import 'package:boxify/custom_widgets/elevatedbutton.dart';
import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:boxify/custom_widgets/textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 100.h,
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
                            CustomText(data: welcomeText, fontSize: 32.sp,fontFamily: koulen,),
                            SizedBox(width: 10.w),
                            Padding(
                              padding: EdgeInsets.only(bottom: 7.0),
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
                        child: CustomText(data: forgotPassText,fontSize: 14.sp,),
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
                      ),
                      SizedBox(height: 10.h),
                      CustomElevatedButton(
                        text: signUp,
                        onPressed: () {
                          signInCubit.navigateToSignUp(context);
                        },
                        textColor: Color(0XFF1E1E1E),
                        fontWeight: FontWeight.w800,
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
                      ),
                      SizedBox(height: 10.h),
                      CustomElevatedButton(
                        text: googleLogin,
                        icon: googleIcon,
                        fontWeight: FontWeight.w700,
                        onPressed: () {},
                        textColor: Color(0XFF1E1E1E),
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
