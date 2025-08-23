import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/models/landing_model.dart';

class LandingItem extends StatelessWidget {
  const LandingItem({
    super.key,
    required this.model,
  });
  final LandingModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
          decoration: const BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            child: Image.asset(
              height: 585.h,
              fit: BoxFit.cover,
              model.img,
              width: double.infinity,
            ),
          ),
        ),
        Gap(12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppConst.appPadding.w),
          child: Column(
            children: [
              Text(
                model.title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 21,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              Gap(8.h),
              Text(
                model.body,
                style: TextStyle(
                  color: const Color.fromARGB(153, 0, 0, 0),
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  height: 1.9,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
