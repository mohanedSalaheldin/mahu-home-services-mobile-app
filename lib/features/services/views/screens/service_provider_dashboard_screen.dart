import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
import 'package:mahu_home_services_app/features/layouts/provider_layout_screen.dart';
import 'package:mahu_home_services_app/features/services/cubit/servises_cubit.dart';
import 'package:mahu_home_services_app/features/services/cubit/servises_state.dart';
import 'package:mahu_home_services_app/features/services/views/screens/add_service_screen.dart';
import 'package:mahu_home_services_app/features/services/views/screens/service_details_screen.dart';
import 'package:mahu_home_services_app/features/services/views/screens/service_provider_calender.dart';
import '../../models/service_model.dart';

class ServiceProviderDashboardScreen extends StatefulWidget {
  const ServiceProviderDashboardScreen({super.key});

  @override
  State<ServiceProviderDashboardScreen> createState() =>
      _ServiceProviderDashboardScreenState();
}

class _ServiceProviderDashboardScreenState
    extends State<ServiceProviderDashboardScreen> {
  @override
  initState() {
    super.initState();
    // Fetch services when the screen is initialized
    var cubit = ServiceCubit.get(context);
    if (cubit.services.isEmpty) {
      cubit.fetchServices();
    }
    if (cubit.profile.firstName.isEmpty) {
      cubit.fetchDashboardData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var cubit = ServiceCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        // leading: const BackButton(),
        title: const Text("Dashboard"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
        elevation: 0,
      ),
      body: BlocConsumer<ServiceCubit, ServiceState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is ServiceGetAllLoadingState || state is DashboardLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ServiceGetAllFailedState ||
              state is DashboardError) {
            return Center(
              child: Text(
                'Error: {state.error}',
                style: TextStyle(fontSize: 16.sp, color: Colors.red),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(vertical: AppConst.appPadding.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: AppConst.appPadding.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back, ${cubit.profile.firstName}',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Gap(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DashboardStatisticsCardWidget(
                              figure: cubit.performanceModel.averageRating
                                  .toString(),
                              label: 'Rating',
                              width: 171.w,
                            ),
                            DashboardStatisticsCardWidget(
                              figure: cubit.performanceModel.completionRate
                                  .toString(),
                              label: 'Services',
                              width: 171.w,
                            ),
                          ],
                        ),
                        Gap(16.h),
                        DashboardStatisticsCardWidget(
                          figure: cubit.performanceModel.completed.toString(),
                          label: 'Completed Jobs',
                        ),
                        Gap(32.h),
                        Text(
                          'Your Services',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Gap(16.h),
                      ],
                    ),
                  ),
                  // Services List
                  cubit.services.isEmpty
                      ? const Center(child: Text('No Services Added Yet'))
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cubit.services
                              .length, // Replace with your actual services count
                          itemBuilder: (context, index) {
                            ServiceModel service = cubit.services[index];

                            // Replace with your actual service data
                            return ServiceListItem(
                              service: service,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ServiceDetailsScreen(service: service),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                  Gap(16.h),
                  Padding(
                    padding: EdgeInsets.all(AppConst.appPadding.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DashboardFilledButton(
                          onPressed: () {
                            navigateTo(context, const AddServiceScreen());
                          },
                          txt: '+ New Service',
                        ),
                        DashboardFilledButton(
                          onPressed: () {
                            ProviderNavigationCubit.get(context).changeTab(2);

                            // navigateTo(
                            //     context, const ServiceProviderBookingsScreen());
                          },
                          txt: 'View Calendar',
                          isFilled: false,
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
    );
  }
}

class DashboardFilledButton extends StatelessWidget {
  const DashboardFilledButton({
    super.key,
    required this.txt,
    required this.onPressed,
    this.isFilled = true,
  });
  final String txt;
  final bool isFilled;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: 130.w,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: const WidgetStatePropertyAll(EdgeInsets.all(8)),
          backgroundColor: WidgetStatePropertyAll(
              isFilled ? AppColors.blue : const Color(0xffE8EDF2)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          txt,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14.sp,
            color: isFilled ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

class DashboardStatisticsCardWidget extends StatelessWidget {
  const DashboardStatisticsCardWidget({
    super.key,
    this.width,
    required this.label,
    required this.figure,
  });
  final double? width;
  final String label;
  final String figure;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112.h,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: .5, color: const Color(0xffD1DBE8)),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Gap(8.h),
          Text(
            figure,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: AppConst.appPadding.w, vertical: 8.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(service.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Gap(16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    service.description,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(8.h),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16.sp),
                      Gap(4.w),
                      Text(
                        '4.8 (125)',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      const Spacer(),
                      Text(
                        '\$${service.basePrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blue,
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
    );
  }
}
