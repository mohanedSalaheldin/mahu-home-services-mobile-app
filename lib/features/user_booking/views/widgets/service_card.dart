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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahu_home_services_app/features/user_booking/cubit/user_booking_cubit.dart';

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

  Future<UserBaseProfileModel?> _getProviderProfile() async {
    if (service.provider.isNotEmpty) {
      final result =
          await ProfileServices().getProviderProfile(service.provider);
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
            builder: (_) => ServiceDetailsScreen(service: service),
          ),
        );
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
              offset: const Offset(0, 5),
            ),
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
                    placeholder: (context, url) => Container(
                      color: Colors.grey.shade200,
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey.shade200,
                      child: Icon(
                        Icons.error,
                        color: Colors.grey.shade400,
                        size: 32,
                      ),
                    ),
                  ),
                  // Positioned(
                  //   top: 8.w,
                  //   right: 8.w,
                  //   child: FavoriteButton(
                  //     isFavorite: isFavorite,
                  //     isLoading: isLoading,
                  //     onPressed: onFavoritePressed,
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(4.h),
                  Text(
                    '${service.duration} hrs • \$${service.basePrice}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Gap(4.h),
                  FutureBuilder<UserBaseProfileModel?>(
                    future: _getProviderProfile(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          height: 18,
                          child: Center(
                            child: SizedBox(
                              width: 12,
                              height: 12,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        );
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
                                errorWidget: (context, url, error) => Container(
                                  height: 18,
                                  width: 18,
                                  color: Colors.grey.shade200,
                                  child: Icon(
                                    Icons.person,
                                    size: 12,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ),
                            ),
                            Gap(6.w),
                            Expanded(
                              child: Text(
                                snapshot.data!.businessName,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
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
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 12.w,
                  height: 12.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isFavorite ? Colors.red : Colors.grey.shade600,
                    ),
                  ),
                )
              : Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey.shade600,
                  size: 16,
                ),
        ),
      ),
    );
  }
}

// Usage example in a parent widget:
class ServiceGrid extends StatelessWidget {
  final List<ServiceModel> services;

  const ServiceGrid({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBookingCubit, UserBookingState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<UserBookingCubit>(context);
        final isFavoriteOperationLoading = state is FavoriteOperationLoading;

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.7,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            final isFavorite = cubit.isServiceFavorited(service.id);
            final isLoading = isFavoriteOperationLoading;

            return ServiceCard(
              service: service,
              isFavorite: isFavorite,
              isLoading: isLoading,
              onFavoritePressed: () {
                cubit.toggleFavorite(service.id);
              },
            );
          },
        );
      },
    );
  }
}

// Alternative usage with Consumer for simpler cases:
class ServiceList extends StatelessWidget {
  final List<ServiceModel> services;

  const ServiceList({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];

        return BlocBuilder<UserBookingCubit, UserBookingState>(
          builder: (context, state) {
            final cubit = BlocProvider.of<UserBookingCubit>(context);
            final isFavorite = cubit.isServiceFavorited(service.id);
            final isLoading = state is FavoriteOperationLoading;

            return ServiceCard(
              service: service,
              isFavorite: isFavorite,
              isLoading: isLoading,
              onFavoritePressed: () {
                cubit.toggleFavorite(service.id);
              },
            );
          },
        );
      },
    );
  }
}
