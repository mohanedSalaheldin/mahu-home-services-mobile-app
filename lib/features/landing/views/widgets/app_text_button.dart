import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.txt,
    required this.onPressed,
    this.fontSize,
  });
  final String txt;
  final void Function() onPressed;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        txt,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: (fontSize ?? 15).sp,
          decoration: TextDecoration.underline,
          color: AppColors.blue,
        ),
      ),
    );
  }
}
