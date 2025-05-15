import 'package:boxify/custom_widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {
  final String text;
  final Color? color;

  const Button({
    super.key,
    required this.text,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 110.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
      ),
      child: Center(child: CustomText(data: text,)),
    );
  }
}
