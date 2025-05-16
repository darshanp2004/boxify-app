import 'package:boxify/custom_widgets/elevatedbutton.dart';
import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/screens/bottom/booking/cubit/booking_info_cubit/booking_info_cubit.dart';
import 'package:boxify/screens/bottom/booking/cubit/booking_info_cubit/booking_info_state.dart';
import 'package:boxify/screens/bottom/chat/cubit/owner_chat_cubit.dart';
import 'package:boxify/screens/bottom/chat/view/owner_chat_screen.dart';
import 'package:boxify/utils/image_resources.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingInfoScreen extends StatefulWidget {
  const BookingInfoScreen({super.key});

  @override
  State<BookingInfoScreen> createState() => _BookingInfoScreenState();
}

class _BookingInfoScreenState extends State<BookingInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingInfoCubit()..loadBookings(),
      child: Scaffold(
        backgroundColor: Color(0xFFF3F4F8),
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Color(0xFFFFFFFF),
          title: CustomText(data: yourBookings, fontWeight: FontWeight.w700),
        ),
        body: SingleChildScrollView(
          child: BlocConsumer<BookingInfoCubit, BookingInfoState>(
            listener: (BuildContext context, BookingInfoState state) {  },
            builder: (context, state) {
              if (state is BookingInfoLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is BookingInfoLoaded) {
                final booking = state.bookings[0];
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 50.h,
                        left: 25.w,
                        right: 25.w,
                      ),
                      child: BookingInfoCard(
                        title: booking.title,
                        court: booking.court!,
                        date: booking.date,
                        time: booking.time,
                        imagePath: booking.image,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Row(
                        children: [
                          CustomElevatedButton(
                            text: chatWithOwner,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => BlocProvider(
                                        create:
                                            (context) =>
                                                OwnerChatCubit()..loadChat(),
                                        child: OwnerChatScreen(),
                                      ),
                                ),
                              );
                            },
                            width: 180.w,
                            fontSize: 14.sp,
                            backgroundColor: Color(0xFF0E7AFF),
                            borderColor: Colors.transparent,
                            textColor: Colors.white,
                          ),
                          Spacer(),
                          CustomElevatedButton(
                            text: getDirection,
                            onPressed: () {},
                            width: 180.w,
                            fontSize: 14.sp,
                            backgroundColor: Color(0xFF0E7AFF),
                            borderColor: Colors.transparent,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: CustomElevatedButton(
                        text: cancelBooking,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => CancelBookingDialog(),
                          );
                        },
                        textColor: Color(0xFF636363),
                        borderColor: Color(0xFFC4C4C4),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                );
              } else if (state is BookingInfoError) {
                return Center(child: Text(state.message));
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}

class BookingInfoCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String court;
  final String imagePath;

  const BookingInfoCard({
    required this.title,
    required this.date,
    required this.time,
    required this.court,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 308.h,
      width: 340.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 150.h,
              width: 340.w,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                ),
                child: Image.asset(boxCricket, fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: CustomText(
              data: title,
              fontSize: 25.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: Row(
              children: [
                Image.asset(courtIcon, height: 16.h, width: 16.w),
                SizedBox(width: 10.w),
                CustomText(
                  data: court,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF636363),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: Row(
              children: [
                Image.asset(calenderIcon, height: 16.h, width: 16.w),
                SizedBox(width: 10.w),
                CustomText(
                  data: date,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF636363),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: Row(
              children: [
                Image.asset(clockIcon, height: 16.h, width: 16.w),
                SizedBox(width: 10.w),
                CustomText(
                  data: time,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF636363),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Cancel Dialog

class CancelBookingDialog extends StatelessWidget {
  const CancelBookingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: SizedBox(
        height: 300.h,
        child: Padding(
          padding: EdgeInsets.only(top: 25.h, bottom: 5.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(warningIcon, height: 75.h, width: 75.h),
              SizedBox(height: 10.h),
              CustomText(
                data: wantCancelBooking,
                color: Color(0xFFE43939),
                fontSize: 20.sp,
                fontWeight: FontWeight.w900,
              ),
              CustomText(
                data: boxCricketName,
                fontWeight: FontWeight.w700,
                fontSize: 10.sp,
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: CustomText(
                  data: areYouSure,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Container(
                  height: 50.h,
                  width: 400.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: Colors.grey[100],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomText(
                        data: yes,
                        fontWeight: FontWeight.w700,
                        fontSize: 15.sp,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.w),
                        child: VerticalDivider(),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: CustomText(
                          data: no,
                          fontWeight: FontWeight.w700,
                          fontSize: 15.sp,
                          color: Color(0xFF0E7AFF),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
