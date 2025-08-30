import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/errors/failures.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:mahu_home_services_app/features/user_booking/cubit/user_booking_cubit.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/service_details_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/views/widgets/service_list_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize favorites when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = BlocProvider.of<UserBookingCubit>(context);
      cubit.initializeFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Favorites',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        
      ),
      body: BlocConsumer<UserBookingCubit, UserBookingState>(
        listener: (context, state) {
          if (state is FavoriteOperationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.failure.message}'),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is FavoriteRemovedSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Removed from favorites'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<UserBookingCubit>(context);
          final favoriteServices = cubit.favoriteServices.where((service) => service.active == true).toList();

          if (state is FavoritesLoading) {
            return _buildLoadingState();
          } else if (state is FavoritesError) {
            return _buildErrorState(state.failure, cubit);
          } else if (state is FavoritesLoaded && favoriteServices.isEmpty) {
            return _buildEmptyState();
          } else {
            return _buildFavoritesList(favoriteServices, cubit);
          }
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 60.w,
            height: 60.w,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: AppColors.primary,
            ),
          ),
          Gap(24.h),
          Text(
            'Loading your favorites...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(Failure failure, UserBookingCubit cubit) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 80.w,
              color: Colors.red.shade300,
            ),
            Gap(24.h),
            Text(
              'Oops! Something went wrong',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(12.h),
            Text(
              failure.message,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(32.h),
            ElevatedButton(
              onPressed: () => cubit.initializeFavorites(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Try Again',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border_rounded,
              size: 100.w,
              color: Colors.grey.shade300,
            ),
            Gap(32.h),
            Text(
              'No favorites yet',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            Gap(16.h),
            Text(
              'Start saving your favorite services\nby tapping the heart icon',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(32.h),
            Text(
              '💡 Tip: You can favorite services from\nthe home screen or service details',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesList(List<ServiceModel> favorites, UserBookingCubit cubit) {
    return Column(
      children: [
        // Header with count
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.05),
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade200),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${favorites.length} ${favorites.length == 1 ? 'Favorite' : 'Favorites'}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        
        // Favorites list
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await cubit.refreshFavorites();
            },
            color: AppColors.primary,
            child: ListView.separated(
              padding: EdgeInsets.all(16.w),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: favorites.length,
              separatorBuilder: (context, index) => Gap(16.h),
              itemBuilder: (context, index) {
                final service = favorites[index];
                final isFavorite = cubit.isServiceFavorited(service.id);
                final isLoading = cubit.isServiceLoading(service.id);

                return ServiceListTile(
                  service: service,
                  isFavorite: isFavorite,
                  isLoading: isLoading,
                  onFavoritePressed: () => cubit.toggleFavorite(service.id),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

}

// Enhanced ServiceListTile for favorites screen
class FavoriteServiceTile extends StatelessWidget {
  final ServiceModel service;
  final bool isFavorite;
  final bool isLoading;
  final VoidCallback onFavoritePressed;

  const FavoriteServiceTile({
    super.key,
    required this.service,
    required this.isFavorite,
    required this.isLoading,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ServiceDetailsScreen(service: service),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Service Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: service.image,
                    width: 80.w,
                    height: 80.w,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey.shade200,
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey.shade200,
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.grey.shade400,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                Gap(16.w),
                
                // Service Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gap(8.h),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.grey.shade500,
                          ),
                          Gap(4.w),
                          Text(
                            '${service.duration} hrs',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Gap(12.w),
                          Icon(
                            Icons.attach_money,
                            size: 14,
                            color: Colors.grey.shade500,
                          ),
                          Gap(4.w),
                          Text(
                            '\$${service.basePrice}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      Gap(8.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(service.category),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          service.category.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Favorite Button
                Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: FavoriteButton(
                    isFavorite: isFavorite,
                    isLoading: isLoading,
                    onPressed: onFavoritePressed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'cleaning':
        return Colors.blue.shade600;
      case 'repair':
        return Colors.orange.shade600;
      case 'painting':
        return Colors.purple.shade600;
      case 'electrical':
        return Colors.red.shade600;
      default:
        return AppColors.primary;
    }
  }
}