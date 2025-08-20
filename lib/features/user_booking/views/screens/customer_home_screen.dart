import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/login_screen.dart';
import 'package:mahu_home_services_app/features/landing/views/screens/choose_rule_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/cubit/user_booking_cubit.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/service_category_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/service_details_screen.dart';
import 'package:mahu_home_services_app/core/models/cleaning_service.dart'
    as models;
import 'package:mahu_home_services_app/features/user_booking/views/widgets/categories_widget.dart';
import 'package:mahu_home_services_app/features/user_booking/views/widgets/favorite_button.dart';
import 'package:mahu_home_services_app/features/user_booking/views/widgets/popular_services_widget.dart';
import 'package:mahu_home_services_app/features/user_booking/views/widgets/recommended_services_widget.dart';
import 'package:mahu_home_services_app/features/user_booking/views/widgets/search_bar_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:mahu_home_services_app/features/services/services/profile_services.dart';
import 'package:mahu_home_services_app/features/services/models/user_base_profile_model.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final PageController _bannerController = PageController();
  final TextEditingController _searchController = TextEditingController();

  UserBaseProfileModel? providerProfile;
  bool isLoadingProviderProfile = false;

  @override
  void initState() {
    super.initState();
    var userBookingCubit = UserBookingCubit.get(context);
    final referenceId = CacheHelper.getString('referenceId');
    if (referenceId == null || referenceId == "null" || referenceId.isEmpty) {
      // Get all services for all providers
      userBookingCubit.fetchAllServicesForAllProviders();
    } else {
      // Get services for the specific provider
      userBookingCubit.fetchServicesForProvider(referenceId);
    }
    _fetchProviderProfile();
    _autoScrollBanners();
  }

  Future<void> _fetchProviderProfile() async {
    final referenceId = CacheHelper.getString('referenceId');
    if (referenceId != null && referenceId.isNotEmpty) {
      setState(() => isLoadingProviderProfile = true);
      final result = await ProfileServices().getProviderProfile(referenceId);
      result.fold(
        (failure) {
          setState(() {
            providerProfile = null;
            isLoadingProviderProfile = false;
          });
        },
        (profile) {
          setState(() {
            providerProfile = profile;
            isLoadingProviderProfile = false;
          });
        },
      );
    }
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
        onPressed: () async {
          await CacheHelper.remove('token');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const RoleSelectionScreen()));
        },
        child: const Icon(Icons.logout_outlined),
      ),
      appBar: AppBar(
        leadingWidth: 150.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Row(
            children: [
              Builder(
                builder: (context) {
                  final referenceId = CacheHelper.getString('referenceId');
                  
                  if (referenceId == null || referenceId == "null") {
                    return Image.asset(
                      'assets/imgs/logo.png',
                      height: 40.w,
                      fit: BoxFit.contain,
                    );
                  }
                  // If referenceId exists, don't show logo
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
        actions: [],
      ),
      body: BlocConsumer<UserBookingCubit, UserBookingState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is FetchAvailableServicesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is FetchAvailableServicesError) {
            return const Center(
              child: Text('Error loading services'),
            );
          }
          var userBookingCubit = UserBookingCubit.get(context);
          final referenceId = CacheHelper.getString('referenceId');

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (referenceId != null &&
                      referenceId.isNotEmpty &&
                      providerProfile != null)
                    _ProviderProfileCard(
                        profile: providerProfile!,
                        isLoading: isLoadingProviderProfile),
                  SearchBarWidget(controller: _searchController)
                      .animate()
                      .fadeIn(delay: 100.ms)
                      .slide(begin: const Offset(0, 0.1)),
                  Gap(24.h),
                  SpecialOffersBanner(controller: _bannerController).animate(),
                  Gap(24.h),
                  Builder(
                    builder: (context) {
                      final referenceId = CacheHelper.getString('referenceId');
                      if (referenceId == null || referenceId == "null" || referenceId.isEmpty) {
                        return CategoriesWidget(
                          categories: const [
                            {'icon': Icons.cleaning_services, 'label': 'cleaning'},
                            {'icon': Icons.build, 'label': 'repair'},
                            {'icon': Icons.format_paint, 'label': 'painting'},
                            {'icon': Icons.electrical_services, 'label': 'electrical'},
                          ],
                          onTap: (label) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ServiceCategoryScreen(
                                    categoryName: label, services: const []),
                              ),
                            );
                          },
                        )
                            .animate()
                            .fadeIn(delay: 200.ms)
                            .slide(begin: const Offset(0, 0.1));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  Gap(24.h),
                  PopularServicesWidget(
                          services: userBookingCubit.availableServices,
                          onToggleFavorite: (service) {
                            setState(() {
                              service.isFavorite = !service.isFavorite;
                            });
                          })
                      .animate()
                      .fadeIn(delay: 300.ms)
                      .slide(begin: const Offset(0, 0.1)),
                  Gap(24.h),
                  RecommendedServicesWidget(
                          services: userBookingCubit.availableServices,
                          onToggleFavorite: (service) {
                            setState(() {
                              service.isFavorite = !service.isFavorite;
                            });
                          })
                      .animate()
                      .fadeIn(delay: 400.ms)
                      .slide(begin: const Offset(0, 0.1)),
                  Gap(24.h),
                ],
              ),
            ),
          );
        },
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

class _ProviderProfileCard extends StatelessWidget {
  final UserBaseProfileModel profile;
  final bool isLoading;
  const _ProviderProfileCard({required this.profile, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.only(top: 16.h, bottom: 16.h),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: profile.avatar,
                height: 60.w,
                width: 60.w,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  height: 60.w,
                  width: 60.w,
                  color: Colors.grey.shade200,
                ),
              ),
            ),
            Gap(13.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(profile.businessName,
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  Gap(4.h),
                  Text('Business Registration: ${profile.businessRegistration}',
                      style: TextStyle(
                          fontSize: 14.sp, color: Colors.grey.shade700)),
                  Gap(4.h),
                  Text('${profile.firstName} ${profile.lastName}',
                      style: TextStyle(fontSize: 14.sp)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
