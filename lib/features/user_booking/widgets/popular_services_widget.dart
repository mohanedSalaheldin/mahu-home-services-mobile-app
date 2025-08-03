import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/models/cleaning_service.dart' as models;
import 'package:mahu_home_services_app/features/user_booking/widgets/service_card.dart';

class PopularServicesWidget extends StatelessWidget {
  final List<models.CleaningService> services;
  final Function(models.CleaningService) onToggleFavorite;
  const PopularServicesWidget({
    super.key,
    required this.services,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Popular Services',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            TextButton(
                onPressed: () {},
                child: Text('View All',
                    style:
                        TextStyle(color: AppColors.primary, fontSize: 12.sp))),
          ],
        ),
        Gap(12.h),
        SizedBox(
          height: 220.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: services.length,
            separatorBuilder: (_, __) => Gap(16.w),
            itemBuilder: (_, i) {
              final service = services[i];
              return ServiceCard(
                  service: service,
                  onFavoritePressed: () => onToggleFavorite(service));
            },
          ),
        )
      ],
    );
  }
}
