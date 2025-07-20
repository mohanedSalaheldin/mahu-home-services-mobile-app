import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/helpers/helping_functions.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
import 'package:mahu_home_services_app/features/user_booking/screens/booking_form_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/widgets/about_service_statsics_card.dart';
import 'package:mahu_home_services_app/features/user_booking/widgets/favorite_button.dart';
import 'package:mahu_home_services_app/features/user_booking/widgets/home_section_label_text.dart';

class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              height: 264.h,
              width: double.infinity,
              fit: BoxFit.cover,
              'assets/imgs/home_cleaning.jpg',
            ),
          ),
          Align(
            alignment: const Alignment(0, 1),
            child: Container(
              height: MediaQuery.of(context).size.height - 244.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(AppConst.appPadding.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const HomeSectionLabelText(
                          txt: 'Home Cleaning',
                        ),
                        FavoriteButton(
                          initialValue: false,
                          onChanged: (value) {
                            // Do something if needed
                            print('Favorite is: $value');
                          },
                        ),
                      ],
                    ),
                    Gap(10.h),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_pin,
                        ),
                        Text(
                          'UAE, Dubai | ',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12.sp,
                          ),
                        ),
                        const Icon(
                          Icons.star,
                          color: Color(0xffFDC95B),
                          size: 18,
                        ),
                        Text.rich(
                          TextSpan(
                            text: '4.8 ',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: const Color(0xffFDC95B),
                            ),
                            children: <InlineSpan>[
                              TextSpan(
                                text: '(540 Reviews)',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Gap(30.h),
                    const HomeSectionLabelText(txt: 'About Service'),
                    Gap(16.h),
                    Text(
                      "Simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                      ),
                    ),
                    Gap(19.h),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AboutServiceStatsicsCard(
                          statistic: '200K+',
                          label: 'Happy Customers',
                        ),
                        AboutServiceStatsicsCard(
                          statistic: '99%',
                          label: 'Client Satisfaction',
                        ),
                      ],
                    ),
                    Gap(30.h),
                    const HomeSectionLabelText(txt: 'Reviews'),
                    Gap(10.h),
                    SizedBox(
                      height: 93.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          ReviewsCardWidget(),
                          ReviewsCardWidget(),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: '\$120',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 34.sp,
                            ),
                            children: <InlineSpan>[
                              TextSpan(
                                text: '/hour',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 164.w,
                          height: 51.h,
                          child: AppFilledButton(
                            onPressed: () {
                              navigateTo(context, const BookingFormScreen());
                            },
                            fontSize: 15,
                            text: 'Book Now',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ReviewsCardWidget extends StatelessWidget {
  const ReviewsCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 187.w,
      height: 93.h,
      decoration: const BoxDecoration(
        color: AppColors.greyBack,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 13.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 14,
                backgroundImage: AssetImage(
                  'assets/imgs/home_cleaning.jpg',
                  // fit: BoxFit.cover,
                ),
              ),
              Gap(6.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Alan',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                    ),
                  ),
                  Text(
                    '1 Day ago',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 7.sp,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.star,
                color: Color(0xffFDC95B),
                size: 18,
              ),
              Text(
                '4.8',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 10.sp,
                  color: const Color(0xffFDC95B),
                ),
              ),
            ],
          ),
          Gap(6.h),
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 6.sp,
            ),
          ),
        ],
      ),
    );
  }
}
