import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

import '../../../../utils/image_resources.dart';

class BookingFailedScreen extends StatefulWidget {
  const BookingFailedScreen({super.key});

  @override
  State<BookingFailedScreen> createState() => _BookingFailedScreenState();
}

class _BookingFailedScreenState extends State<BookingFailedScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Color(0xFFF3F4F8),
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/2-150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RippleAnimation(
                  color: Color(0xFFE43939),
                  delay: Duration(milliseconds: 300),
                  repeat: true,
                  maxRadius: 50.r,
                  ripplesCount: 5,
                  duration: Duration(milliseconds: 6 * 300),
                  child: Container(
                    height: 100.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: Color(0xFFE43939),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(exclamation),
                  ),
                ),
                SizedBox(height: 50.h),
                CustomText(
                  data: oops,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w800,
                ),
                SizedBox(height: 10.h),
                CustomText(data: bookingError),
                SizedBox(height: 20.h),
                Container(
                  width: 192.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Color(0xFF0E7AFF),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: CustomText(
                      data: tryAgain,
                      fontWeight: FontWeight.w800,
                      fontSize: 15.sp,
                      color: Color(0xFFF3F4F8),
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
