import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/service_details_screen.dart';
import 'package:intl/intl.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';

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
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(12)),
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
                      _getLocalizedServiceName(context, service.name),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(4.h),
                    Text(
                      _getLocalizedDurationAndPrice(
                          context, service.duration.toDouble(), service.basePrice.toDouble()),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      _getLocalizedCategory(context, service.category),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Favorite Button (Commented out in original code)
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

  String _getLocalizedServiceName(BuildContext context, String name) {
    // Placeholder: Replace with actual localization logic based on service name
    switch (name.toLowerCase()) {
      case 'deep clean':
        return S.of(context).serviceListTileDeepCleanName;
      case 'recurring':
        return S.of(context).serviceListTileRecurringName;
      case 'one-time':
        return S.of(context).serviceListTileOneTimeName;
      default:
        return name; // Fallback to original name if not localized
    }
  }

  String _getLocalizedCategory(BuildContext context, String category) {
    // Placeholder: Replace with actual localization logic based on category
    switch (category.toLowerCase()) {
      case 'cleaning':
        return S.of(context).serviceListTileCleaningCategory;
      case 'painting':
        return S.of(context).serviceListTilePaintingCategory;
      default:
        return category.capitalize(); // Fallback to capitalized category
    }
  }

  String _getLocalizedDurationAndPrice(
      BuildContext context, double duration, double price) {
    final currencyFormat = NumberFormat.currency(
      locale: Localizations.localeOf(context).languageCode,
      symbol: S.of(context).serviceListTileCurrencySymbol,
      decimalDigits: 0,
    );
    return S.of(context)
        .serviceListTileDurationAndPrice(duration.toString(), currencyFormat.format(price));
  }
}

// Extension to capitalize strings (used for fallback)
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}