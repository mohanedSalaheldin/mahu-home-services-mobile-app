import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/constants/colors.dart';
import 'package:mahu_home_services_app/core/utils/helpers/cache_helper.dart';
import 'package:mahu_home_services_app/core/utils/navigation_utils.dart';
import 'package:mahu_home_services_app/features/auth/client_auth/views/screens/login_screen.dart';
import 'package:mahu_home_services_app/features/landing/views/screens/choose_rule_screen.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/app_filled_button.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/have_or_not_an_account_row.dart';

class LandingScren2 extends StatelessWidget {
  const LandingScren2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            decoration: const BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: Image.asset(
                height: 425.h,
                fit: BoxFit.cover,
                'assets/imgs/landing/landing3.jpg',
                width: double.infinity,
              ),
            ),
          ),
          Gap(55.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppConst.appPadding.w),
            child: Column(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Let\'s Try the ',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                      color: Colors.black,
                    ),
                    children: const <TextSpan>[
                      TextSpan(
                        text: 'Professional & Truth',
                        style: TextStyle(
                          color: AppColors.blue,
                        ),
                      ),
                      TextSpan(text: ' Cleaning Service'),
                    ],
                  ),
                ),
                Gap(10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: Text(
                    'here you can find all the services with best prices',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      color: Colors.black.withOpacity(.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Gap(33.h),
                AppFilledButton(
                  onPressed: () async {
                    await CacheHelper.saveBool('first_time', false);

                    if (context.mounted) {
                      navigateTo(context, const RoleSelectionScreen());
                    }
                  },
                  text: 'Let\'s Get Started',
                ),
                // const Spacer(),
                // HaveOrNotAnAccountRow(
                //   questionTxt: 'Already have an account ?',
                //   buttonTxt: 'Login',
                //   onPresseButton: () async {
                //     await CacheHelper.saveBool('first_time', false);
                //     if (context.mounted) {
                //       navigateTo(context, const LoginScreen());
                //     }
                //   },
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
