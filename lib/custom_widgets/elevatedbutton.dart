import 'package:boxify/custom_widgets/text.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final double? fontSize;
  final String? icon;
  final Color? borderColor;
  final FontWeight? fontWeight;
  final double? borderRadius;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.height = 50,
    this.width = 329,
    this.icon,
    this.borderColor,
    this.fontSize,
    this.fontWeight,
    this.borderRadius
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?.h,
      width: width?.w,
      child: OutlinedButton(
        style: ElevatedButton.styleFrom(
          side: borderColor != null ? BorderSide(color: borderColor!) : BorderSide(color: Colors.transparent),
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 15.r),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: Transform.scale(scale: 0.72, child: Image.asset(icon!)),
              ),
            SizedBox(width: 5.w),
            CustomText(
              data: text,
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: andersonGrotesk,
            ),
          ],
        ),
      ),
    );
  }
}
