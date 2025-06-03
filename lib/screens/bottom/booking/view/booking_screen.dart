import 'dart:ui';
import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/screens/bottom/booking/cubit/booking_screen_cubit/bookingscreen_cubit.dart';
import 'package:boxify/screens/bottom/booking/cubit/booking_screen_cubit/bookingscreen_state.dart';
import 'package:boxify/screens/bottom/booking/view/booking_info_screen.dart';
import 'package:boxify/utils/image_resources.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
          listener: (BuildContext context, BookingState state) {},
          builder: (context, state) {
            final bookingCubit = BookingCubit.get(context);
            final cards = bookingCubit.cards;
            return Scaffold(
              backgroundColor: Color(0xFFF3F4F8),
              appBar: appBar(bookingCubit, state),
              body: Column(
                children: [
                  SizedBox(height: 25.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Divider(),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: bookingCubit.tabController,
                      children: [
                        upcomingList(cards),
                        historyList(cards),
                        cancelledList(cards),
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
          color: isSelected ?Color(0xFF0E7AFF) : Colors.transparent,
        ),
      ),
      child: Center(
        child: CustomText(
          data: text,
          fontSize: 12.sp,
          color: isSelected ? Color(0xFF0E7AFF): Color(0xFF636363),
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
  final bool isCancelled;
  final bool showStatus;
  final bool showRatingPrompt;

  const Card({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.imagePath,
    this.isCancelled = false,
    this.showStatus = true,
    this.showRatingPrompt = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Container(
        height: 122.h,
        width: 340.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.w, top: 8, bottom: 8),
              child: Container(
                height: showRatingPrompt ? 140.h : 110.h,
                width: 110.h,
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
              padding: EdgeInsets.only(
                left: 10.w,
                top: showRatingPrompt ? 8.h : 20.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomText(
                        data: title,
                        fontWeight: FontWeight.w800,
                        fontSize: 16.sp,
                        color: Color(0xFF1E1E1E),
                      ),
                      if (showStatus)
                        Padding(
                          padding: EdgeInsets.only(left: 15.w),
                          child: Container(
                            height: 15.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color:
                                  isCancelled
                                      ? Color(0x33EF2D2D)
                                      : Color(0x3334A853),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 3.h),
                              child: Center(
                                child: CustomText(
                                  data: isCancelled ? cancelled : completed,
                                  fontSize: 8.sp,
                                  color:
                                      isCancelled
                                          ? Color(0xFFEF2D2D)
                                          : Color(0xFF34A853),
                                ),
                              ),
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
                      Transform.translate(
                        offset: Offset(0, 1),
                        child: CustomText(
                          data: date,
                          fontSize: 15.sp,
                          color: Color(0xFF636363),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Image.asset(clockIcon, height: 16.h, width: 16.w),
                      SizedBox(width: 6.w),
                      Transform.translate(
                        offset: Offset(0, 1),
                        child: CustomText(
                          data: time,
                          fontSize: 15.sp,
                          color: Color(0xFF636363),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  if (showRatingPrompt)
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: GestureDetector(
                       onTap: (){ratingsBottomSheet(context);},
                        child: Row(
                          children: [
                            CustomText(
                              data: rateBoxCricket,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0E7AFF),
                            ),
                            Icon(Icons.arrow_forward_ios,size: 9.sp,color: Color(0xFF0E7AFF),)
                          ],
                        ),
                      ),
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

// AppBar

AppBar appBar(BookingCubit bookingCubit, BookingState state) {
  return AppBar(
    toolbarHeight: 100.h,
    backgroundColor: Color(0xFFF3F4F8),
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
          indicator: BoxDecoration(),
          onTap: bookingCubit.onTabSelected,
          tabs: [
            Tab(
              child: Button(
                text: upcoming,
                isSelected: state.selectedIndex == 0,
              ),
            ),
            Tab(
              child: Button(
                text: history,
                isSelected: state.selectedIndex == 1,
              ),
            ),
            Tab(
              child: Button(
                text: cancelled,
                isSelected: state.selectedIndex == 2,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ListView

Widget upcomingList(List cards) {
  return ListView.builder(
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
              MaterialPageRoute(builder: (context) => BookingInfoScreen()),
            );
          },
          child: Card(
            title: card.title,
            date: card.date,
            time: card.time,
            imagePath: card.image,
            showStatus: false,
          ),
        ),
      );
    },
  );
}

Widget historyList(List cards) {
  return ListView.builder(
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
          isCancelled: false,
          showRatingPrompt: true,
        ),
      );
    },
  );
}

Widget cancelledList(List cards) {
  return ListView.builder(
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
          isCancelled: true,
        ),
      );
    },
  );
}

// Ratings BottomSheet

Future<void> ratingsBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            height: 368.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 30.h, left: 30.w, right: 30.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CustomText(
                        data: rateBoxCricket,
                        fontWeight: FontWeight.w700,
                        fontSize: 24.sp,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: Color(0xFF1E1E1E),
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  RatingBar(
                    initialRating: 1,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 10.w),
                    ratingWidget: RatingWidget(
                      full: Icon(Icons.star_rounded, color: Color(0xFF0E7AFF)),
                      half: Icon(Icons.star_half_rounded, color: Color(0xFF0E7AFF)),
                      empty: Icon(Icons.star_border_rounded, color: Color(0xFF0E7AFF)),
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 127.h,
                    child: TextFormField(
                      maxLines: 10,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: postComment,
                        hintStyle: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: andersonGrotesk,
                          color: Color(0xFF999999),
                        ),
                        contentPadding: EdgeInsets.only(top: 10.h, left: 15.w),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          borderSide: BorderSide(color: Color(0XFFD2D4DA)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          borderSide: BorderSide(color: Color(0XFF0E7AFF)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomText(
                        data: cancel,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.sp,
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        width: 63.w,
                        height: 31.h,
                        decoration: BoxDecoration(
                          color: Color(0xFF0E7AFF),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: CustomText(
                            data: post,
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w700,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
