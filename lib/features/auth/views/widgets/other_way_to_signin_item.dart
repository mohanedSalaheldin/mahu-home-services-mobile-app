import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';

class OtherWayToSigninItem extends StatelessWidget {
  const OtherWayToSigninItem({
    super.key,
    required this.img,
  });
  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68.h,
      width: 68.h,
      decoration: const BoxDecoration(
        color: AppColors.greyBack,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Center(
        child: SizedBox(
          height: 37.h,
          width: 37.h,
          child: Image.asset(
            img,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
