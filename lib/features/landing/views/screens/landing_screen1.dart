import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/models/landing_model.dart';
import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
import 'package:mahu_home_services_app/features/landing/views/screens/landing_scren2.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/landing_item.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/next_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/animation.dart';

class LandingScreen1 extends StatefulWidget {
  const LandingScreen1({super.key});

  @override
  State<LandingScreen1> createState() => _LandingScreen1State();
}

class _LandingScreen1State extends State<LandingScreen1> with SingleTickerProviderStateMixin {
  final List<LandingModel> landings = [
    LandingModel(
      img: 'assets/imgs/landing/landing1.jpg',
      title: 'Professional Home Services\nAt Your Doorstep',
      body: 'Book trusted professionals for cleaning, repairs, and maintenance with just a few taps',
      icon: Icons.home_repair_service_rounded,
    ),
    LandingModel(
      img: 'assets/imgs/landing/landing2.jpg',
      title: 'Quality Service\nGuaranteed Satisfaction',
      body: 'Every service comes with our quality promise and customer satisfaction guarantee',
      icon: Icons.verified_user_rounded,
    ),
  ];

  final PageController controller = PageController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool isLast = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button (Top Right)
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: TextButton(
                  onPressed: () {
                    navigateTo(context, const LandingScren2());
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  ),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            
            // Main Content
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    isLast = value == landings.length - 1;
                    _animationController.reset();
                    _animationController.forward();
                  });
                },
                controller: controller,
                physics: const ClampingScrollPhysics(),
                itemCount: landings.length,
                itemBuilder: (context, index) => FadeTransition(
                  opacity: _fadeAnimation,
                  child: LandingItem(
                    model: landings[index],
                  ),
                ),
              ),
            ),
            
            // Bottom Controls
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppConst.appPadding.w,
                vertical: 24.h,
              ),
              child: Column(
                children: [
                  // Page Indicator
                  SmoothPageIndicator(
                    controller: controller,
                    count: landings.length,
                    effect: ExpandingDotsEffect(
                      dotWidth: 8.w,
                      dotHeight: 8.h,
                      expansionFactor: 3.5,
                      spacing: 6.w,
                      dotColor: AppColors.borderPrimary,
                      activeDotColor: AppColors.primary,
                      paintStyle: PaintingStyle.fill,
                    ),
                  ),
                  
                  Gap(24.h),
                  
                  // Next Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isLast) {
                          navigateTo(context, const LandingScren2());
                        } else {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        shadowColor: AppColors.primary.withOpacity(0.3),
                      ),
                      child: Text(
                        isLast ? 'Get Started' : 'Next',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
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
}