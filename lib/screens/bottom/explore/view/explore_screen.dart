import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/screens/bottom/bottom_navigation/cubit/bottom_navigation_cubit.dart';
import 'package:boxify/screens/bottom/explore/cubit/explore_screen_cubit.dart';
import 'package:boxify/screens/bottom/explore/cubit/explore_screen_state.dart';
import 'package:boxify/screens/location/view/location_screen.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../utils/image_resources.dart';


class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExploreCubit()..loadCategories(),
      child: BlocConsumer<ExploreCubit, ExploreState>(
        listener: (BuildContext context, ExploreState state) {},
        builder: (BuildContext context, ExploreState state) {
          var exploreCubit = ExploreCubit.get(context);
          var bottomNavCubit = BottomNavigationCubit.get(context);
          return Scaffold(
            backgroundColor: Color(0xFFF3F4F8),
            appBar: appBar(context, bottomNavCubit, exploreCubit),
            body: Builder(
              builder: (context) {
                if (state is CategoriesLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is CategoriesLoaded) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 45.h,
                          width: double.infinity,
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
                        SizedBox(height: 25.h),
                        Flexible(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 20.h),
                              child: Wrap(
                                spacing: 10.w,
                                runSpacing: 10.h,
                                children: List.generate(
                                  state.categories.length,
                                  (index) {
                                    final category = state.categories[index];
                                    final itemWidth =
                                        (index == 0 ||
                                                index == 3 ||
                                                index == 4 ||
                                                index == 7 ||
                                                index == 8)
                                            ? 180.w
                                            : 150.w;
                                    return Container(
                                      width: itemWidth,
                                      height: 100.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          18.r,
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned.fill(
                                              child: Image.asset(
                                                category.image,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                              left: 10,
                                              bottom: 5,
                                              child: CustomText(
                                                data: category.labelName,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
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
  ExploreCubit exploreCubit,
) {
  return AppBar(
    surfaceTintColor: Colors.transparent,
    toolbarHeight: 70.h,
    backgroundColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ),
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
          exploreCubit.checkPermission(Permission.notification, context);
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
