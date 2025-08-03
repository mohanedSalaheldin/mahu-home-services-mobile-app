import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/models/cleaning_service.dart' as models;
import 'package:mahu_home_services_app/features/user_booking/screens/customer_home_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/screens/service_details_screen.dart';

class ServiceListTile extends StatelessWidget {
  final models.CleaningService service;
  final VoidCallback onFavoritePressed;
  const ServiceListTile(
      {super.key, required this.service, required this.onFavoritePressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ServiceDetailsScreen(service: service)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 10,
                offset: const Offset(0, 5)),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(12)),
              child: CachedNetworkImage(
                width: 100.w,
                height: 100.h,
                imageUrl: service.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(service.name,
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis),
                        ),
                        FavoriteButton(
                            isFavorite: service.isFavorite,
                            onPressed: onFavoritePressed),
                      ],
                    ),
                    Gap(4.h),
                    Text(service.description,
                        style: TextStyle(
                            fontSize: 12.sp, color: Colors.grey.shade600),
                        maxLines: 2),
                    Gap(8.h),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 14.sp),
                        Gap(4.w),
                        Text('${service.rating} (${service.reviews})',
                            style: TextStyle(fontSize: 12.sp)),
                        const Spacer(),
                        Text('\$${service.price}',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary)),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
