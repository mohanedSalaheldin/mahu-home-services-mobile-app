import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/models/landing_model.dart';
import 'package:mahu_home_services_app/core/utils/helpers/helping_functions.dart';
import 'package:mahu_home_services_app/features/landing/views/screens/landing_scren2.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/landing_item.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/next_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/constants/colors.dart';

class LandingScreen1 extends StatefulWidget {
  const LandingScreen1({super.key});

  @override
  State<LandingScreen1> createState() => _LandingScreen1State();
}

class _LandingScreen1State extends State<LandingScreen1> {
  final List<LandingModel> landings = [
    LandingModel(
      img: 'assets/imgs/landing/landing1.jpg',
      title: 'Professional Home Help, Right When You Need It',
      body:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Ok this has',
    ),
    LandingModel(
      img: 'assets/imgs/landing/landing2.jpg',
      title: 'Professional Home Help, Right When You Need It',
      body:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Ok this has',
    ),
  ];

  final PageController controller = PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  isLast = value == landings.length - 1;
                });
              },
              controller: controller,
              physics: const ClampingScrollPhysics(),
              itemCount: landings.length,
              itemBuilder: (context, index) => LandingItem(
                model: landings[index],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppConst.appPadding.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Gap(5.h),
                SmoothPageIndicator(
                  controller: controller,
                  count: 2,
                  axisDirection: Axis.horizontal,
                  effect: ExpandingDotsEffect(
                    dotWidth: 10.h,
                    expansionFactor: 3,
                    dotHeight: 10.h,
                    dotColor: const Color(0xffF6F6F6),
                    activeDotColor: AppColors.blue,
                  ),
                ),
                Gap(5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        navigateTo(context, const LandingScren2());
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                    NextButton(
                      onTap: () {
                        if (isLast) {
                          navigateTo(context, const LandingScren2());
                        }
                        controller.nextPage(
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.bounceInOut);
                      },
                    )
                  ],
                ),
                Gap(10.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
