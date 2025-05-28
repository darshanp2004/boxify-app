import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/screens/bottom/bottom_navigation/view/bottom_navigation_screen.dart';
import 'package:boxify/utils/image_resources.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class ChangePasswordSuccess extends StatefulWidget {
  const ChangePasswordSuccess({super.key});

  @override
  State<ChangePasswordSuccess> createState() => _ChangePasswordSuccessState();
}

class _ChangePasswordSuccessState extends State<ChangePasswordSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F4F8),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 2 - 150,
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
                CustomText(data: passChangeSuccess, fontSize: 15.sp),
                SizedBox(height: 25.h),
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNavigationScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  child: Container(
                    height: 50.h,
                    width: 192.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Color(0xFF0E7AFF),
                    ),
                    child: Center(
                      child: CustomText(
                        data: backToHome,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFF3F4F8),
                      ),
                    ),
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
