import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
import 'package:mahu_home_services_app/features/user_booking/views/screens/select_address_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/views/widgets/dashed_line.dart';
import 'package:mahu_home_services_app/features/user_booking/views/widgets/service_summary_card.dart';

class ReviewBookingSummaryScreen extends StatelessWidget {
  const ReviewBookingSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Summary'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConst.appPadding.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DottedBorder(
              color: AppColors.black,
              strokeWidth: 1,
              dashPattern: const [7, 7],
              borderType: BorderType.RRect,
              radius: const Radius.circular(10),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(),
                child: Padding(
                  padding: EdgeInsets.all(AppConst.appPadding.w),
                  child: Column(
                    children: [
                      const ServiceSummaryCard(),
                      Gap(30.h),
                      const DashedLine(
                        color: AppColors.black,
                        dashWidth: 4,
                        dashGap: 4,
                        height: 1,
                      ),
                      Gap(30.h),
                      const SummeryLineItem(
                        label: 'Service Name',
                        value: 'Home Cleaning',
                      ),
                      Gap(30.h),
                      const SummeryLineItem(
                        label: 'Service Provider',
                        value: 'John Doa',
                      ),
                      Gap(30.h),
                      const SummeryLineItem(
                        label: 'Booking Date',
                        value: 'Wed, 18 Apr, 2025',
                      ),
                      Gap(30.h),
                      const SummeryLineItem(
                        label: 'Booking Time',
                        value: '10:00-12:00AM',
                      ),
                      Gap(30.h),
                      const SummeryLineItem(
                        label: 'Total Room',
                        value: '07',
                      ),
                      Gap(30.h),
                      const DashedLine(
                        color: AppColors.black,
                        dashWidth: 4,
                        dashGap: 4,
                        height: 1,
                      ),
                      Gap(30.h),
                      const SummeryLineItem(
                        label: 'Amount',
                        value: '2,100AED',
                      ),
                      Gap(30.h),
                      const SummeryLineItem(
                        label: 'Tax & Fee',
                        value: '2.5AED',
                      ),
                      Gap(30.h),
                      const SummeryLineItem(
                        label: 'Total Amount',
                        value: '2,102.5AED',
                      ),
                      Gap(30.h),
                      const SummeryLineItem(
                        label: 'Payment Method',
                        value: 'Cash',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // const Spacer(),
            AppFilledButton(
              onPressed: () {
                // navigateTo(context, const SelectAddressScreen());
              },
              fontSize: 15,
              text: "Pay Now",
            ),
          ],
        ),
      ),
    );
  }
}

class SummeryLineItem extends StatelessWidget {
  const SummeryLineItem({
    super.key,
    required this.label,
    required this.value,
  });
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
