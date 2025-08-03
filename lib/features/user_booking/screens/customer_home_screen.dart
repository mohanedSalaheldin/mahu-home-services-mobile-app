import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/features/landing/views/screens/choose_rule_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/screens/service_category_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/screens/service_details_screen.dart';
import 'package:mahu_home_services_app/core/models/cleaning_service.dart'
    as models;
import 'package:mahu_home_services_app/features/user_booking/widgets/categories_widget.dart';
import 'package:mahu_home_services_app/features/user_booking/widgets/favorite_button.dart';
import 'package:mahu_home_services_app/features/user_booking/widgets/popular_services_widget.dart';
import 'package:mahu_home_services_app/features/user_booking/widgets/recommended_services_widget.dart';
import 'package:mahu_home_services_app/features/user_booking/widgets/search_bar_widget.dart';
import 'package:mahu_home_services_app/features/user_booking/widgets/service_card.dart';
import 'package:mahu_home_services_app/features/user_booking/widgets/service_list_tile.dart';
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
    _autoScrollBanners();
  }

  void _autoScrollBanners() {
    Future.delayed(const Duration(seconds: 5), () {
      if (_bannerController.hasClients) {
        if (_bannerController.page == 2) {
          _bannerController.animateToPage(0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        } else {
          _bannerController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        }
        _autoScrollBanners();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const ChooseRuleScreen()));
        },
        child: const Icon(Icons.logout_outlined),
      ),
      appBar: AppBar(
        leadingWidth: 150.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Row(
            children: [
              Image.asset('assets/imgs/logo.png',
                  height: 40.w, fit: BoxFit.contain),
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
              SearchBarWidget(controller: _searchController)
                  .animate()
                  .fadeIn(delay: 100.ms)
                  .slide(begin: const Offset(0, 0.1)),
              Gap(24.h),
              SpecialOffersBanner(controller: _bannerController).animate(),
              Gap(24.h),
              CategoriesWidget(onTap: (label) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServiceCategoryScreen(
                        categoryName: label, services: _services),
                  ),
                );
              })
                  .animate()
                  .fadeIn(delay: 200.ms)
                  .slide(begin: const Offset(0, 0.1)),
              Gap(24.h),
              PopularServicesWidget(
                      services: _services,
                      onToggleFavorite: (s) {
                        setState(() => s.isFavorite = !s.isFavorite);
                      })
                  .animate()
                  .fadeIn(delay: 300.ms)
                  .slide(begin: const Offset(0, 0.1)),
              Gap(24.h),
              RecommendedServicesWidget(
                      services: _services,
                      onToggleFavorite: (s) {
                        setState(() => s.isFavorite = !s.isFavorite);
                      })
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

  @override
  void dispose() {
    _bannerController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}

class SpecialOffersBanner extends StatelessWidget {
  final PageController controller;
  const SpecialOffersBanner({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final banners = [
      CachedNetworkImage(
        imageUrl: 'https://images.unsplash.com/photo-1556911220-bff31c812dba',
        fit: BoxFit.cover,
        placeholder: (_, __) => Container(color: Colors.grey.shade200),
      ),
      CachedNetworkImage(
        imageUrl:
            'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92',
        fit: BoxFit.cover,
        placeholder: (_, __) => Container(color: Colors.grey.shade200),
      ),
      CachedNetworkImage(
        imageUrl:
            'https://images.unsplash.com/photo-1512917774080-9991f1c4c750',
        fit: BoxFit.cover,
        placeholder: (_, __) => Container(color: Colors.grey.shade200),
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Special Offers',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
        Gap(12.h),
        SizedBox(
          height: 150.h,
          child: PageView.builder(
            controller: controller,
            itemCount: banners.length,
            itemBuilder: (_, i) => Container(
              margin: EdgeInsets.only(right: 8.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5)),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: banners[i],
              ),
            ),
          ),
        ),
        Gap(8.h),
        Center(
          child: SmoothPageIndicator(
            controller: controller,
            count: banners.length,
            effect: WormEffect(
              activeDotColor: AppColors.primary,
              dotColor: Colors.grey.shade300,
              dotWidth: 10.w,
              dotHeight: 10.w,
              spacing: 6.w,
            ),
          ),
        )
      ],
    );
  }
}
