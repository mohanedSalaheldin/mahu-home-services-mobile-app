import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.onTap,
  });
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: 25.w,
        backgroundColor: AppColors.blue,
        child: Image.asset('assets/icons/arrow_back.png', width: 27.w),
      ),
    );
  }
}
