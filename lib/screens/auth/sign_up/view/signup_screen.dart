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
      child: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 100.h,
                  horizontal: 30.w,
                ),
                child: Form(
                  key: context.read<SignUpCubit>().formKey,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: CustomText(
                          data: createAcc,
                          inherit: true,
                          fontSize: 35.sp,
                        ),
                      ),
                      SizedBox(height: 50.h),
                      CustomTextField(
                        controller:
                            context.read<SignUpCubit>().userNameController,
                        hintText: userName,
                        icon: userIcon,
                        validator: context.read<SignUpCubit>().validateUsername,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: context.read<SignUpCubit>().emailController,
                        hintText: email,
                        icon: emailIcon,
                        validator: context.read<SignUpCubit>().validateEmail,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller:
                            context.read<SignUpCubit>().passwordController,
                        hintText: pass,
                        icon: lockIcon,
                        obscureText: true,
                        validator: context.read<SignUpCubit>().validatePassword,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller:
                            context
                                .read<SignUpCubit>()
                                .confirmPasswordController,
                        hintText: confirmPass,
                        icon: lockIcon,
                        obscureText: true,
                        validator:
                            context.read<SignUpCubit>().validateConfirmPassword,
                      ),
                      SizedBox(height: 40.h),
                      CustomElevatedButton(
                        text: signUp,
                        onPressed: () {
                          context.read<SignUpCubit>().validateInputs(context);
                        },
                        backgroundColor: Color(0XFF0E7AFF),
                        textColor: Color(0XFFFFFFFF),
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
                        iconHeight: 20.h,
                        iconWidth: 35.w,
                        onPressed: () {},
                        textColor: Color(0XFF1E1E1E),
                      ),
                      SizedBox(height: 10.h),
                      CustomElevatedButton(
                        text: googleLogin,
                        icon: googleIcon,
                        iconHeight: 30.h,
                        iconWidth: 35.w,
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
