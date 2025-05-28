import 'package:boxify/custom_widgets/elevatedbutton.dart';
import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/custom_widgets/textfield.dart';
import 'package:boxify/screens/password/forgot_password/cubit/otp_screen_cubit/otp_screen_cubit.dart';
import 'package:boxify/screens/password/forgot_password/cubit/otp_screen_cubit/otp_screen_state.dart';
import 'package:boxify/screens/password/forgot_password/view/new_password_screen.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/image_resources.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpScreenCubit(),
      child: Scaffold(
        appBar: appBar(context),
        backgroundColor: Color(0xFFF3F4F8),
        body: BlocConsumer<OtpScreenCubit, OtpScreenState>(
          listener: (BuildContext context, Object? state) {},
          builder: (BuildContext context, state) {
            final otpCubit = OtpScreenCubit.get(context);
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    data: enterCode,
                    fontFamily: koulen,
                    fontSize: 32.sp,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 12.sp, color: Colors.black),
                      children: [
                        TextSpan(text: sentCode),
                        TextSpan(
                          text: ' ${widget.email}',
                          style: TextStyle(color: Color(0xFF0E7AFF)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  otpBox(otpCubit),
                  SizedBox(height: 20.h),
                  CustomElevatedButton(
                    text: verify,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewPasswordScreen(),
                        ),
                      );
                    },
                    backgroundColor: Color(0xFF0E7AFF),
                    textColor: Color(0xFFFFFFFF),
                  ),
                  SizedBox(height: 10.h),
                  Center(child: CustomText(data: resendCode, fontSize: 15.sp)),
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

// OtpBox

Widget otpBox(OtpScreenCubit otpCubit) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: List.generate(6, (index) {
      return Container(
        width: 45.w,
        decoration: BoxDecoration(
          color: Color(0xFFD2D4DA),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: TextField(
          controller: otpCubit.controllers[index],
          focusNode: otpCubit.focusNodes[index],
          autofocus: true,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            counterText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
          onChanged: (value) {
            otpCubit.updateDigit(index, value);
          },
        ),
      );
    }),
  );
}
