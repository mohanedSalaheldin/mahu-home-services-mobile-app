import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';

class PopularServiceCard extends StatelessWidget {
  const PopularServiceCard({
    super.key,
    required this.imgPath,
    required this.txt,
    required this.onTap,
  });
  final String imgPath;
  final void Function() onTap;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 165.h,
        width: 190.w,
        padding: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 0.w),
        decoration: const BoxDecoration(
          color: AppColors.greyBack,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                height: 105.h,
                width: 167.w,
                fit: BoxFit.cover,
                imgPath,
              ),
            ),
            Gap(8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  txt,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Removed FavoriteButton as it's not needed for category cards
                const SizedBox(width: 24), // Placeholder for alignment
              ],
            ),
          ],
        ),
      ),
    );
  }
}