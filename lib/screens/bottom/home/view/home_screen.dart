import 'package:boxify/custom_widgets/card.dart';
import 'package:boxify/custom_widgets/choicebutton.dart';
import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/screens/bottom/bottom_navigation/cubit/bottom_navigation_cubit.dart';
import 'package:boxify/screens/bottom/home/cubit/homescreen_cubit.dart';
import 'package:boxify/screens/bottom/home/cubit/homescreen_state.dart';
import 'package:boxify/screens/bottom/home/view/seeall_screen.dart';
import 'package:boxify/screens/location/view/location_screen.dart';
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
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).loadCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F4F8),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 70.h,
        backgroundColor: Color(0xFFFFFFFF),
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
                        data: place,
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
              BlocProvider.of<HomeCubit>(context).checkPermission(Permission.notification, context);
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
                  context.read<BottomNavigationCubit>().updateIndex(2);
                },
                child: Padding(
                  padding: EdgeInsets.all(2.w),
                  child: Image.asset(profileImage,fit: BoxFit.cover,),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                padding: EdgeInsets.only(left: 25.w),
                child: SizedBox(
                  height: 45.h,
                  width: 340.w,
                  child: SearchBar(
                    hintText: searchHint,
                    hintStyle: WidgetStatePropertyAll(
                      TextStyle(
                        color: Color(0xFF999999),
                        fontFamily: "FontMain",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: [SvgPicture.asset(searchIcon)],
                    backgroundColor: WidgetStatePropertyAll(Color(0xFFFFFFFF)),
                    elevation: WidgetStatePropertyAll(0),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is CardsLoaded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 25.w),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ChoiceButton(
                              imagePath: cricketBall,
                              label: "Cricket",
                              isSelected: state.selectedCategory == "Cricket",
                              onTap:
                                  () => context
                                      .read<HomeCubit>()
                                      .selectCategory("Cricket"),
                            ),
                            SizedBox(width: 15.w),
                            ChoiceButton(
                              imagePath: footBall,
                              label: "Football",
                              isSelected: state.selectedCategory == "Football",
                              onTap:
                                  () => context
                                      .read<HomeCubit>()
                                      .selectCategory("Football"),
                            ),
                            SizedBox(width: 15.w),
                            ChoiceButton(
                              imagePath: tennisBall,
                              label: "Tennis",
                              isSelected: state.selectedCategory == "Tennis",
                              onTap:
                                  () => context
                                      .read<HomeCubit>()
                                      .selectCategory("Tennis"),
                            ),
                            SizedBox(width: 15.w),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Row(
                  children: [
                    CustomText(data: venueNear, fontWeight: FontWeight.w800),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => SeeAllScreen(category: "Cricket"),
                          ),
                        );
                      },
                      child: CustomText(data: seeAll, color: Color(0xFF0E7AFF)),
                    ),
                    Icon(Icons.chevron_right, color: Colors.blue),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is CardInitial) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is CardsLoaded) {
                    return SizedBox(
                      height: 200.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          final card = state.cricketCard[0];
                          return Padding(
                            padding: EdgeInsets.only(left: 25.w),
                            child: SportCard(
                              image: card["image"]!,
                              title: card["title"]!,
                              price: card["price"]!,
                              place: card["place"]!,
                              distance: card["distance"]!,
                              ratings: card["ratings"]!,
                            ),
                          );
                        },
                      ),
                    );
                  }
                  if (state is CardError) {
                    return Center(child: CustomText(data: state.message));
                  }
                  return SizedBox();
                },
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
                                (context) => SeeAllScreen(category: "Football"),
                          ),
                        );
                      },
                      child: CustomText(data: seeAll, color: Color(0xFF0E7AFF)),
                    ),
                    Icon(Icons.chevron_right, color: Colors.blue),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is CardsLoaded) {
                    return SizedBox(
                      height: 200.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          final card = state.footballCard[0];
                          return Padding(
                            padding: EdgeInsets.only(left: 25.w),
                            child: SportCard(
                              image: card["image"]!,
                              title: card["title"]!,
                              price: card["price"]!,
                              place: card["place"]!,
                              distance: card["distance"]!,
                              ratings: card["ratings"]!,
                            ),
                          );
                        },
                      ),
                    );
                  }
                  if (state is CardError) {
                    return Center(child: CustomText(data: state.message));
                  }
                  return SizedBox();
                },
              ),
              SizedBox(height: 15.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Row(
                  children: [
                    CustomText(data: tennisVenue, fontWeight: FontWeight.w800),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => SeeAllScreen(category: "Tennis"),
                          ),
                        );
                      },
                      child: CustomText(data: seeAll, color: Color(0xFF0E7AFF)),
                    ),
                    Icon(Icons.chevron_right, color: Colors.blue),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is CardsLoaded) {
                    return SizedBox(
                      height: 200.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          final card = state.tennisCard[0];
                          return Padding(
                            padding: EdgeInsets.only(left: 25.w),
                            child: SportCard(
                              image: card["image"]!,
                              title: card["title"]!,
                              price: card["price"]!,
                              place: card["place"]!,
                              distance: card["distance"]!,
                              ratings: card["ratings"]!,
                            ),
                          );
                        },
                      ),
                    );
                  }
                  if (state is CardError) {
                    return Center(child: CustomText(data: state.message));
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
