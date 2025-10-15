import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
import 'package:mahu_home_services_app/features/layouts/provider_layout_screen.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_cubit.dart';
import 'package:mahu_home_services_app/features/services/cubit/services_state.dart';
import 'package:mahu_home_services_app/features/services/views/screens/add_service_screen.dart';
import 'package:mahu_home_services_app/features/services/views/screens/service_details_screen.dart';
import 'package:mahu_home_services_app/features/services/models/service_model.dart';
import 'package:mahu_home_services_app/generated/l10n.dart';

class ServiceProviderDashboardScreen extends StatefulWidget {
  const ServiceProviderDashboardScreen({super.key});

  @override
  State<ServiceProviderDashboardScreen> createState() =>
      _ServiceProviderDashboardScreenState();
}

class _ServiceProviderDashboardScreenState
    extends State<ServiceProviderDashboardScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = ServiceCubit.get(context);
      cubit.fetchServices();
      cubit.fetchDashboardData();
    });
  }

  void _loadData() {
    final cubit = ServiceCubit.get(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (cubit.services.isEmpty) {
        cubit.fetchServices();
      }
      if (cubit.profile.firstName.isEmpty) {
        cubit.fetchDashboardData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(S.of(context).serviceProviderDashboardScreenTitle),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: BlocConsumer<ServiceCubit, ServiceState>(
        listener: (context, state) {
          if (state is ServiceDeletionSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S
                    .of(context)
                    .serviceProviderDashboardScreenDeletionSuccess),
                backgroundColor: AppColors.success,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = ServiceCubit.get(context);

          if (state is ServiceGetAllLoadingState ||
              state is DashboardLoading ||
              cubit.services.isEmpty && cubit.profile.firstName.isEmpty) {
            return _buildLoadingState();
          }

          if (state is ServiceGetAllFailedState || state is DashboardError) {
            return _buildErrorState(state);
          }

          return RefreshIndicator(
            onRefresh: () async {
              await cubit.fetchServices();
              cubit.fetchDashboardData();
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                return CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: _buildHeaderSection(cubit),
                    ),
                    SliverToBoxAdapter(
                      child: _buildStatisticsSection(cubit),
                    ),
                    SliverToBoxAdapter(
                      child: _buildServicesHeader(cubit),
                    ),
                    if (cubit.services.isEmpty)
                      SliverToBoxAdapter(child: _buildEmptyState())
                    else
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final service = cubit.services[index];
                            return ServiceListItem(
                              service: service,
                              onTap: () async {
                                final shouldReload = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ServiceDetailsScreen(service: service),
                                  ),
                                );

                                if (shouldReload == true) {
                                  final cubit = ServiceCubit.get(context);
                                  cubit.fetchServices();
                                  cubit.fetchDashboardData();
                                }
                              },
                            );
                          },
                          childCount: cubit.services.length,
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 20.h,
                          bottom: MediaQuery.of(context).padding.bottom + 20.h,
                          left: AppConst.appPadding.w,
                          right: AppConst.appPadding.w,
                        ),
                        child: _buildActionButtons(),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildErrorState(ServiceState state) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.sp,
              color: AppColors.error,
            ),
            Gap(16.h),
            Text(
              S.of(context).serviceProviderDashboardScreenErrorTitle,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(8.h),
            Text(
              S.of(context).serviceProviderDashboardScreenErrorSubtitle,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(24.h),
            ElevatedButton(
              onPressed: _loadData,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
              child:
                  Text(S.of(context).serviceProviderDashboardScreenRetryButton),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(ServiceCubit cubit) {
    return Container(
      padding: EdgeInsets.all(AppConst.appPadding.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).serviceProviderDashboardScreenWelcome,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          Gap(4.h),
          Text(
            cubit.profile.firstName.isNotEmpty
                ? cubit.profile.firstName
                : S
                    .of(context)
                    .serviceProviderDashboardScreenDefaultProviderName,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade800,
            ),
          ),
          Gap(8.h),
          Text(
            S.of(context).serviceProviderDashboardScreenPerformanceOverview,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsSection(ServiceCubit cubit) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppConst.appPadding.w),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DashboardStatisticsCard(
                  icon: Icons.star_rounded,
                  value:
                      cubit.performanceModel.averageRating.toStringAsFixed(1),
                  title:
                      S.of(context).serviceProviderDashboardScreenRatingTitle,
                  color: AppColors.warning,
                ),
              ),
              Gap(12.w),
              Expanded(
                child: DashboardStatisticsCard(
                  icon: Icons.task_alt_rounded,
                  value: '${cubit.performanceModel.completionRate.round()}%',
                  title: S
                      .of(context)
                      .serviceProviderDashboardScreenCompletionRateTitle,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
          Gap(12.h),
          Row(
            children: [
              Expanded(
                child: DashboardStatisticsCard(
                  icon: Icons.check_circle_rounded,
                  value: cubit.performanceModel.completed.toString(),
                  title: S
                      .of(context)
                      .serviceProviderDashboardScreenCompletedJobsTitle,
                  color: AppColors.info,
                ),
              ),
              Gap(12.w),
              Expanded(
                child: DashboardStatisticsCard(
                  icon: Icons.attach_money_rounded,
                  value: '\$${cubit.performanceModel.totalEarnings}',
                  title: S
                      .of(context)
                      .serviceProviderDashboardScreenTotalEarningsTitle,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          Gap(16.h),
        ],
      ),
    );
  }

  Widget _buildServicesHeader(ServiceCubit cubit) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConst.appPadding.w,
        vertical: 8.h,
      ),
      child: Row(
        children: [
          Icon(
            Icons.home_repair_service_rounded,
            color: AppColors.primary,
            size: 20.sp,
          ),
          Gap(8.w),
          Text(
            S.of(context).serviceProviderDashboardScreenServicesTitle,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade800,
            ),
          ),
          const Spacer(),
          Badge(
            backgroundColor: AppColors.primary,
            label: Text(
              cubit.services.length.toString(),
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(AppConst.appPadding.w),
      child: Column(
        children: [
          Icon(
            Icons.handyman_rounded,
            size: 56.sp,
            color: Colors.grey.shade300,
          ),
          Gap(12.h),
          Text(
            S.of(context).serviceProviderDashboardScreenNoServicesTitle,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          Gap(6.h),
          Text(
            S.of(context).serviceProviderDashboardScreenNoServicesSubtitle,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: DashboardActionButton(
            onPressed: () async {
              navigateTo(context, const AddServiceScreen());
              _loadData();
            },
            text: S.of(context).serviceProviderDashboardScreenAddServiceButton,
            icon: Icons.add_rounded,
            variant: ButtonVariant.primary,
          ),
        ),
        Gap(12.w),
        Expanded(
          child: DashboardActionButton(
            onPressed: () {
              ProviderNavigationCubit.get(context).changeTab(2);
            },
            text: S.of(context).serviceProviderDashboardScreenCalendarButton,
            icon: Icons.calendar_month_rounded,
            variant: ButtonVariant.secondary,
          ),
        ),
      ],
    );
  }
}

enum ButtonVariant { primary, secondary }

class DashboardActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final ButtonVariant variant;

  const DashboardActionButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.variant = ButtonVariant.primary,
  });

  @override
  Widget build(BuildContext context) {
    final isPrimary = variant == ButtonVariant.primary;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 48.h,
        maxHeight: 52.h,
      ),
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          size: 18.sp,
          color: isPrimary ? Colors.white : AppColors.primary,
        ),
        label: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
            color: isPrimary ? Colors.white : AppColors.primary,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppColors.primary : Colors.white,
          foregroundColor: isPrimary ? Colors.white : AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isPrimary
                ? BorderSide.none
                : const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          elevation: isPrimary ? 2 : 0,
          shadowColor: isPrimary ? AppColors.primary.withOpacity(0.3) : null,
          padding: EdgeInsets.symmetric(vertical: 12.h),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class DashboardStatisticsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const DashboardStatisticsCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: color,
                size: 28.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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

class ServiceListItem extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback onTap;

  const ServiceListItem({
    super.key,
    required this.service,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppConst.appPadding.w,
        vertical: 5.h,
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        elevation: 1,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70.w,
                  height: 70.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(service.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Gap(12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              service.name,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade800,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: service.active
                                  ? AppColors.success.withOpacity(0.1)
                                  : AppColors.error.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              service.active
                                  ? S
                                      .of(context)
                                      .serviceProviderDashboardScreenServiceActive
                                  : S
                                      .of(context)
                                      .serviceProviderDashboardScreenServiceInactive,
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w600,
                                color: service.active
                                    ? AppColors.success
                                    : AppColors.error,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(3.h),
                      Text(
                        service.description,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gap(10.h),
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                size: 13.sp,
                                color: Colors.amber,
                              ),
                              Gap(3.w),
                              Text(
                                service.averageRating.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Gap(1.w),
                              Text(
                                '(${service.totalReviews})',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            '${_currencyPrefix(service.currency)}${service.basePrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                          Gap(3.w),
                          Text(
                            _getPricingLabel(service.pricingModel, context),
                            style: TextStyle(
                              fontSize: 9.sp,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getPricingLabel(String pricingModel, BuildContext context) {
    switch (pricingModel.toLowerCase()) {
      case 'hourly':
        return S.of(context).serviceProviderDashboardScreenPricingHourly;
      case 'fixed':
        return S.of(context).serviceProviderDashboardScreenPricingFixed;
      case 'squarefoot':
        return S.of(context).serviceProviderDashboardScreenPricingSquareFoot;
      default:
        return '';
    }
  }

  String _currencyPrefix(String? code) {
    final c = (code ?? 'AED').toUpperCase();
    switch (c) {
      case 'AED':
        return 'AED ';
      case 'USD':
        return '\$';
      case 'EGP':
        return 'EGP ';
      case 'SAR':
        return 'SAR ';
      default:
        return '$c ';
    }
  }
}
