import 'package:boxify/custom_widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChoiceButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final double height;
  final double iconWidth;
  final double labelWidth;
  final bool isSelected;
  final VoidCallback onTap;

  const ChoiceButton({
    super.key,
    required this.imagePath,
    required this.label,
    this.height = 50,
    this.iconWidth = 50,
    this.labelWidth = 90,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color selectedColor = isSelected ? Color(0XFF0E7AFF) : Color(0XFFBFC2C8);
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: selectedColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.r),
                  bottomLeft: Radius.circular(15.r),
                ),
              ),
              height: height.h,
              width: iconWidth.w,
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: ClipRRect(child: Image.asset(imagePath)),
              ),
            ),
            Container(
              height: height.h,
              width: labelWidth.w,
              decoration: BoxDecoration(
                border: Border.all(color: selectedColor),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.r),
                  bottomRight: Radius.circular(15.r),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: CustomText(data: label,
                  fontWeight: FontWeight.w700 ,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
