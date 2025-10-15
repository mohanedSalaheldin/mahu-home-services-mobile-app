import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/service_details_screen.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  final bool isFavorite;
  final bool isLoading;
  final VoidCallback onFavoritePressed;

  const ServiceCard({
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ServiceDetailsScreen(service: service),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 160.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image + Favorite Button
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: CachedNetworkImage(
                    height: 120.h,
                    width: double.infinity,
                    imageUrl: service.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey.shade100,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(
                              Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey.shade100,
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey.shade400,
                        size: 32,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8.w,
                  right: 8.w,
                  child: FavoriteButton(
                    isFavorite: isFavorite,
                    isLoading: isLoading,
                    onPressed: onFavoritePressed,
                  ),
                ),
              ],
            ),

            // Service Info
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + Price
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _getLocalizedServiceName(context, service.name),
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        _getLocalizedPrice(context, service.basePrice),
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 6.h),

                  // Duration
                  Row(
                    children: [
                      Icon(Icons.access_time,
                          size: 14, color: Colors.grey.shade600),
                      SizedBox(width: 4.w),
                      Text(
                        S.of(context).serviceCardMinDurationLabel,
                        style: TextStyle(
                          fontSize: 7.sp,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          S.of(context)
                              .serviceCardDuration(service.duration.toString()),
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.grey.shade600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getLocalizedServiceName(BuildContext context, String name) {
    // Placeholder: Replace with actual localization logic based on service name
    switch (name.toLowerCase()) {
      case 'deep clean':
        return S.of(context).serviceCardDeepCleanName;
      case 'recurring':
        return S.of(context).serviceCardRecurringName;
      case 'one-time':
        return S.of(context).serviceCardOneTimeName;
      default:
        return name; // Fallback to original name if not localized
    }
  }

  String _getLocalizedPrice(BuildContext context, double price) {
    // Use the service's currency if provided, otherwise default to AED
    final code = (service.currency.isNotEmpty) ? service.currency : 'AED';
    // Simple formatting: show currency code then amount without decimals
    return '$code ${price.toStringAsFixed(0)}';
  }
}

class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final bool isLoading;
  final VoidCallback onPressed;

  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: 28.w,
        height: 28.w,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isLoading
                ? SizedBox(
                    width: 14.w,
                    height: 14.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isFavorite ? Colors.red : Colors.grey.shade600,
                      ),
                    ),
                  )
                : Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite
                        ? Colors.red
                        : Colors.grey.shade600.withOpacity(0.8),
                    size: 16,
                  ),
          ),
        ),
      ),
    );
  }
}