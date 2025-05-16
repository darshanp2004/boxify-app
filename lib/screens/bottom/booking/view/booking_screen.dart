import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/screens/bottom/booking/cubit/booking_screen_cubit/bookingscreen_cubit.dart';
import 'package:boxify/screens/bottom/booking/cubit/booking_screen_cubit/bookingscreen_state.dart';
import 'package:boxify/screens/bottom/booking/view/booking_info_screen.dart';
import 'package:boxify/utils/image_resources.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingCubit()..initController(this),
      child: DefaultTabController(
        length: 3,
        child: BlocConsumer<BookingCubit, BookingState>(
          listener: (BuildContext context, BookingState state) {  },
          builder: (context, state) {
            final bookingCubit= BookingCubit.get(context);
            final cards = bookingCubit.cards;
            return Scaffold(
              backgroundColor: const Color(0xFFF3F4F8),
              appBar: AppBar(
                toolbarHeight: 100.h,
                backgroundColor: const Color(0xFFF3F4F8),
                title: Padding(
                  padding: EdgeInsets.only(left: 15.w, top: 30.h),
                  child: CustomText(
                    data: bookingText,
                    fontWeight: FontWeight.w800,
                    fontSize: 25.sp,
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50.h),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: TabBar(
                      controller: bookingCubit.tabController,
                      splashFactory: NoSplash.splashFactory,
                      labelPadding: EdgeInsets.zero,
                      dividerColor: Colors.transparent,
                      indicator: const BoxDecoration(),
                      onTap: bookingCubit.onTabSelected,
                      tabs: [
                        Tab(child: Button(text: upcoming, isSelected: state.selectedIndex == 0)),
                        Tab(child: Button(text: history, isSelected: state.selectedIndex == 1)),
                        Tab(child: Button(text: cancelled, isSelected: state.selectedIndex == 2)),
                      ],
                    ),
                  ),
                ),
              ),
              body: Column(
                children: [
                  SizedBox(height: 25.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: const Divider(),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: bookingCubit.tabController,
                      children: [
                        // Upcoming bookings
                        ListView.builder(
                          padding: EdgeInsets.only(top: 25.h),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            final card = cards[0];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 15.h),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const BookingInfoScreen(),
                                    ),
                                  );
                                },
                                child: Card(
                                  title: card.title,
                                  date: card.date,
                                  time: card.time,
                                  imagePath: card.image,
                                  isExpired: false,
                                ),
                              ),
                            );
                          },
                        ),
                        // History bookings
                        ListView.builder(
                          padding: EdgeInsets.only(top: 25.h),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            final card = cards[0];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 15.h),
                              child: Card(
                                title: card.title,
                                date: card.date,
                                time: card.time,
                                imagePath: card.image,
                                isExpired: true,
                              ),
                            );
                          },
                        ),
                        // Cancelled
                        Center(child: CustomText(data: noCancelled)),
                      ],
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

class Button extends StatelessWidget {
  final String text;
  final bool isSelected;

  const Button({super.key, required this.text, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 110.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.transparent,
        ),
      ),
      child: Center(
        child: CustomText(
          data: text,
          color: isSelected ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String imagePath;
  final bool isExpired;

  const Card({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.imagePath,
    required this.isExpired,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Container(
        height: 115.h,
        width: 340.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Container(
                height: 100.h,
                width: 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7.r),
                  child: Image.asset(imagePath, fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w, top: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomText(
                        data: title,
                        fontWeight: FontWeight.w800,
                        fontSize: 16.sp,
                      ),
                      if (isExpired == true)
                        Padding(
                          padding: EdgeInsets.only(left: 30.w),
                          child: Container(
                            height: 15.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: Color(0x4DFF0000),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 6.w, top: 3.h),
                              child: CustomText(data: expired, fontSize: 8.sp),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Image.asset(calenderIcon, height: 16.w, width: 16.w),
                      SizedBox(width: 6.w),
                      CustomText(
                        data: date,
                        color: Color(0xFF636363),
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Image.asset(clockIcon, height: 16.h, width: 16.w),
                      SizedBox(width: 6.w),
                      CustomText(
                        data: time,
                        color: Color(0xFF636363),
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
