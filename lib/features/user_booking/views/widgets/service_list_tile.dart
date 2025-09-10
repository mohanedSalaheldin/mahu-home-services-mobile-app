import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
// import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:mahu_home_services_app/features/services/views/screens/service_provider_jobs.dart';
import 'package:mahu_home_services_app/features/user_booking/views/widgets/favorite_button.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/service_details_screen.dart';

class ServiceListTile extends StatelessWidget {
  final ServiceModel service;
  final bool isFavorite;
  final bool isLoading;
  final VoidCallback onFavoritePressed;

  const ServiceListTile({
    super.key,
    required this.service,
    required this.isFavorite,
    required this.isLoading,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to Service Details Screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceDetailsScreen(service: service),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            // Service Image
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
              child: Image.network(
                service.image,
                width: 80.w,
                height: 80.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80.w,
                  height: 80.w,
                  color: Colors.grey.shade200,
                  child: Icon(Icons.error, color: Colors.grey.shade400),
                ),
              ),
            ),
            Gap(12.w),
            
            // Service Info
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(4.h),
                    Text(
                      '${service.duration} hrs • \$${service.basePrice}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      service.category.capitalize(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Favorite Button
            // Padding(
            //   padding: EdgeInsets.all(8.w),
            //   child: FavoriteButton(
            //     isFavorite: isFavorite,
            //     isLoading: isLoading,
            //     onPressed: onFavoritePressed,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}