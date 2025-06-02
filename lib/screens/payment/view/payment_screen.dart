import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/screens/bottom/booking/view/booking_success_screen.dart';
import 'package:boxify/screens/payment/cubit/payment_cubit.dart';
import 'package:boxify/screens/payment/cubit/payment_state.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/image_resources.dart';

class PaymentScreen extends StatefulWidget {
  final String court;
  final String timeSlot;
  final String date;

  const PaymentScreen({
    super.key,
    required this.court,
    required this.timeSlot,
    required this.date,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              PaymentCubit()..loadPaymentDetails(
                court: widget.court,
                timeSlot: widget.timeSlot,
                date: widget.date,
              ),
      child: Scaffold(
        backgroundColor: Color(0xFFF3F4F8),
        appBar: appBar(context),
        body: BlocConsumer<PaymentCubit, PaymentState>(
          listener: (BuildContext context, Object? state) {},
          builder: (BuildContext context, state) {
            var paymentCubit = PaymentCubit.get(context);
            if (state is PaymentProcessLoaded) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: CustomText(
                        data: boxCricketTitle,
                        color: Color(0xFF0E7AFF),
                        fontWeight: FontWeight.w800,
                        fontSize: 25.sp,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      height: 115.h,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: Color(0xFFFFFFFF),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 15.h,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  courtIcon,
                                  height: 16.h,
                                  width: 16.w,
                                ),
                                SizedBox(width: 10.w),
                                CustomText(
                                  data: state.court,
                                  color: Color(0xFF636363),
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                Image.asset(
                                  calenderIcon,
                                  height: 16.h,
                                  width: 16.w,
                                ),
                                SizedBox(width: 10.w),
                                CustomText(
                                  data: state.date,
                                  color: Color(0xFF636363),
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                Image.asset(
                                  clockIcon,
                                  height: 16.h,
                                  width: 16.w,
                                ),
                                SizedBox(width: 10.w),
                                CustomText(
                                  data: state.timeSlot,
                                  color: Color(0xFF636363),
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      children: [
                        CustomText(
                          data: courtPrice,
                          color: Color(0xFF636363),
                          fontWeight: FontWeight.w700,
                        ),
                        Spacer(),
                        CustomText(
                          data: rate,
                          color: Color(0xFF636363),
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        CustomText(
                          data: advancePayable,
                          color: Color(0xFF636363),
                          fontWeight: FontWeight.w700,
                        ),
                        Spacer(),
                        CustomText(
                          data: state.isSelected ? rate : halfAmount,
                          color: Color(0xFF636363),
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    !state.isSelected
                        ? Row(
                          children: [
                            CustomText(
                              data: payAtVenue,
                              color: Color(0xFF636363),
                              fontWeight: FontWeight.w700,
                            ),
                            Spacer(),
                            CustomText(
                              data: halfAmount,
                              color: Color(0xFF636363),
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        )
                        : SizedBox(height: 22.h),
                    SizedBox(height: 20.h),
                    Stack(
                      children: [
                        Container(
                          height: 50.h,
                          width: 340.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Color(0xFFFFFFFF),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 15.h, left: 15.w),
                            child: CustomText(
                              data: payAdvance,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF636363),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 5,
                          child: Checkbox(
                            value: state.isSelected,
                            activeColor: Color(0xFF0E7AFF),
                            onChanged: (bool? value) {
                              paymentCubit.toggleCheckbox(value!);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 240.h),
                    Container(
                      height: 50.h,
                      width: 340.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Color(0xFFFFFFFF),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Row(
                          children: [
                            CustomText(
                              data: totalAmount,
                              fontWeight: FontWeight.w700,
                            ),
                            Spacer(),
                            CustomText(
                              data: state.isSelected ? rate : halfAmount,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingSuccessScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50.h,
                        width: 340.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Color(0xFF0E7AFF),
                        ),
                        child: Center(
                          child: CustomText(
                            data: proceedToPay,
                            fontWeight: FontWeight.w800,
                            fontSize: 15.sp,
                            color: Color(0xFFF3F4F8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is PaymentProcessError) {
              return Center(child: Text(state.message));
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}

// Appbar

AppBar appBar(BuildContext context) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.transparent,
    centerTitle: true,
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
    title: CustomText(
      data: boxName,
      fontWeight: FontWeight.w800,
      fontSize: 18.sp,
    ),
  );
}
