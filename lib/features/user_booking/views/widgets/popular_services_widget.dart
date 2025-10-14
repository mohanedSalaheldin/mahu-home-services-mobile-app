import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/models/cleaning_service.dart' as models;
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:mahu_home_services_app/features/user_booking/views/widgets/service_card.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/all_services_screen.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';

class PopularServicesWidget extends StatelessWidget {
  final List<ServiceModel> services;
  final void Function(String serviceId) onToggleFavorite;
  final bool Function(String serviceId) isFavorite;
  final bool Function(String serviceId) isFavoriteLoading;

  const PopularServicesWidget({
    super.key,
    required this.services,
    required this.onToggleFavorite,
    required this.isFavorite,
    required this.isFavoriteLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).popularServicesWidgetTitle,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AllServicesScreen(services: services),
                  ),
                );
              },
              child: Text(
                S.of(context).popularServicesWidgetViewAll,
                style: TextStyle(color: AppColors.primary, fontSize: 12.sp),
              ),
            ),
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
                isFavorite: isFavorite(service.id),
                isLoading: isFavoriteLoading(service.id),
                onFavoritePressed: () => onToggleFavorite(service.id),
              );
            },
          ),
        ),
      ],
    );
  }
}