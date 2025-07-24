import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/features/user_booking/screens/service_category_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/screens/service_details_screen.dart';
import 'package:mahu_home_services_app/core/models/cleaning_service.dart'
    as models;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final PageController _bannerController = PageController();
  final TextEditingController _searchController = TextEditingController();
  final List<models.CleaningService> _services = [
    models.CleaningService(
      id: '1',
      name: 'Deep Cleaning',
      description:
          'Thorough cleaning of all areas including hard-to-reach spots',
      category: 'cleaning',
      price: 199.99,
      duration: 4,
      rating: 4.8,
      reviews: 124,
      imageUrl: 'https://images.unsplash.com/photo-1600585152220-90363fe7e115',
      isFavorite: false,
      subServices: [
        'Kitchen deep clean',
        'Bathroom sanitization',
        'Window cleaning',
        'Carpet shampooing'
      ],
      serviceType: 'One-Time',
      subType: 'deep',
    ),
    models.CleaningService(
      id: '2',
      name: 'Regular Cleaning',
      description: 'Standard cleaning for maintained homes',
      category: 'cleaning',
      price: 129.99,
      duration: 3,
      rating: 4.5,
      reviews: 89,
      imageUrl: 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a',
      isFavorite: true,
      subServices: [
        'Dusting surfaces',
        'Vacuuming floors',
        'Bathroom cleaning',
        'Kitchen cleaning'
      ],
      serviceType: 'recurring',
      subType: 'weekly',
    ),
    models.CleaningService(
        id: '3',
        name: 'Move-In/Move-Out',
        description: 'Complete cleaning for new or vacated homes',
        category: 'cleaning',
        price: 249.99,
        duration: 6,
        rating: 4.9,
        reviews: 156,
        imageUrl:
            'https://images.unsplash.com/photo-1512917774080-9991f1c4c750',
        isFavorite: false,
        subServices: [
          'Wall washing',
          'Appliance cleaning',
          'Inside cabinets',
          'Baseboard cleaning'
        ],
        serviceType: 'one-time',
        subType: "normal"),
  ];

  @override
  void initState() {
    super.initState();
    // Auto-scroll banners
    _bannerController.addListener(() {});
    _autoScrollBanners();
  }

  void _autoScrollBanners() {
    Future.delayed(const Duration(seconds: 5), () {
      if (_bannerController.hasClients) {
        if (_bannerController.page == 2) {
          _bannerController.animateToPage(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          _bannerController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
        _autoScrollBanners();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 150.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/imgs/logo.png',
                // width: 20.w,
                height: 40.w,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Badge(
              backgroundColor: AppColors.primary,
              label: Text('3'),
              child: Icon(Icons.notifications_outlined),
            ),
            onPressed: () {},
          ),
          Gap(16.w),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              _buildSearchBar()
                  .animate()
                  .fadeIn(delay: 100.ms)
                  .slide(begin: const Offset(0, 0.1)),
              Gap(24.h),

              // Special Offers Banner
              _buildSpecialOffersBanner(),
              Gap(16.h),

              // Categories
              _buildServiceCategories()
                  .animate()
                  .fadeIn(delay: 200.ms)
                  .slide(begin: const Offset(0, 0.1)),
              Gap(24.h),

              // Popular Services
              _buildPopularServices()
                  .animate()
                  .fadeIn(delay: 300.ms)
                  .slide(begin: const Offset(0, 0.1)),
              Gap(24.h),

              // Recommended Services
              _buildRecommendedServices()
                  .animate()
                  .fadeIn(delay: 400.ms)
                  .slide(begin: const Offset(0, 0.1)),
              Gap(24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
          hintText: 'Search cleaning services...',
          hintStyle: TextStyle(color: Colors.grey.shade600),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15.h),
        ),
        style: TextStyle(fontSize: 14.sp),
      ),
    );
  }

  Widget _buildSpecialOffersBanner() {
    final banners = [
      'https://images.unsplash.com/photo-1556911220-bff31c812dba',
      'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92',
      'https://images.unsplash.com/photo-1512917774080-9991f1c4c750',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Special Offers',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(12.h),
        SizedBox(
          height: 150.h,
          child: PageView.builder(
            controller: _bannerController,
            itemCount: banners.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 8.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: banners[index],
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: Colors.grey.shade200),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16.w,
                        bottom: 16.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Spring Cleaning Special',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '20% OFF all services this week',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Gap(8.h),
        Center(
          child: SmoothPageIndicator(
            controller: _bannerController,
            count: banners.length,
            effect: WormEffect(
              activeDotColor: AppColors.primary,
              dotColor: Colors.grey.shade300,
              dotWidth: 10.w,
              dotHeight: 10.w,
              spacing: 6.w,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCategories() {
    final categories = [
      {'icon': Icons.cleaning_services, 'label': 'Deep Clean'},
      {'icon': Icons.repeat, 'label': 'Recurring'},
      {'icon': Icons.event, 'label': 'One-Time'},
      {'icon': Icons.air, 'label': 'Normal'},
      {'icon': Icons.window, 'label': 'Windows'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(12.h),
        SizedBox(
          height: 100.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => Gap(12.w),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ServiceCategoryScreen(
                        categoryName: categories[index]['label'] as String,
                        services: _services, // Pass your services list
                      ),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 80.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          categories[index]['icon'] as IconData,
                          color: AppColors.primary,
                        ),
                      ),
                      Gap(8.h),
                      Text(
                        categories[index]['label'] as String,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPopularServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Popular Services',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'View All',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        Gap(12.h),
        SizedBox(
          height: 220.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _services.length,
            separatorBuilder: (_, __) => Gap(16.w),
            itemBuilder: (context, index) {
              final service = _services[index];
              return _buildServiceCard(service);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recommended For You',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'View All',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        Gap(12.h),
        Column(
          children: _services
              .map((service) => Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: _buildServiceListTile(service),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildServiceCard(models.CleaningService service) {
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
        width: 160.w,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Image
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    height: 120.h,
                    width: double.infinity,
                    imageUrl: service.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: Colors.grey.shade200),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Positioned(
                    top: 8.w,
                    right: 8.w,
                    child: FavoriteButton(
                      isFavorite: service.isFavorite,
                      onPressed: () {
                        setState(() {
                          service.isFavorite = !service.isFavorite;
                        });
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 14.sp),
                          Gap(4.w),
                          Text(
                            '${service.rating} (${service.reviews})',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Service Info
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(4.h),
                  Text(
                    '${service.duration} hrs • \$${service.price}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Gap(8.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: service.serviceType == 'Recurring'
                          ? Colors.blue.withOpacity(0.1)
                          : Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      service.serviceType,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: service.serviceType == 'Recurring'
                            ? Colors.blue
                            : Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceListTile(models.CleaningService service) {
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
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(12),
              ),
              child: CachedNetworkImage(
                width: 100.w,
                height: 100.h,
                imageUrl: service.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: Colors.grey.shade200),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            service.name,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        FavoriteButton(
                          isFavorite: service.isFavorite,
                          onPressed: () {
                            setState(() {
                              service.isFavorite = !service.isFavorite;
                            });
                          },
                        ),
                      ],
                    ),
                    Gap(4.h),
                    Text(
                      service.description,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(8.h),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 14.sp),
                        Gap(4.w),
                        Text(
                          '${service.rating} (${service.reviews})',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        const Spacer(),
                        Text(
                          '\$${service.price}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bannerController.dispose();
    _searchController.dispose();
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
        width: 28.w,
        height: 28.w,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
        ),
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : Colors.grey,
          size: 16.sp,
        ),
      ),
    );
  }
}
