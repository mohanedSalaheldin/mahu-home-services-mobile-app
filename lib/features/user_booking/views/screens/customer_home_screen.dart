import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/features/landing/views/screens/choose_rule_screen.dart';
import 'package:mahu_home_services_app/features/services/views/screens/service_provider_jobs.dart';
import 'package:mahu_home_services_app/features/user_booking/cubit/user_booking_cubit.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/service_category_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/search_results_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/views/widgets/categories_widget.dart';
import 'package:mahu_home_services_app/features/user_booking/views/widgets/popular_services_widget.dart';
import 'package:mahu_home_services_app/features/user_booking/views/widgets/recommended_services_widget.dart';
import 'package:mahu_home_services_app/features/user_booking/views/widgets/search_bar_widget.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';
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
  final Map<String, bool> _favoriteLoadingStates = {};

  @override
  void initState() {
    super.initState();
    var userBookingCubit = UserBookingCubit.get(context);
    final referenceId = CacheHelper.getString('referenceId');

    userBookingCubit.initializeFavorites();

    if (referenceId == null || referenceId == "null" || referenceId.isEmpty) {
      userBookingCubit.fetchAllServicesForAllProviders();
    } else {
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
      if (_bannerController.hasClients && mounted) {
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

  void _handleToggleFavorite(String serviceId) {
    setState(() {
      _favoriteLoadingStates[serviceId] = true;
    });
    final cubit = UserBookingCubit.get(context);
    cubit.toggleFavorite(serviceId).then((_) async {
      await cubit.initializeFavorites();
      if (mounted) {
        setState(() {
          _favoriteLoadingStates[serviceId] = false;
        });
      }
    }).catchError((_) {
      if (mounted) {
        setState(() {
          _favoriteLoadingStates[serviceId] = false;
        });
      }
    });
  }

  bool _isServiceFavorited(String serviceId) {
    final cubit = UserBookingCubit.get(context);
    return cubit.isServiceFavorited(serviceId);
  }

  bool _isFavoriteLoading(String serviceId) {
    return _favoriteLoadingStates[serviceId] ?? false;
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
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
        actions: const [],
      ),
      body: BlocConsumer<UserBookingCubit, UserBookingState>(
        listener: (context, state) {
          if (state is FavoriteOperationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S
                    .of(context)
                    .customerHomeScreenFavoriteError(state.failure.message)),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is FetchAvailableServicesLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          }

          if (state is FetchAvailableServicesError) {
            return Center(
              child: Text(S
                  .of(context)
                  .customerHomeScreenServicesError(state.failure.message)),
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
                  SearchBarWidget(
                    controller: _searchController,
                    onSubmitted: (query) {
                      if (query.trim().isEmpty) return;

                      final userBookingCubit = UserBookingCubit.get(context);
                      final results = userBookingCubit.availableServices
                          .where((service) =>
                              service.name
                                  .toLowerCase()
                                  .contains(query.toLowerCase()) ||
                              service.description
                                  .toLowerCase()
                                  .contains(query.toLowerCase()) ||
                              service.category
                                  .toLowerCase()
                                  .contains(query.toLowerCase()))
                          .toList();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchResultsScreen(
                            services: results,
                            query: query,
                          ),
                        ),
                      );
                    },
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  )
                      .animate()
                      .fadeIn(delay: 100.ms)
                      .slide(begin: const Offset(0, 0.1)),
                  Gap(24.h),
                  SpecialOffersBanner(controller: _bannerController).animate(),
                  Gap(24.h),
                  Builder(
                    builder: (context) {
                      final referenceId = CacheHelper.getString('referenceId');
                      if (referenceId == null ||
                          referenceId == "null" ||
                          referenceId.isEmpty) {
                        return CategoriesWidget(
                          categories: [
                            {
                              'icon': Icons.cleaning_services,
                              'label': S
                                  .of(context)
                                  .customerHomeScreenCategoryCleaning
                            },
                            {
                              'icon': Icons.build,
                              'label':
                                  S.of(context).customerHomeScreenCategoryRepair
                            },
                            {
                              'icon': Icons.format_paint,
                              'label': S
                                  .of(context)
                                  .customerHomeScreenCategoryPainting
                            },
                            {
                              'icon': Icons.electrical_services,
                              'label': S
                                  .of(context)
                                  .customerHomeScreenCategoryElectrical
                            },
                          ],
                          onTap: (label) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ServiceCategoryScreen(
                                  categoryName: label.capitalize(),
                                  services: userBookingCubit.availableServices
                                      .where((s) =>
                                          s.category.toLowerCase() ==
                                          label.toLowerCase())
                                      .toList()
                                      .cast<ServiceModel>(),
                                ),
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
                    services:
                        userBookingCubit.availableServices.take(5).toList(),
                    onToggleFavorite: _handleToggleFavorite,
                    isFavorite: _isServiceFavorited,
                    isFavoriteLoading: _isFavoriteLoading,
                  )
                      .animate()
                      .fadeIn(delay: 300.ms)
                      .slide(begin: const Offset(0, 0.1)),
                  Gap(24.h),
                  RecommendedServicesWidget(
                    services: userBookingCubit.availableServices,
                    onToggleFavorite: _handleToggleFavorite,
                    isFavorite: _isServiceFavorited,
                    isFavoriteLoading: _isFavoriteLoading,
                  )
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
    final offers = [
      _Offer(
        title: S.of(context).customerHomeScreenOfferSpringCleaningTitle,
        subtitle: S.of(context).customerHomeScreenOfferSpringCleaningSubtitle,
        discount: S.of(context).customerHomeScreenOfferSpringCleaningDiscount,
        imageUrl: 'https://images.unsplash.com/photo-1556911220-bff31c812dba',
        color: Colors.blue.shade600,
      ),
      _Offer(
        title: S.of(context).customerHomeScreenOfferWeeklyMaintenanceTitle,
        subtitle:
            S.of(context).customerHomeScreenOfferWeeklyMaintenanceSubtitle,
        discount:
            S.of(context).customerHomeScreenOfferWeeklyMaintenanceDiscount,
        imageUrl:
            'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92',
        color: Colors.blue.shade600,
      ),
      _Offer(
        title: S.of(context).customerHomeScreenOfferEmergencyRepairTitle,
        subtitle: S.of(context).customerHomeScreenOfferEmergencyRepairSubtitle,
        discount: S.of(context).customerHomeScreenOfferEmergencyRepairDiscount,
        imageUrl:
            'https://images.unsplash.com/photo-1512917774080-9991f1c4c750',
        color: Colors.blue.shade600,
      ),
      _Offer(
        title: S.of(context).customerHomeScreenOfferNewCustomerTitle,
        subtitle: S.of(context).customerHomeScreenOfferNewCustomerSubtitle,
        discount: S.of(context).customerHomeScreenOfferNewCustomerDiscount,
        imageUrl: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2',
        color: Colors.blue.shade600,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).customerHomeScreenSpecialOffers,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
        Gap(16.h),
        SizedBox(
          height: 180.h,
          child: PageView.builder(
            controller: controller,
            itemCount: offers.length,
            itemBuilder: (_, index) {
              final offer = offers[index];
              return Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: _OfferCard(offer: offer),
              );
            },
          ),
        ),
        Gap(12.h),
        Center(
          child: SmoothPageIndicator(
            controller: controller,
            count: offers.length,
            effect: ExpandingDotsEffect(
              activeDotColor: AppColors.primary,
              dotColor: Colors.grey.shade300,
              dotWidth: 8.w,
              dotHeight: 8.w,
              spacing: 4.w,
              expansionFactor: 2,
            ),
          ),
        ),
      ],
    );
  }
}

class _Offer {
  final String title;
  final String subtitle;
  final String discount;
  final String imageUrl;
  final Color color;

  _Offer({
    required this.title,
    required this.subtitle,
    required this.discount,
    required this.imageUrl,
    required this.color,
  });
}

class _OfferCard extends StatelessWidget {
  final _Offer offer;

  const _OfferCard({required this.offer});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: offer.imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  color: Colors.grey.shade200,
                ),
                errorWidget: (_, __, ___) => Container(
                  color: Colors.grey.shade200,
                  child: Icon(
                    Icons.local_offer_rounded,
                    color: Colors.grey.shade400,
                    size: 40,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16.w,
              right: 16.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: offer.color,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  offer.discount,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16.w,
              right: 16.w,
              bottom: 16.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(4.h),
                  Text(
                    offer.subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(12.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    // child: Center(
                    //   child: Text(
                    //     S.of(context).customerHomeScreenClaimOffer,
                    //     style: TextStyle(
                    //       color: offer.color,
                    //       fontSize: 14.sp,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MinimalOfferCard extends StatelessWidget {
  final _Offer offer;

  const _MinimalOfferCard({required this.offer});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(
        color: offer.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: offer.color.withOpacity(0.3)),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: offer.color,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.local_offer_rounded,
                color: Colors.white,
                size: 24.w,
              ),
            ),
            Gap(16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer.discount,
                    style: TextStyle(
                      color: offer.color,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    offer.title,
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(2.h),
                  Text(
                    offer.subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12.sp,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: offer.color,
              size: 16.w,
            ),
          ],
        ),
      ),
    );
  }
}

class _MixedOffersBanner extends StatelessWidget {
  final PageController controller;
  const _MixedOffersBanner({required this.controller});

  @override
  Widget build(BuildContext context) {
    final offers = [
      _Offer(
        title: S.of(context).customerHomeScreenOfferLimitedTimeTitle,
        subtitle: S.of(context).customerHomeScreenOfferLimitedTimeSubtitle,
        discount: S.of(context).customerHomeScreenOfferLimitedTimeDiscount,
        imageUrl: 'https://images.unsplash.com/photo-1556911220-bff31c812dba',
        color: Colors.blue.shade600,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).customerHomeScreenHotDeals,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(16.h),
        SizedBox(
          height: 120.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: offers.length,
            itemBuilder: (_, index) {
              return Container(
                width: 280.w,
                margin: EdgeInsets.only(right: 12.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      offers[index].color.withOpacity(0.8),
                      offers[index].color,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              offers[index].discount,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(4.h),
                            Text(
                              offers[index].title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 24.w,
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
                  Text(
                    profile.businessName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Gap(4.h),
                  Text(
                    S.of(context).customerHomeScreenBusinessRegistration(
                        profile.businessRegistration),
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                  Gap(4.h),
                  Text(
                    '${profile.firstName} ${profile.lastName}',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
