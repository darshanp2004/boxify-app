import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/screens/bottom/booking/cubit/booking_process_cubit/booking_process_cubit.dart';
import 'package:boxify/screens/bottom/booking/cubit/booking_process_cubit/booking_process_state.dart';
import 'package:boxify/screens/payment/cubit/payment_cubit.dart';
import 'package:boxify/screens/payment/view/payment_screen.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

import '../../../../utils/image_resources.dart';

class BookingProcessScreen extends StatefulWidget {
  const BookingProcessScreen({super.key});

  @override
  State<BookingProcessScreen> createState() => _BookingProcessScreenState();
}

class _BookingProcessScreenState extends State<BookingProcessScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingProcessCubit()..initializeDates(),
      child: BlocConsumer<BookingProcessCubit, BookingProcessState>(
        listener: (BuildContext context, BookingProcessState state) {},
        builder: (BuildContext context, BookingProcessState state) {
          var bookingProcessCubit = BookingProcessCubit.get(context);
          return Scaffold(
            backgroundColor: Color(0xFFF3F4F8),
            appBar: appBar(context),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 35.w, right: 35.w, bottom: 25.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    CustomText(
                      data: selectDate,
                      fontWeight: FontWeight.w800,
                      fontSize: 18.sp,
                    ),
                    SizedBox(height: 15.h),
                    if (state is BookingProcessLoading)
                      Center(child: CircularProgressIndicator()),
                    if (state is SelectDateAndTime) ...[
                      dateAndDayList(state, bookingProcessCubit),
                      SizedBox(height: 30.h),
                      courtOneTimeSelection(state, bookingProcessCubit),
                      SizedBox(height: 20.h),
                      courtTwoTimeSelection(state, bookingProcessCubit),
                      SizedBox(height: 20.h),
                      CustomText(
                        data: duration,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => bookingProcessCubit.decrementHour(),
                            child: Container(
                              height: 50.h,
                              width: 110.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Color(0xFFFFFFFF),
                              ),
                              child: Icon(Icons.remove_rounded),
                            ),
                          ),
                          Column(
                            children: [
                              CustomText(
                                data: state.hour.toString().padLeft(2, "0"),
                                fontWeight: FontWeight.w700,
                                fontSize: 25.sp,
                              ),
                              CustomText(data: hours),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => bookingProcessCubit.incrementHour(),
                            child: Container(
                              height: 50.h,
                              width: 110.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Color(0xFFFFFFFF),
                              ),
                              child: Icon(Icons.add_rounded),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      if (bookingProcessCubit.validateTimeSelection())
                        Container(
                          height: 110.h,
                          width: 340.w,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 15.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CustomText(
                                      data: selectedSlot,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13.sp,
                                    ),
                                    Spacer(),
                                    CustomText(
                                      data:
                                          bookingProcessCubit
                                                  .selectedSlots["Court 1"]!
                                                  .isNotEmpty
                                              ? 'Court 1  •  ${(() {
                                                final slots = bookingProcessCubit.selectedSlots["Court 1"]!..sort();
                                                return slots.join(' to ');
                                              })()}'
                                              : 'Court 2  •  ${(() {
                                                final slots = bookingProcessCubit.selectedSlots["Court 2"]!..sort();
                                                return slots.join(' to ');
                                              })()}',
                                      fontSize: 13.sp,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h),
                                Row(
                                  children: [
                                    CustomText(
                                      data: date,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13.sp,
                                    ),
                                    Spacer(),
                                    CustomText(
                                      data:
                                          "${state.calender[state.selectedIndex]["day"]}, "
                                          "${state.calender[state.selectedIndex]["date"]} "
                                          "${state.calender[state.selectedIndex]["month"]}",
                                      fontSize: 13.sp,
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  children: [
                                    CustomText(
                                      data: totalAmount,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13.sp,
                                    ),
                                    Spacer(),
                                    CustomText(
                                      data: rate,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        SizedBox(height: 110.h),
                      SizedBox(height: 20.h),
                      GestureDetector(
                        onTap: () {
                          if (!bookingProcessCubit.validateTimeSelection()) {
                            toastification.show(
                              context: context,
                              type: ToastificationType.error,
                              title: CustomText(data: slotSelectionError),
                              autoCloseDuration: Duration(seconds: 3),
                              alignment: Alignment.topCenter,
                            );
                            return;
                          } else {
                            final selectedCourt =
                                bookingProcessCubit
                                            .selectedSlots["Court 1"]!
                                            .isNotEmpty ==
                                        true
                                    ? "Court 1"
                                    : "Court 2";
                            final selectedSlot = List<String>.from(
                              bookingProcessCubit.selectedSlots[selectedCourt]!,
                            );
                            selectedSlot.sort();
                            final date =
                                bookingProcessCubit.calender[bookingProcessCubit
                                      .selectedIndex];
                            final formattedDate =
                                "${date["day"]}, ${date["date"]} ${date["month"]}";
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentScreen(
                                  court: selectedCourt,
                                  timeSlot: selectedSlot.join(' to '),
                                  date: formattedDate,
                                ),
                              ),
                            );

                          }
                        },
                        child: Container(
                          width: 340.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: Color(0xFF0E7AFF),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: CustomText(
                              data: bookNow,
                              fontWeight: FontWeight.w800,
                              fontSize: 15.sp,
                              color: Color(0xFFF3F4F8),
                            ),
                          ),
                        ),
                      ),
                    ],
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


// Appbar

AppBar appBar(BuildContext context) {
  return AppBar(
    surfaceTintColor: Color(0xFFF3F4F8),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ),
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
    title: Padding(
      padding: EdgeInsets.only(left: 50.w),
      child: CustomText(
        data: boxName,
        fontWeight: FontWeight.w800,
        fontSize: 18.sp,
      ),
    ),
  );
}

// Date and Day list

Widget dateAndDayList(SelectDateAndTime state, BookingProcessCubit cubit) {
  return SizedBox(
    height: 130.h,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: state.calender.length,
      itemBuilder: (context, index) {
        final isSelected = (index == state.selectedIndex);
        final date = state.calender[index];
        return GestureDetector(
          onTap: () {
            cubit.selectDate(index);
          },
          child: Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  data: date["day"]!,
                  fontSize: 14.sp,
                  color: isSelected ? Color(0xFF0E7AFF) : Color(0xFFA6A6A6),
                ),
                SizedBox(height: 10.h),
                Container(
                  height: 100.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                    color: isSelected ? Color(0xFF0E7AFF) : Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 4.h),
                      CustomText(
                        data: date["month"]!,
                        color:
                            isSelected ? Color(0xFFFFFFFF) : Color(0xFF636363),
                      ),
                      SizedBox(height: 4.h),
                      CustomText(
                        data: date["date"]!,
                        fontWeight: FontWeight.w800,
                        fontSize: 25.sp,
                        color:
                            isSelected ? Color(0xFFFFFFFF) : Color(0xFF636363),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

// Court One GridView

Widget courtOneTimeSelection(
  SelectDateAndTime state,
  BookingProcessCubit cubit,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(data: courtOne, fontSize: 14.sp, fontWeight: FontWeight.w700),
      SizedBox(height: 10.h),
      GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: state.allSlots[courtOne]?.length ?? 0,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          mainAxisSpacing: 10.h,
          crossAxisSpacing: 10.w,
          childAspectRatio: 2,
        ),
        itemBuilder: (context, index) {
          final slot = state.allSlots[courtOne]![index];
          final isDisabled =
              state.disabledSlots[courtOne]?.contains(slot) ?? false;
          final isSelected =
              state.selectedSlots[courtOne]?.contains(slot) ?? false;
          return GestureDetector(
            onTap: () {
              if (!isDisabled) {
                cubit.selectSlot(courtOne, slot);
              }
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF0E7AFF) : Colors.transparent,
                border: Border.all(
                  color: isSelected ? Colors.transparent : Color(0xFF999999),
                ),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: CustomText(
                  data: slot,
                  color:
                      isDisabled
                          ? Color(0xFF999999)
                          : isSelected
                          ? Colors.white
                          : Color(0xFF1E1E1E),
                  fontSize: 12.sp,
                ),
              ),
            ),
          );
        },
      ),
    ],
  );
}

// Court Two GridView

Widget courtTwoTimeSelection(
  SelectDateAndTime state,
  BookingProcessCubit cubit,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(data: courtTwo, fontSize: 14.sp, fontWeight: FontWeight.w700),
      SizedBox(height: 10.h),
      GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: state.allSlots[courtTwo]?.length ?? 0,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          mainAxisSpacing: 10.h,
          crossAxisSpacing: 10.w,
          childAspectRatio: 2,
        ),
        itemBuilder: (context, index) {
          final slot = state.allSlots[courtTwo]![index];
          final isDisabled =
              state.disabledSlots[courtTwo]?.contains(slot) ?? false;
          final isSelected =
              state.selectedSlots[courtTwo]?.contains(slot) ?? false;
          return GestureDetector(
            onTap: () {
              if (!isDisabled) {
                cubit.selectSlot(courtTwo, slot);
              }
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF0E7AFF) : Colors.transparent,
                border: Border.all(
                  color: isSelected ? Colors.transparent : Color(0xFF999999),
                ),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: CustomText(
                  data: slot,
                  color:
                      isDisabled
                          ? Color(0xFF999999)
                          : isSelected
                          ? Colors.white
                          : Color(0xFF1E1E1E),
                  fontSize: 12.sp,
                ),
              ),
            ),
          );
        },
      ),
    ],
  );
}
