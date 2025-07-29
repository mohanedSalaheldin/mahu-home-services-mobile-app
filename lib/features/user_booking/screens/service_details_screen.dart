import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mahu_home_services_app/core/utils/helpers/helping_functions.dart';
import 'package:mahu_home_services_app/features/user_booking/screens/booking_form_screen.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:mahu_home_services_app/core/models/cleaning_service.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final CleaningService service;

  const ServiceDetailsScreen({super.key, required this.service});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  bool _isFavorite = false;
  final PageController _imageController = PageController();
  final List<String> _availableDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  final List<String> _availableTimes = [
    '9:00 AM - 12:00 PM',
    '2:00 PM - 6:00 PM'
  ];

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.service.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
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
                _buildServiceImage(widget.service.imageUrl),
                _buildServiceImage(
                    'https://images.unsplash.com/photo-1600585152220-90363fe7e115'),
                _buildServiceImage(
                    'https://images.unsplash.com/photo-1584622650111-993a426fbf0a'),
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
              isFavorite: _isFavorite,
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
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

                        // Service Provider Company
                        Row(
                          children: [
                            Container(
                              width: 40.w,
                              height: 40.w,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.business,
                                color: AppColors.primary,
                                size: 20.w,
                              ),
                            ),
                            Gap(12.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Service Provider',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Text(
                                  'MAHU Professional Cleaning Co.',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Gap(16.h),

                        // Service Title and Basic Info
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.service.name,
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: widget.service.serviceType == 'Recurring'
                                    ? Colors.blue.withOpacity(0.1)
                                    : Colors.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                widget.service.serviceType,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color:
                                      widget.service.serviceType == 'Recurring'
                                          ? Colors.blue
                                          : Colors.orange,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(8.h),

                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16.sp),
                            Gap(4.w),
                            Text(
                              '${widget.service.rating} (${widget.service.reviews} reviews)',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            Gap(16.w),
                            Icon(Icons.access_time,
                                size: 16.sp, color: Colors.grey),
                            Gap(4.w),
                            Text(
                              '${widget.service.duration} hours',
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.grey),
                            ),
                          ],
                        ),
                        Gap(24.h),

                        // Available Time Section
                        Container(
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
                                  Icon(Icons.calendar_today,
                                      size: 20.sp, color: AppColors.primary),
                                  Gap(8.w),
                                  Text(
                                    'Available Time',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Gap(12.h),
                              // Available Days
                              Text(
                                'Available Days:',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Gap(8.h),
                              Wrap(
                                spacing: 8.w,
                                children: _availableDays
                                    .map((day) => Chip(
                                          label: Text(day),
                                          backgroundColor: AppColors.primary
                                              .withOpacity(0.1),
                                          labelStyle: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: 12.sp,
                                          ),
                                        ))
                                    .toList(),
                              ),
                              Gap(12.h),
                              // Available Time Slots
                              Text(
                                'Time Slots:',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Gap(8.h),
                              Column(
                                children: _availableTimes
                                    .map((time) => Padding(
                                          padding: EdgeInsets.only(bottom: 8.h),
                                          child: Row(
                                            children: [
                                              Icon(Icons.access_time,
                                                  size: 16.sp,
                                                  color: Colors.grey),
                                              Gap(8.w),
                                              Text(
                                                time,
                                                style:
                                                    TextStyle(fontSize: 14.sp),
                                              ),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                        Gap(16.h),

                        // Price Section
                        Container(
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
                                      fontSize: 12.sp,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  Text(
                                    '\$${widget.service.price}',
                                    style: TextStyle(
                                      fontSize: 28.sp,
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
                                    padding:
                                        EdgeInsets.symmetric(vertical: 14.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    // Navigate to booking
                                    navigateTo(
                                        context, const BookingFormScreen());
                                  },
                                  child: Text(
                                    'Book Now',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(24.h),

                        // About Service
                        Text(
                          'About This Service',
                          style: TextStyle(
                            fontSize: 18.sp,
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
                            fontSize: 14.sp,
                            color: AppColors.primary,
                          ),
                          lessStyle: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.primary,
                          ),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade700,
                            height: 1.5,
                          ),
                        ),
                        Gap(24.h),

                        // Included Services
                        Text(
                          'What\'s Included',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(12.h),
                        Column(
                          children: widget.service.subServices
                              .map(
                                (service) => Padding(
                                  padding: EdgeInsets.only(bottom: 8.h),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: AppColors.primary,
                                        size: 18.sp,
                                      ),
                                      Gap(8.w),
                                      Text(
                                        service,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        Gap(24.h),

                        // Reviews Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Customer Reviews',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'See All',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(12.h),
                        _buildReviewCard(
                          name: 'Sarah Johnson',
                          date: '2 days ago',
                          rating: 4.5,
                          comment:
                              'The cleaning team was extremely professional and thorough. My apartment has never looked better!',
                          imageUrl:
                              'https://randomuser.me/api/portraits/women/44.jpg',
                        ),
                        Gap(16.h),
                        _buildReviewCard(
                          name: 'Michael Chen',
                          date: '1 week ago',
                          rating: 5.0,
                          comment:
                              'Excellent service! They arrived on time and did an amazing job with the deep cleaning.',
                          imageUrl:
                              'https://randomuser.me/api/portraits/men/32.jpg',
                        ),
                        Gap(40.h),
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
  }

  Widget _buildServiceImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(color: Colors.grey.shade200),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  Widget _buildReviewCard({
    required String name,
    required String date,
    required double rating,
    required String comment,
    required String imageUrl,
  }) {
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
              CircleAvatar(
                radius: 20.w,
                backgroundImage: NetworkImage(imageUrl),
              ),
              Gap(12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16.sp),
                  Gap(4.w),
                  Text(
                    rating.toString(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Gap(12.h),
          Text(
            comment,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
        ],
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
  final VoidCallback onPressed;

  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
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
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : Colors.grey.shade600,
          size: 20.sp,
        ),
      ),
    );
  }
}
