import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/models/cleaning_service.dart'
    as models;
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/service_details_screen.dart';
import 'package:mahu_home_services_app/features/services/services/profile_services.dart';
import 'package:mahu_home_services_app/features/services/models/user_base_profile_model.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback onFavoritePressed;
  const ServiceCard(
      {super.key, required this.service, required this.onFavoritePressed});

  Future<UserBaseProfileModel?> _getProviderProfile() async {
    if (service.provider.isNotEmpty) {
      final result = await ProfileServices().getProviderProfile(service.provider);
      return result.fold((failure) => null, (profile) => profile);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ServiceDetailsScreen(service: service)));
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 160.w,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    height: 120.h,
                    width: double.infinity,
                    imageUrl: service.image,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 8.w,
                    right: 8.w,
                    child: FavoriteButton(
                        isFavorite: false, onPressed: onFavoritePressed),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service.name,
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold),
                      maxLines: 1),
                  Gap(4.h),
                  Text('${service.duration} hrs • \$${service.basePrice}',
                      style: TextStyle(
                          fontSize: 12.sp, color: Colors.grey.shade600)),
                  Gap(4.h),
                  FutureBuilder<UserBaseProfileModel?>(
                    future: _getProviderProfile(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(height: 18, child: LinearProgressIndicator());
                      }
                      if (snapshot.hasData && snapshot.data != null) {
                        return Row(
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data!.avatar,
                                height: 18,
                                width: 18,
                                fit: BoxFit.cover,
                                placeholder: (_, __) => Container(
                                  height: 18,
                                  width: 18,
                                  color: Colors.grey.shade200,
                                ),
                              ),
                            ),
                            Gap(6.w),
                            Expanded(
                              child: Text(
                                snapshot.data!.businessName,
                                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
