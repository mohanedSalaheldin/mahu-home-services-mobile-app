import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';

class UserRuleItem extends StatelessWidget {
  const UserRuleItem({
    super.key,
    required this.icon,
    required this.txt,
    required this.hasBorder,
    required this.onTap,
  });
  final String icon;
  final String txt;
  final bool hasBorder;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.blue.withOpacity(0.1),
      highlightColor: Colors.blueAccent.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          Container(
            height: 125.h,
            width: 210.w,
            decoration: BoxDecoration(
              border: hasBorder
                  ? Border.all(
                      width: 3,
                      color: AppColors.blue,
                    )
                  : null,
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xffEFF7FE),
            ),
            child: Image.asset(
              icon,
              width: 100.w,
            ),
          ),
          Gap(5.h),
          Text(
            txt,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
