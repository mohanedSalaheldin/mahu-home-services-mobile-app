import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/models/cleaning_service.dart'
    as models;
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:mahu_home_services_app/features/user_booking/views/widgets/service_list_tile.dart';

class RecommendedServicesWidget extends StatelessWidget {
  final List<ServiceModel> services;
  final Function(models.CleaningService) onToggleFavorite;
  const RecommendedServicesWidget({
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
            Text('Recommended For You',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            TextButton(
                onPressed: () {},
                child: Text('View All',
                    style:
                        TextStyle(color: AppColors.primary, fontSize: 12.sp))),
          ],
        ),
        Gap(12.h),
        Column(
          children: services
              .map((service) => Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: ServiceListTile(
                        service: service, onFavoritePressed: () {}),
                  ))
              .toList(),
        )
      ],
    );
  }
}
