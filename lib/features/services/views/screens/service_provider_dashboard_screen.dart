import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/helpers/helping_functions.dart';
import 'package:mahu_home_services_app/core/widgets/app_filed_label_text.dart';
import 'package:mahu_home_services_app/features/services/views/screens/add_service_screen.dart';

class ServiceProviderDashboardScreen extends StatelessWidget {
  const ServiceProviderDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Dashboard"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings_outlined,
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: AppConst.appPadding.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppConst.appPadding.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, Alex',
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
                        figer: '150',
                        label: 'Rating',
                        width: 171.w,
                      ),
                      DashboardStatisticsCardWidget(
                        figer: '150',
                        label: 'Rating',
                        width: 171.w,
                      ),
                    ],
                  ),
                  Gap(16.h),
                  const DashboardStatisticsCardWidget(
                    figer: '150',
                    label: 'Rating',
                    // width: 171.w,
                  ),
                  Gap(32.h),
                  Text(
                    'Upcoming Jobs',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Gap(16.h),
            const UpcomingJobsCardWidget(
              address: '123 Main St, Anytown',
              serviceType: 'Cleaning',
              time: '10:00 AM',
            ),
            const UpcomingJobsCardWidget(
              address: '123 Main St, Anytown',
              serviceType: 'Cleaning',
              time: '10:00 AM',
            ),
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
                    onPressed: () {},
                    txt: 'View Calendar',
                    isFiiled: false,
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

class DashboardFilledButton extends StatelessWidget {
  const DashboardFilledButton({
    super.key,
    required this.txt,
    required this.onPressed,
    this.isFiiled = true,
  });
  final String txt;
  final bool isFiiled;
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
              isFiiled ? AppColors.blue : const Color(0xffE8EDF2)),
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
            color: isFiiled ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

class UpcomingJobsCardWidget extends StatelessWidget {
  const UpcomingJobsCardWidget({
    super.key,
    required this.time,
    required this.serviceType,
    required this.address,
  });
  final String time;
  final String serviceType;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.greyBack,
      height: 72.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: const BoxDecoration(
              color: Color(0xffE8EDF2),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: const Icon(Icons.home_outlined),
          ),
          Gap(16.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$serviceType - $time',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gap(2.h),
              Text(
                address,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff4F7596)),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class DashboardStatisticsCardWidget extends StatelessWidget {
  const DashboardStatisticsCardWidget({
    super.key,
    this.width,
    required this.label,
    required this.figer,
  });
  final double? width;
  final String label;
  final String figer;

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
            figer,
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
