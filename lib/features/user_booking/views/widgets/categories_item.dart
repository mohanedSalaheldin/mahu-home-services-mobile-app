import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CategoriesItem extends StatelessWidget {
  const CategoriesItem({
    super.key,
    required this.icon,
    required this.txt,
  });
  final IconData icon;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 37.w,
          backgroundColor: const Color(0xff1f8bea).withOpacity(.07),
          child: Icon(
            icon,
            size: 35,
          ),
        ),
        Gap(5.h),
        Text(
          txt,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
