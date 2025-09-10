import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:mahu_home_services_app/features/user_booking/models/review.dart';
import 'package:mahu_home_services_app/features/user_booking/services/review_services.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/booking_form_screen.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mahu_home_services_app/features/user_booking/cubit/user_booking_cubit.dart';
import 'package:intl/intl.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final ServiceModel service;

  const ServiceDetailsScreen({super.key, required this.service});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  final PageController _imageController = PageController();
  final ReviewServices _reviewServices = ReviewServices();
  List<Review> _reviews = [];
  double _averageRating = 0.0;
  int _totalReviews = 0;
  bool _isLoadingReviews = false;

  @override
  void initState() {
    super.initState();
    _loadReviews();
    // Check favorite status when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = BlocProvider.of<UserBookingCubit>(context);
      cubit.checkFavoriteStatus(widget.service.id);
    });
  }

  Future<void> _loadReviews() async {
    setState(() {
      _isLoadingReviews = true;
    });

    final result = await _reviewServices.getServiceReviews(widget.service.id);

    result.fold(
      (failure) {
        setState(() {
          _isLoadingReviews = false;
        });
        print('Error loading reviews: ${failure.message}');
      },
      (reviewsData) {
        print('Reviews data received: $reviewsData'); // Debug print

        setState(() {
          _isLoadingReviews = false;
          // Extract reviews from the correct path
          _reviews = (reviewsData['reviews'] as List<dynamic>?)
                  ?.map((review) => Review.fromJson(review))
                  .toList() ??
              [];
          _averageRating = (reviewsData['averageRating'] ?? 0.0).toDouble();
          _totalReviews = (reviewsData['totalReviews'] ?? 0).toInt();
        });

        print('Parsed reviews: $_reviews'); // Debug print
        print('Average rating: $_averageRating'); // Debug print
        print('Total reviews: $_totalReviews'); // Debug print
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBookingCubit, UserBookingState>(
      listener: (context, state) {
        // Handle favorite operation states
        if (state is FavoriteOperationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.failure.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = BlocProvider.of<UserBookingCubit>(context);
        final isFavorite = cubit.isServiceFavorited(widget.service.id);
        final isFavoriteLoading = state is FavoriteOperationLoading;

        return Scaffold(
          body: Stack(
            children: [
              // Service Images Gallery
              SizedBox(
                height: 300.h,
                width: double.infinity,
                child: PageView(
                  controller: _imageController,
                  children: [
                    _buildServiceImage(widget.service.image),
                  ],
                ),
              ),

              // Back Button
              Positioned(
                top: 50.h,
                left: 16.w,
                child: CircleAvatar(
                  radius: 20.w,
                  backgroundColor: Colors.white.withOpacity(0.8),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),

              // Favorite Button
              Positioned(
                top: 50.h,
                right: 16.w,
                child: FavoriteButton(
                  isFavorite: isFavorite,
                  isLoading: isFavoriteLoading,
                  onPressed: () {
                    cubit.toggleFavorite(widget.service.id);
                  },
                ),
              ),

              // Image Indicator
              Positioned(
                bottom: 280.h,
                left: 0,
                right: 0,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: _imageController,
                    count: 3,
                    effect: WormEffect(
                      activeDotColor: AppColors.primary,
                      dotColor: Colors.white.withOpacity(0.6),
                      dotWidth: 10.w,
                      dotHeight: 10.w,
                      spacing: 6.w,
                    ),
                  ),
                ),
              ),

              // Content
              DraggableScrollableSheet(
                initialChildSize: 0.65,
                minChildSize: 0.65,
                maxChildSize: 0.9,
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(24)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.all(20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                width: 50.w,
                                height: 4.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                            Gap(16.h),

                            // Provider Card
                            if (widget.service.businessName != null ||
                                widget.service.firstName != null)
                              ServiceProviderCard(
                                providerName: _getProviderName(),
                                providerType: _getProviderType(),
                                logoUrl: widget.service.avatar,
                              ),
                            if (widget.service.businessName != null ||
                                widget.service.firstName != null)
                              Gap(16.h),

                            // Service Title and Basic Info
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.service.name,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 6.h),
                                  decoration: BoxDecoration(
                                    color: widget.service.serviceType
                                                .toLowerCase() ==
                                            'recurring'
                                        ? Colors.blue.withOpacity(0.1)
                                        : Colors.orange.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    widget.service.serviceType,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: widget.service.serviceType
                                                  .toLowerCase() ==
                                              'recurring'
                                          ? Colors.blue
                                          : Colors.orange,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Gap(8.h),

                            // Rating and Duration
                            Row(
                              children: [
                                Icon(Icons.star,
                                    color: Colors.amber, size: 16.sp),
                                Gap(4.w),
                                Text(
                                  '${_averageRating.toStringAsFixed(1)} ($_totalReviews reviews)',
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                                Gap(16.w),
                                Icon(Icons.access_time,
                                    size: 16, color: Colors.grey),
                                Gap(4.w),
                                Text(
                                  '${widget.service.duration} hours',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                            Gap(24.h),

                            // Available Time Section
                            _buildAvailableTimeSection(),
                            Gap(16.h),

                            // Price Section
                            _buildPriceSection(),
                            Gap(24.h),

                            // About Service
                            _buildAboutSection(),
                            Gap(24.h),

                            // Reviews Section
                            _buildReviewsSection(),
                            Gap(24.h),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAvailableTimeSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_today, size: 20, color: AppColors.primary),
              Gap(8.w),
              Text(
                'Available Time',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Gap(12.h),
          Text(
            'Available Days:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Gap(8.h),
          Wrap(
            spacing: 8.w,
            children: widget.service.availableDays
                .map((day) => Chip(
                      label: Text(day),
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      labelStyle: TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                      ),
                    ))
                .toList(),
          ),
          Gap(12.h),
          Text(
            'Time Slots:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Gap(8.h),
          Column(
            children: widget.service.availableSlots
                .map((time) => Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Row(
                        children: [
                          Icon(Icons.access_time, size: 16, color: Colors.grey),
                          Gap(8.w),
                          Text(
                            '${time.startTime} - ${time.endTime}',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Starting from',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                '\$${widget.service.basePrice}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: 150.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                navigateTo(
                  context,
                  BookingFormScreen(
                    serviceID: widget.service.id,
                    service: widget.service,
                  ),
                );
              },
              child: const Text(
                'Book Now',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About This Service',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(12.h),
        ReadMoreText(
          widget.service.description,
          trimLines: 3,
          trimMode: TrimMode.Line,
          trimCollapsedText: ' Read more',
          trimExpandedText: ' Show less',
          moreStyle: TextStyle(
            fontSize: 14,
            color: AppColors.primary,
          ),
          lessStyle: TextStyle(
            fontSize: 14,
            color: AppColors.primary,
          ),
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Customer Reviews',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (_totalReviews > 0)
              Text(
                '$_totalReviews reviews',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
          ],
        ),
        Gap(12.h),

        // Average Rating Summary
        if (_totalReviews > 0) _buildRatingSummary(),
        Gap(16.h),

        // Reviews List
        if (_isLoadingReviews)
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32.h),
              child: CircularProgressIndicator(),
            ),
          )
        else if (_reviews.isEmpty)
          // make this container to be in center

          Container(
            padding: EdgeInsets.symmetric(vertical: 32.h),
            alignment: Alignment.center, // center content horizontally
            child: Column(
              mainAxisSize: MainAxisSize.min, // wrap content vertically
              mainAxisAlignment: MainAxisAlignment.center, // center vertically
              crossAxisAlignment:
                  CrossAxisAlignment.center, // center horizontally
              children: [
                Icon(
                  Icons.reviews_outlined,
                  size: 48.w,
                  color: Colors.grey.shade300,
                ),
                Gap(16.h),
                Text(
                  'No reviews yet',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade500,
                  ),
                ),
                Text(
                  'Be the first to review this service!',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          )
        else
          Column(
            children: [
              ..._reviews.take(3).map((review) => _buildReviewCard(review)),
              if (_reviews.length > 3)
                TextButton(
                  onPressed: _showAllReviews,
                  child: Text(
                    'View all $_totalReviews reviews',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildRatingSummary() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Average Rating
          Column(
            children: [
              Text(
                _averageRating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Gap(4.h),
              _buildStarRating(_averageRating, size: 16),
            ],
          ),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rating distribution could be added here if available
                Text(
                  'Based on $_totalReviews reviews',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                Gap(8.h),
                LinearProgressIndicator(
                  value: _averageRating / 5,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Review review) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with user and rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review.userName,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              _buildStarRating(review.rating.toDouble(), size: 16),
            ],
          ),
          Gap(8.h),

          // Feedback
          if (review.feedback.isNotEmpty)
            Text(
              review.feedback,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          Gap(8.h),

          // Date
          Text(
            DateFormat('MMM dd, yyyy').format(review.createdAt),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStarRating(double rating, {double size = 16}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.round() ? Icons.star : Icons.star_border,
          size: size.w,
          color: Colors.amber,
        );
      }),
    );
  }

  void _showAllReviews() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All Reviews ($_totalReviews)',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Gap(16.h),
            Expanded(
              child: ListView.builder(
                itemCount: _reviews.length,
                itemBuilder: (context, index) =>
                    _buildReviewCard(_reviews[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getProviderName() {
    if (widget.service.firstName != null && widget.service.lastName != null) {
      return "${widget.service.firstName} ${widget.service.lastName}";
    } else if (widget.service.firstName != null) {
      return widget.service.firstName!;
    } else if (widget.service.businessName != null) {
      return widget.service.businessName!;
    } else {
      return "Service Provider";
    }
  }

  String _getProviderType() {
    if (widget.service.businessName != null) {
      return widget.service.businessName!;
    } else if (widget.service.firstName != null ||
        widget.service.lastName != null) {
      return "Independent Provider";
    } else {
      return "Service Provider";
    }
  }

  Widget _buildServiceImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(color: Colors.grey.shade200),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey.shade200,
        child: Icon(Icons.error, color: Colors.grey.shade400),
      ),
    );
  }

  @override
  void dispose() {
    _imageController.dispose();
    super.dispose();
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
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: isLoading
            ? Center(
                child: SizedBox(
                  width: 16.w,
                  height: 16.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isFavorite ? Colors.red : Colors.grey.shade600,
                    ),
                  ),
                ),
              )
            : Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey.shade600,
                size: 20,
              ),
      ),
    );
  }
}

class ServiceProviderCard extends StatelessWidget {
  final String providerName;
  final String providerType;
  final String? logoUrl;

  const ServiceProviderCard({
    super.key,
    required this.providerName,
    required this.providerType,
    this.logoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Provider Logo
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: logoUrl != null && logoUrl!.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: logoUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey.shade200,
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.business,
                      color: AppColors.primary,
                      size: 20.w,
                    ),
                  ),
                )
              : Icon(
                  Icons.business,
                  color: AppColors.primary,
                  size: 20.w,
                ),
        ),
        Gap(12.w),

        // Provider Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                providerType,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                providerName,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
