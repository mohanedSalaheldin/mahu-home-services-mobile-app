import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';

class CategoriesWidget extends StatelessWidget {
  final void Function(String label) onTap;
  final List<Map<String, dynamic>> categories;
  const CategoriesWidget({super.key, required this.onTap, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Categories',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
        Gap(12.h),
        SizedBox(
          height: 100.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => Gap(12.w),
            itemBuilder: (_, i) {
              final item = categories[i];
              return InkWell(
                onTap: () => onTap(item['label'] as String),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 80.w,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20.w,
                        backgroundColor: AppColors.primary.withOpacity(.1),
                        child: Icon(item['icon'] as IconData,
                            color: AppColors.primary),
                      ),
                      Gap(8.h),
                      Text(item['label'] as String,
                          style: TextStyle(fontSize: 12.sp)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
