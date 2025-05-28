import 'package:boxify/custom_widgets/elevatedbutton.dart';
import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/custom_widgets/textfield.dart';
import 'package:boxify/screens/password/forgot_password/cubit/new_password_cubit/new_password_cubit.dart';
import 'package:boxify/screens/password/forgot_password/cubit/new_password_cubit/new_password_state.dart';
import 'package:boxify/screens/password/forgot_password/view/forgot_password_success_screen.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/image_resources.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewPasswordCubit(),
      child: BlocConsumer<NewPasswordCubit, NewPasswordState>(
        listener: (BuildContext context, NewPasswordState state) {},
        builder: (BuildContext context, NewPasswordState state) {
          var newPasswordCubit = NewPasswordCubit.get(context);
          return Scaffold(
            backgroundColor: Color(0xFFF3F4F8),
            appBar: appBar(context),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    data: newPass,
                    fontSize: 32.sp,
                    fontFamily: koulen,
                  ),
                  CustomText(data: createNewPass, fontSize: 12.sp),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    controller: newPasswordCubit.newPasswordController,
                    hintText: oldPassword,
                    icon: lockIcon,
                    obscureText: true,
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: newPasswordCubit.confirmPasswordController,
                    hintText: newPassword,
                    icon: lockIcon,
                    obscureText: true,
                  ),
                  SizedBox(height: 15.h),
                  CustomElevatedButton(
                    text: resetPassword,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    backgroundColor: Color(0xFF0E7AFF),
                    textColor: Color(0xFFFFFFFF),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordSuccessScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
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
