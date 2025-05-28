import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/screens/bottom/booking/cubit/booking_success_cubit/booking_success_cubit.dart';
import 'package:boxify/screens/bottom/booking/cubit/booking_success_cubit/booking_success_state.dart';
import 'package:boxify/screens/bottom/bottom_navigation/view/bottom_navigation_screen.dart';
import 'package:boxify/utils/image_resources.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

import '../../bottom_navigation/cubit/bottom_navigation_cubit.dart';

class BookingSuccessScreen extends StatefulWidget {
  const BookingSuccessScreen({super.key});

  @override
  State<BookingSuccessScreen> createState() => _BookingSuccessScreenState();
}

class _BookingSuccessScreenState extends State<BookingSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingSuccessCubit(),
      child: BlocConsumer<BookingSuccessCubit, BookingSuccessState>(
        listener: (BuildContext context, BookingSuccessState state) {},
        builder: (BuildContext context, BookingSuccessState state) {
          var bookingSuccessCubit = BookingSuccessCubit.get(context);
          return Scaffold(
            backgroundColor: Color(0xFFF3F4F8),
            body: Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 2 - 150,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                        child: Image.asset(starSharp),
                      ),
                    ),
                    SizedBox(height: 50.h),
                    CustomText(
                      data: congratulations,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w800,
                    ),
                    SizedBox(height: 10.h),
                    CustomText(data: bookedSuccessfully),
                    SizedBox(height: 20.h),
                    InkWell(
                      onTap: () {
                      },
                      child: Container(
                        width: 192.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Color(0xFF0E7AFF),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: CustomText(
                            data: viewBookingDetails,
                            fontWeight: FontWeight.w800,
                            fontSize: 15.sp,
                            color: Color(0xFFF3F4F8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
