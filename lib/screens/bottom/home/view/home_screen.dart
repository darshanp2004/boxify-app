import 'package:boxify/custom_widgets/card.dart';
import 'package:boxify/custom_widgets/choicebutton.dart';
import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/screens/bottom/bottom_navigation/cubit/bottom_navigation_cubit.dart';
import 'package:boxify/screens/bottom/home/cubit/homescreen_cubit.dart';
import 'package:boxify/screens/bottom/home/cubit/homescreen_state.dart';
import 'package:boxify/screens/bottom/home/view/see_all_screen.dart';
import 'package:boxify/screens/location/view/location_screen.dart';
import 'package:boxify/screens/notification/view/notification_screen.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../utils/image_resources.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..loadCards(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (BuildContext context, HomeState state) {
          var bottomNavCubit = BottomNavigationCubit.get(context);
          var homeCubit = HomeCubit.get(context);
          return Scaffold(
            backgroundColor: Color(0xFFF3F4F8),
            appBar: appBar(context, bottomNavCubit, homeCubit),
            body: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 30.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 25.w, top: 15.h),
                    child: CustomText(
                      data: helloText,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF999999),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.w),
                    child: CustomText(
                      data: findArena,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: SizedBox(
                      height: 45.h,
                      width: 340.w,
                      child: SearchBar(
                        hintText: searchHint,
                        hintStyle: WidgetStatePropertyAll(
                          TextStyle(
                            color: Color(0xFF999999),
                            fontFamily: andersonGrotesk,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: [SvgPicture.asset(searchIcon)],
                        backgroundColor: WidgetStatePropertyAll(
                          Color(0xFFFFFFFF),
                        ),
                        elevation: WidgetStatePropertyAll(0),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),
                  if (state is CardsLoaded)
                    Padding(
                      padding: EdgeInsets.only(left: 25.w),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ChoiceButton(
                              imagePath: cricketBall,
                              label: cricket,
                              isSelected: state.selectedCategory == cricket,
                              onTap: () => homeCubit.selectCategory(cricket),
                            ),
                            SizedBox(width: 15.w),
                            ChoiceButton(
                              imagePath: footBall,
                              label: football,
                              isSelected: state.selectedCategory == football,
                              onTap: () => homeCubit.selectCategory(football),
                            ),
                            SizedBox(width: 15.w),
                            ChoiceButton(
                              imagePath: tennisBall,
                              label: tennis,
                              isSelected: state.selectedCategory == tennis,
                              onTap: () => homeCubit.selectCategory(tennis),
                            ),
                            SizedBox(width: 25.w,)
                          ],
                        ),
                      ),
                    ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Row(
                      children: [
                        CustomText(
                          data: venueNear,
                          fontWeight: FontWeight.w800,
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        SeeAllScreen(category: cricket),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              CustomText(
                                data: seeAll,
                                fontSize: 12.sp,
                                color: Color(0xFF0E7AFF),
                              ),
                              SizedBox(width: 5.w),
                              Transform.translate(
                                offset: Offset(0, -2),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12.sp,
                                  color: Color(0xFF0E7AFF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 200.h,
                    child:
                        state is CardsLoaded
                            ? sportCardList(state.cricketCard)
                            : SizedBox(),
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Row(
                      children: [
                        CustomText(
                          data: footballVenue,
                          fontWeight: FontWeight.w800,
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        SeeAllScreen(category: football),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              CustomText(
                                data: seeAll,
                                fontSize: 12.sp,
                                color: Color(0xFF0E7AFF),
                              ),
                              SizedBox(width: 5.w),
                              Transform.translate(
                                offset: Offset(0, -2),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12.sp,
                                  color: Color(0xFF0E7AFF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 200.h,
                    child:
                        state is CardsLoaded
                            ? sportCardList(state.footballCard)
                            : SizedBox(),
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Row(
                      children: [
                        CustomText(
                          data: tennisVenue,
                          fontWeight: FontWeight.w800,
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => SeeAllScreen(category: tennis),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              CustomText(
                                data: seeAll,
                                fontSize: 12.sp,
                                color: Color(0xFF0E7AFF),
                              ),
                              SizedBox(width: 5.w),
                              Transform.translate(
                                offset: Offset(0, -2),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12.sp,
                                  color: Color(0xFF0E7AFF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 200.h,
                    child:
                        state is CardsLoaded
                            ? sportCardList(state.tennisCard)
                            : SizedBox(),
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


// AppBar

AppBar appBar(
  BuildContext context,
  BottomNavigationCubit bottomNavCubit,
  HomeCubit homeCubit,
) {
  return AppBar(
    surfaceTintColor: Colors.transparent,
    toolbarHeight: 70.h,
    backgroundColor: Colors.white,
    leading: Padding(
      padding: EdgeInsets.only(left: 30.w),
      child: Image.asset(locationIcon, height: 24.h, width: 24.w),
    ),
    title: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LocationScreen()),
        );
      },
      child: Hero(
        tag: tag1,
        child: Material(
          type: MaterialType.transparency,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                data: location,
                color: Color(0xFF999999),
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
              Row(
                children: [
                  CustomText(
                    data: area,
                    fontWeight: FontWeight.w800,
                    fontSize: 15.sp,
                  ),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    actions: [
      GestureDetector(
        onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotificationScreen()),
          );
        },
        child: Image.asset(notificationIcon, height: 24.h, width: 24.w),
      ),
      SizedBox(width: 10.w),
      Padding(
        padding: EdgeInsets.only(right: 25.w),
        child: Container(
          height: 43.h,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFD2D4DA)),
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: GestureDetector(
            onTap: () {
              bottomNavCubit.updateIndex(3);
            },
            child: Padding(
              padding: EdgeInsets.all(2.w),
              child: Image.asset(profileImage, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    ],
  );
}

// SportCard List

Widget sportCardList(List<Map<String, String>> cards) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 4,
    itemBuilder: (context, index) {
      final card = cards[0];
      return Padding(
        padding: EdgeInsets.only(left: 25.w, right: index == 3 ? 25.w : 0),
        child: Row(
          children: [
            SportCard(
              image: card[image]!,
              title: card[title]!,
              price: card[price]!,
              place: card[place]!,
              distance: card[distance]!,
              ratings: card[ratings]!,
            ),
          ],
        ),
      );
    },
  );
}
