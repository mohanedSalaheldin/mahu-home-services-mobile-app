import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';

class HomeAppbarLeadingWidget extends StatelessWidget {
  const HomeAppbarLeadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Gap(AppConst.appPadding.w),
        const CircleAvatar(
          backgroundColor: Colors.black,
          radius: 23,
        ),
        Gap(8.w),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, Mark',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: Colors.black.withOpacity(.5),
              ),
            ),
            Text(
              'UAE, Dubai',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
