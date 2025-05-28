import 'package:boxify/Utils/image_resources.dart';
import 'package:boxify/custom_widgets/elevatedbutton.dart';
import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/custom_widgets/textfield.dart';
import 'package:boxify/screens/password/change_password/cubit/change_password_cubit/change_password_cubit.dart';
import 'package:boxify/screens/password/change_password/cubit/change_password_cubit/change_password_state.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: Scaffold(
        backgroundColor: Color(0xFFF3F4F8),
        appBar: appBar(context),
        body: BlocConsumer<ChangePasswordCubit,ChangePasswordState>(
          listener: (BuildContext context, Object? state) {},
          builder: (BuildContext context, state) {
            var changePasswordCubit=ChangePasswordCubit.get(context);
            return Padding(
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
                    controller: changePasswordCubit.oldPasswordController,
                    hintText: oldPassword,
                    icon: lockIcon,
                    obscureText: true,
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: changePasswordCubit.newPasswordController,
                    hintText: newPassword,
                    icon: lockIcon,
                    obscureText: true,
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: changePasswordCubit.confirmPasswordController,
                    hintText: confirmPass,
                    icon: lockIcon,
                    obscureText: true,
                  ),
                  SizedBox(height: 20.h),
                  CustomElevatedButton(
                    text: resetPassword,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    backgroundColor: Color(0xFF0E7AFF),
                    textColor: Color(0xFFFFFFFF),
                    onPressed: () {changePasswordCubit.submitChangePassword(context);},
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: CustomText(
                      data: forgotPassText,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                ],
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
