import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String icon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final double? fontSize;
  final Color? fillColor;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.validator,
    this.fontSize,
    this.fillColor,
    this.onChanged,
    this.keyboardType,
    this.readOnly=false
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 329.w,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        onChanged: onChanged,
        readOnly: readOnly,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor ?? Colors.transparent,
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: andersonGrotesk,
            fontSize: fontSize ?? 12.sp,
            color: Color(0xFF1E1E1E),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: Color(0XFFD2D4DA)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: Color(0XFF0E7AFF)),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.all(12),
            child: Image.asset(icon, width: 24.w, height: 24.h),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r)),
        ),
      ),
    );
  }
}
