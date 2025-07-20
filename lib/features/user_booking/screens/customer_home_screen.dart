import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/helpers/form_validation_method.dart';
import 'package:mahu_home_services_app/core/utils/helpers/helping_functions.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/widgets/custom_text_field.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_text_button.dart';
import 'package:mahu_home_services_app/features/user_booking/screens/service_details_screen.dart';
import 'package:mahu_home_services_app/features/user_booking/widgets/categories_item.dart';
import 'package:mahu_home_services_app/features/user_booking/widgets/favorite_button.dart';
import 'package:mahu_home_services_app/features/user_booking/widgets/home_appbar_leading_widget.dart';
import 'package:mahu_home_services_app/features/user_booking/widgets/home_section_label_text.dart';
import 'package:mahu_home_services_app/features/user_booking/widgets/label_with_view_all_button_widget.dart';
import 'package:mahu_home_services_app/features/user_booking/widgets/popular_service_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150.w,
        // titleSpacing: AppConst.appPadding.w,
        leading: const HomeAppbarLeadingWidget(),
        actions: [
          IconButton.filled(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(AppColors.greyBack),
            ),
            onPressed: () {},
            icon: const Badge(
              padding: EdgeInsets.all(-1),
              alignment: Alignment(1, -1),
              child: Icon(
                Icons.notifications_outlined,
              ),
            ),
          ),
          Gap(AppConst.appPadding.w),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConst.appPadding.w),
        child: ListView(
          children: [
            SizedBox(
              height: 46.h,
              child: TextFormField(
                controller: TextEditingController(),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black.withOpacity(.5),
                  ),
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    // height: ,
                    color: Colors.black.withOpacity(.5),
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                  ),
                  filled: true,
                  fillColor: AppColors.greyBack,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Gap(16.h),
            const HomeSectionLabelText(
              txt: 'Special Offer',
            ),
            Gap(5.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                'assets/imgs/discount.PNG',
                height: 150.h,
              ),
            ),
            Gap(5.h),
            Center(
              child: SmoothPageIndicator(
                controller: PageController(), // PageController
                count: 3,
                effect: WormEffect(
                  activeDotColor: AppColors.blue,
                  dotColor: AppColors.greyBack,
                  dotWidth: 10.h,
                  dotHeight: 10.h,
                ), // your preferred effect
                onDotClicked: (index) {},
              ),
            ),
            Gap(16.h),
            const HomeSectionLabelText(
              txt: 'Categories',
            ),
            Gap(16.h),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoriesItem(
                  icon: Icons.cleaning_services_outlined,
                  txt: 'Cleaning',
                ),
                CategoriesItem(
                  icon: Icons.home_repair_service_outlined,
                  txt: 'Repairing',
                ),
                CategoriesItem(
                  icon: Icons.colorize,
                  txt: 'Painting',
                ),
                CategoriesItem(
                  icon: Icons.more_horiz,
                  txt: 'More',
                ),
              ],
            ),
            Gap(16.h),
            LabelWithViewAllButtonWidget(
              label: 'Popular Services',
              onPressed: () {},
            ),
            Gap(16.h),
            SizedBox(
              height: 170.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  PopularServiceCard(
                    imgPath: 'assets/imgs/home_cleaning.jpg',
                    txt: 'Home Cleaning',
                    onTap: () {
                      navigateTo(context, const ServiceDetailsScreen());
                    },
                  ),
                  PopularServiceCard(
                    imgPath: 'assets/imgs/home_repairing.jpg',
                    txt: 'Home Repairing',
                    onTap: () {
                      navigateTo(context, const ServiceDetailsScreen());
                    },
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
