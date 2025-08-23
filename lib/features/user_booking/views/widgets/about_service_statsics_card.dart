import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';

class AboutServiceStatsicsCard extends StatelessWidget {
  const AboutServiceStatsicsCard({
    super.key,
    required this.statistic,
    required this.label,
  });
  final String statistic;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.w,
      height: 55.h,
      decoration: const BoxDecoration(
        color: AppColors.greyBack,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 13.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            statistic,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}
