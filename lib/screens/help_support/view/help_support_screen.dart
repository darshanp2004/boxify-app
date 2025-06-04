import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/screens/help_support/cubit/help_support_cubit.dart';
import 'package:boxify/screens/help_support/cubit/help_support_state.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/image_resources.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HelpAndSupportCubit(),
      child: BlocConsumer<HelpAndSupportCubit, HelpAndSupportState>(
        listener: (BuildContext context, HelpAndSupportState state) {},
        builder: (BuildContext context, HelpAndSupportState state) {
          var helpSupportCubit = HelpAndSupportCubit.get(context);
          return Scaffold(
            backgroundColor: Color(0xFFF3F4F8),
            appBar: appBar(context),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: ListView(
                children: [
                  SizedBox(height: 40.h),
                  CustomText(
                    data: quickHelp,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 20.h),
                  ListTile(iconPath: msgIcon, title: liveChat, trailing: true),
                  SizedBox(height: 10.h),
                  ListTile(
                    iconPath: callIcon,
                    title: callSupport,
                    trailing: true,
                  ),
                  SizedBox(height: 10.h),
                  ListTile(
                    iconPath: emailIcon,
                    title: emailUs,
                    trailing: true,
                    iconHeight: 20,
                    iconWidth: 20,
                  ),
                  SizedBox(height: 40.h),
                  CustomText(
                    data: faqs,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    margin: EdgeInsets.only(bottom: 20.h),
                    padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: Color(0xFFFFFFFF),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: helpSupportCubit.faqData.length,
                      itemBuilder: (context, index) {
                        final data = helpSupportCubit.faqData[index];
                        final isExpanded = helpSupportCubit.expandedList[index];
                        return Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                            splashColor: Colors.transparent,
                          ),
                          child: Column(
                            children: [
                              ExpansionTile(
                                onExpansionChanged:
                                    (context) =>
                                        helpSupportCubit.toggleExpanded(index),
                                minTileHeight: 0,
                                title: CustomText(
                                  data: data.question,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      isExpanded
                                          ? Color(0xFF0E7AFF)
                                          : Colors.black,
                                ),
                                trailing: Icon(
                                  isExpanded
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color:
                                      isExpanded
                                          ? Color(0xFF0E7AFF)
                                          : Colors.black,
                                ),
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                    ),
                                    color: Colors.transparent,
                                    width: double.infinity,
                                    child: CustomText(
                                      data: data.answer,
                                      fontSize: 12.sp,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                ],
                              ),
                              if (index != helpSupportCubit.faqData.length - 1)
                                Divider(),
                            ],
                          ),
                        );
                      },
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

// Appbar

AppBar appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    surfaceTintColor: Color(0xFFFFFFFF),
    automaticallyImplyLeading: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ),
    leading: Padding(
      padding: EdgeInsets.only(left: 25.w),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Transform.scale(
          scale: 0.35,
          child: Image.asset(leftArrowIcon, height: 24.h, width: 24.w),
        ),
      ),
    ),
    title: Transform.translate(
      offset: Offset(0, 1),
      child: CustomText(
        data: helpAndSupport,
        fontSize: 25.sp,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

class ListTile extends StatelessWidget {
  final String iconPath;
  final Color iconColor;
  final double iconHeight;
  final double iconWidth;
  final String title;
  final bool trailing;

  const ListTile({
    super.key,
    required this.iconPath,
    this.iconColor = const Color(0xFF0E7AFF),
    this.iconHeight = 18,
    this.iconWidth = 18,
    required this.title,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
      ),
      child: Row(
        children: [
          SizedBox(width: 8.w),
          Container(
            height: 34.h,
            width: 34.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: Color(0xFFF3F4F8),
            ),
            child: Center(
              widthFactor: 15,
              heightFactor: 15,
              child: Image.asset(
                iconPath,
                color: Color(0xFF0E7AFF),
                height: iconHeight.h,
                width: iconWidth.w,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          CustomText(
            data: title,
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            color: Color(0xFF636363),
          ),
          Spacer(),
          if (trailing)
            Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: Image.asset(rightArrowIcon, height: 20.h, width: 10.w),
            ),
        ],
      ),
    );
  }
}
