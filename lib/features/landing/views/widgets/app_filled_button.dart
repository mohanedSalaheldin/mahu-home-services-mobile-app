import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';

class AppFilledButton extends StatelessWidget {
  const AppFilledButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.fontSize,
  });
  final String text;
  final double? fontSize;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 15.h, horizontal: 60.w)),
          backgroundColor: const WidgetStatePropertyAll(AppColors.blue),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: fontSize?.sp ?? 25.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
