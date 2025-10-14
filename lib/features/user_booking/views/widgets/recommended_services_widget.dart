import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/models/cleaning_service.dart' as models;
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:mahu_home_services_app/features/user_booking/views/widgets/service_list_tile.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';

class RecommendedServicesWidget extends StatelessWidget {
  final List<ServiceModel> services;
  final void Function(String serviceId) onToggleFavorite;
  final bool Function(String serviceId) isFavorite;
  final bool Function(String serviceId) isFavoriteLoading;

  const RecommendedServicesWidget({
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
        Text(
          S.of(context).recommendedServicesWidgetTitle,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Gap(12.h),
        Column(
          children: services
              .map((service) => Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: ServiceListTile(
                      service: service,
                      isFavorite: isFavorite(service.id),
                      isLoading: isFavoriteLoading(service.id),
                      onFavoritePressed: () => onToggleFavorite(service.id),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}