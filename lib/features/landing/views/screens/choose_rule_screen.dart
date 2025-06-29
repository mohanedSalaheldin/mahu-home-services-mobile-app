import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mahu_home_services_app/core/constants/app_const.dart';
import 'package:mahu_home_services_app/core/utils/helpers/helping_functions.dart';
import 'package:mahu_home_services_app/features/auth/views/screens/register_screen.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/next_button.dart';
import 'package:mahu_home_services_app/features/landing/views/widgets/user_rule_item.dart';

class ChooseRuleScreen extends StatefulWidget {
  const ChooseRuleScreen({super.key});

  @override
  State<ChooseRuleScreen> createState() => _ChooseRuleScreenState();
}

var isUser = true;

class _ChooseRuleScreenState extends State<ChooseRuleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppConst.appPadding.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: double.infinity),
              Gap(100.h),
              Text(
                'Choose Your Role',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30.sp,
                  color: Colors.black,
                ),
              ),
              Gap(70.h),
              UserRuleItem(
                txt: 'User',
                icon: 'assets/icons/user_rule.png',
                hasBorder: isUser,
                onTap: () {
                  setState(() {
                    isUser = true;
                  });
                },
              ),
              Gap(66.h),
              UserRuleItem(
                txt: 'Service Provider',
                icon: 'assets/icons/provider_rule.png',
                hasBorder: !isUser,
                onTap: () {
                  setState(() {
                    isUser = false;
                  });
                },
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  NextButton(
                    onTap: () {
                      navigateTo(context,  RegisterScreen());
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
