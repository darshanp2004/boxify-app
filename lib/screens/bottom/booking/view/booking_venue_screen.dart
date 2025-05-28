import 'package:boxify/custom_widgets/elevatedbutton.dart';
import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/screens/bottom/booking/cubit/booking_venue_cubit/booking_venue_cubit.dart';
import 'package:boxify/screens/bottom/booking/cubit/booking_venue_cubit/booking_venue_state.dart';
import 'package:boxify/screens/bottom/booking/view/booking_process_screen.dart';
import 'package:boxify/utils/image_resources.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingVenueScreen extends StatefulWidget {
  const BookingVenueScreen({super.key});

  @override
  State<BookingVenueScreen> createState() => _BookingVenueScreenState();
}

class _BookingVenueScreenState extends State<BookingVenueScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingVenueCubit()..initializeSlots(),
      child: BlocConsumer<BookingVenueCubit, BookingVenueState>(
        listener: (BuildContext context, BookingVenueState state) {},
        builder: (BuildContext context, BookingVenueState state) {
          final bookingVenueCubit = BookingVenueCubit.get(context);
          final amenities = bookingVenueCubit.amenitiesList;
          return Scaffold(
            backgroundColor: Color(0xFFF3F4F8),
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  surfaceTintColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  expandedHeight: 200.h,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        Image.asset(
                          boxCricket,
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 15.h,
                          right: 300.w,
                          child: Transform.scale(
                            scale: 0.3,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(backIcon),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 15.h,
                          left: 300.w,
                          child: Transform.scale(
                            scale: 0.3,
                            child: Image.asset(shareIcon),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            CustomText(
                              data: boxName,
                              fontWeight: FontWeight.w800,
                              fontSize: 25.sp,
                            ),
                            Spacer(),
                            CustomText(
                              data: rate,
                              fontWeight: FontWeight.w800,
                              fontSize: 25.sp,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 20.h),
                              child: Image.asset(
                                locationIcon,
                                height: 20.h,
                                width: 20.w,
                                color: Color(0xFF636363),
                              ),
                            ),
                            SizedBox(width: 10.h),
                            CustomText(data: address, color: Color(0xFF636363)),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Container(
                              height: 50.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Color(0xFFD2D4DA)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 15.h,
                                  horizontal: 20.h,
                                ),
                                child: CustomText(data: venueDistance),
                              ),
                            ),
                            Spacer(),
                            Container(
                              height: 50.h,
                              width: 250.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Color(0xFFD2D4DA)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 3.h),
                                    child: Image.asset(
                                      googleMapIcon,
                                      height: 17.h,
                                      width: 17.w,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 15.h,
                                    ),
                                    child: CustomText(data: getDirection),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            CustomText(
                              data: rating,
                              fontWeight: FontWeight.w800,
                              fontSize: 18.sp,
                            ),
                            SizedBox(width: 10.w),
                            Container(
                              height: 24.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                color: Color(0xFF0E7AFF),
                                borderRadius: BorderRadius.circular(7.r),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 4.h,
                                      ),
                                      child: CustomText(
                                        data: ratingValue,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 5.w),
                                    Image.asset(
                                      starIconPng,
                                      height: 11.h,
                                      width: 11.w,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Divider(),
                        SizedBox(height: 5.h),
                        CustomText(
                          data: amenitiesText,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                        ),
                        SizedBox(height: 15.h),
                        amenitiesList(amenities),
                        SizedBox(height: 15.h),
                        CustomText(
                          data: aboutVenue,
                          fontWeight: FontWeight.w800,
                          fontSize: 18.sp,
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              data: "\u2022 ",
                              color: Color(0xFF636363),
                            ),
                            SizedBox(width: 10.w),
                            CustomText(
                              data: address1,
                              color: Color(0xFF636363),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              data: "\u2022 ",
                              color: Color(0xFF636363),
                            ),
                            SizedBox(width: 10.w),
                            CustomText(data: address, color: Color(0xFF636363)),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Divider(),
                        SizedBox(height: 15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            CustomText(
                              data: courtOne,
                              fontWeight: FontWeight.w800,
                              fontSize: 15.sp,
                            ),
                            SizedBox(width: 10.w),
                            CustomText(
                              data: avlTime,
                              color: Color(0xFF0E7AFF),
                              fontSize: 15.sp,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        if (state is BookingSlots)
                          GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.allSlots[courtOne]?.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 6,
                                  mainAxisSpacing: 10.h,
                                  crossAxisSpacing: 10.w,
                                  childAspectRatio: 2,
                                ),
                            itemBuilder: (context, index) {
                              final slot = state.allSlots[courtOne]![index];
                              final isDisabled =
                                  state.disabledSlots[courtOne]?.contains(
                                    slot,
                                  ) ??
                                  false;
                              final isSelected =
                                  state.selectedSlots[courtOne]?.contains(
                                    slot,
                                  ) ??
                                  false;
                              return GestureDetector(
                                onTap: () {
                                  if (!isDisabled) {
                                    bookingVenueCubit.selectSlot(
                                      courtOne,
                                      slot,
                                    );
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color:
                                        isSelected
                                            ? Color(0xFF0E7AFF)
                                            : Colors.transparent,
                                    border: Border.all(
                                      color:
                                          isSelected
                                              ? Colors.transparent
                                              : Color(0xFF999999),
                                    ),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 4.h,
                                    ),
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
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            CustomText(
                              data: courtTwo,
                              fontWeight: FontWeight.w800,
                              fontSize: 15.sp,
                            ),
                            SizedBox(width: 10.w),
                            CustomText(
                              data: avlTime,
                              color: Color(0xFF0E7AFF),
                              fontSize: 15.sp,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        if (state is BookingSlots)
                          GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.allSlots[courtTwo]?.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 6,
                                  mainAxisSpacing: 10.h,
                                  crossAxisSpacing: 10.w,
                                  childAspectRatio: 2,
                                ),
                            itemBuilder: (context, index) {
                              final slot = state.allSlots[courtTwo]![index];
                              final isDisabled =
                                  state.disabledSlots[courtTwo]?.contains(
                                    slot,
                                  ) ??
                                  false;
                              final isSelected =
                                  state.selectedSlots[courtTwo]?.contains(
                                    slot,
                                  ) ??
                                  false;
                              return GestureDetector(
                                onTap: () {
                                  if (!isDisabled) {
                                    bookingVenueCubit.selectSlot(
                                      courtTwo,
                                      slot,
                                    );
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color:
                                        isSelected
                                            ? Color(0xFF0E7AFF)
                                            : Colors.transparent,
                                    border: Border.all(
                                      color:
                                          isSelected
                                              ? Colors.transparent
                                              : Color(0xFF999999),
                                    ),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 4.h,
                                    ),
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
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(
                left: 25.w,
                right: 25.w,
                bottom: 25.h,
                top: 10.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Color(0xFF0E7AFF)),
                    ),
                    child: Transform.scale(
                      scale: 0.5,
                      child: Image.asset(heartIcon),
                    ),
                  ),
                   GestureDetector(
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingProcessScreen()));
                     },
                     child: Container(
                        width: 250.w,
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
              ),
            ),
          );
        },
      ),
    );
  }
}

// Amenities list

Widget amenitiesList(List<Map<String, String>> amenities) {
  return SizedBox(
    height: 110.h,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: amenities.length,
      itemBuilder: (context, index) {
        final amenity = amenities[index];
        return Padding(
          padding: EdgeInsets.only(right: 15.w),
          child: Column(
            children: [
              Container(
                height: 55.h,
                width: 55.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35.r),
                  color: Colors.white,
                ),
                child: Transform.scale(
                  scale: 0.4,
                  child: Image.asset(amenity["icon"]!, fit: BoxFit.contain),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                amenity["label"]!,
                style: TextStyle(fontSize: 10.sp, color: Color(0xFF636363)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    ),
  );
}
